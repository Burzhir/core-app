# backend/services/auth.py
import os
import json
import logging
from pathlib import Path
from dotenv import dotenv_values
from datetime import datetime

import firebase_admin
from firebase_admin import credentials, auth, firestore

logger = logging.getLogger(__name__)

# ----------------------------------------------------------------------
# 1. Load .env from the backend directory (parent of services/)
# ----------------------------------------------------------------------
BACKEND_DIR = Path(__file__).resolve().parent.parent
env_path = BACKEND_DIR / '.env'
env_vars = dotenv_values(env_path)

# ----------------------------------------------------------------------
# 2. Initialize Firebase Admin
#    Priority: FIREBASE_SERVICE_ACCOUNT env var (production) 
#              -> local serviceAccountKey.json file (local dev)
# ----------------------------------------------------------------------
db = None
cred = None

cred_json = env_vars.get('FIREBASE_SERVICE_ACCOUNT') or os.getenv('FIREBASE_SERVICE_ACCOUNT')

try:
    if cred_json:
        cred_dict = json.loads(cred_json)
        if 'private_key' in cred_dict:
            cred_dict['private_key'] = cred_dict['private_key'].replace('\\n', '\n')
        cred = credentials.Certificate(cred_dict)
        logger.info("Using FIREBASE_SERVICE_ACCOUNT from env")
    else:
        key_path = BACKEND_DIR / 'serviceAccountKey.json'
        if key_path.exists():
            cred = credentials.Certificate(str(key_path))
            logger.info("Using serviceAccountKey.json from %s", key_path)
        else:
            logger.error("No Firebase credentials found (checked env var and %s)", key_path)

    if cred:
        firebase_admin.initialize_app(cred)
        db = firestore.client()
        logger.info("Firebase Admin initialized successfully")
except Exception:
    logger.exception("Firebase Admin initialization failed")
    db = None

# ----------------------------------------------------------------------
# 3. Constants
# ----------------------------------------------------------------------
FREE_DAILY_LIMIT = 3  # number of free AI messages per day

# ----------------------------------------------------------------------
# 4. Helper – today's date string
# ----------------------------------------------------------------------
def _today_str():
    return datetime.utcnow().strftime('%Y-%m-%d')

# ----------------------------------------------------------------------
# 5. Token verification
# ----------------------------------------------------------------------
def verify_token(token: str) -> dict | None:
    if not db:
        raise RuntimeError("Firebase Admin not initialized")

    try:
        decoded = auth.verify_id_token(token)
        uid = decoded['uid']

        user_doc = db.collection('users').document(uid).get()
        if user_doc.exists:
            user_data = user_doc.to_dict()
            return {
                'uid': uid,
                'is_premium': user_data.get('isPremium', False),
                'daily_ai_messages_used': user_data.get('dailyAiMessagesUsed', 0),
                'last_ai_message_date': user_data.get('lastAiMessageDate', ''),
                'display_name': user_data.get('displayName', ''),
            }
        else:
            return {
                'uid': uid,
                'is_premium': False,
                'daily_ai_messages_used': 0,
                'last_ai_message_date': '',
                'display_name': '',
            }
    except Exception as e:
        logger.warning(f"Token verification failed: {e}")
        return None

# ----------------------------------------------------------------------
# 6. Quota management
# ----------------------------------------------------------------------
def check_and_update_quota(user_info: dict) -> tuple[bool, int]:
    if user_info.get('is_premium'):
        return True, 999

    today = _today_str()
    last_date = user_info.get('last_ai_message_date', '')

    if last_date != today:
        user_info['daily_ai_messages_used'] = 0
        user_info['last_ai_message_date'] = today
        if db:
            db.collection('users').document(user_info['uid']).update({
                'dailyAiMessagesUsed': 0,
                'lastAiMessageDate': today,
            })

    used = user_info.get('daily_ai_messages_used', 0)
    remaining = FREE_DAILY_LIMIT - used
    return remaining > 0, max(0, remaining)


def increment_usage(user_info: dict):
    if user_info.get('is_premium'):
        return

    if db:
        db.collection('users').document(user_info['uid']).update({
            'dailyAiMessagesUsed': firestore.Increment(1),
            'lastAiMessageDate': _today_str(),
        })