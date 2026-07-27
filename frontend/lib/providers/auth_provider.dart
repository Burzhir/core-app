import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../services/revenue_cat_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _google = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthStatus _status = AuthStatus.unknown;
  UserModel? _user;
  String? _error;
  bool _loading = false;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get error => _error;
  bool get loading => _loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isPremium => _user?.isPremium ?? false;
  int get currentStreak => _user?.currentStreak ?? 0;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Auth state listener
  // ───────────────────────────────────────────────────────────────────────────

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.unauthenticated;
      _user = null;
      await RevenueCatService.logoutUser();
    } else {
      await _loadOrCreateUser(firebaseUser);
      await _updateStreak(); // Update streak on login
      await RevenueCatService.loginUser(firebaseUser.uid);
      await syncPremiumStatus(); // Fetch latest premium status
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> _loadOrCreateUser(User firebaseUser) async {
    try {
      final doc = await _db.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists && doc.data() != null) {
        _user = UserModel.fromMap(doc.data()!, firebaseUser.uid);
      } else {
        final newUser = UserModel(
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName,
          email: firebaseUser.email,
          photoUrl: firebaseUser.photoURL,
          createdAt: DateTime.now(),
        );
        await _db
            .collection('users')
            .doc(firebaseUser.uid)
            .set(newUser.toMap());
        _user = newUser;
      }
    } catch (e) {
      debugPrint('AuthProvider: error loading user — $e');
    }
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Sign in / out
  // ───────────────────────────────────────────────────────────────────────────

  Future<bool> signInWithGoogle() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final googleUser = await _google.signIn();
      if (googleUser == null) {
        _loading = false;
        notifyListeners();
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      _loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Sign-in failed. Please try again.';
      _loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('AuthProvider: Firebase signOut error — $e');
    } finally {
      // Always try to sign out of Google, even if Firebase signOut failed
      try {
        await _google.signOut();
      } catch (e) {
        debugPrint('AuthProvider: Google signOut error — $e');
      }
    }
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Premium status sync
  // ───────────────────────────────────────────────────────────────────────────

  Future<void> syncPremiumStatus() async {
    final u = _user;
    if (u == null) return;

    final hasPremium = await RevenueCatService.checkPremium();
    if (hasPremium == u.isPremium) return;

    // Only update in-memory — isPremium in Firestore should be managed by
    // RevenueCat webhooks on the backend, not written from the client.
    // Writing it from the client allows any user to spoof premium status.
    _user = u.copyWith(isPremium: hasPremium);
    notifyListeners();
  }

  /// Call this whenever the app becomes active (initState, on resume)
  Future<void> refreshStreakAndPremium() async {
    if (_user == null) return;
    await _updateStreak();
    await syncPremiumStatus();
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Freemium: daily AI message quota
  // ───────────────────────────────────────────────────────────────────────────

  Future<void> consumeAiMessage() async {
    final u = _user;
    if (u == null || u.isPremium) return;

    final today = _todayStr();
    final newCount =
        (u.lastAiMessageDate == today ? u.dailyAiMessagesUsed : 0) + 1;

    final updated = u.copyWith(
      dailyAiMessagesUsed: newCount,
      lastAiMessageDate: today,
    );

    try {
      await _db.collection('users').doc(u.uid).update({
        'dailyAiMessagesUsed': newCount,
        'lastAiMessageDate': today,
      });
      _user = updated;
      notifyListeners();
    } catch (e) {
      debugPrint('AuthProvider: error recording AI message — $e');
    }
  }

  int get remainingAiMessagesToday {
    final u = _user;
    if (u == null) return 0;
    if (u.isPremium) return 999;
    final today = _todayStr();
    final used = u.lastAiMessageDate == today ? u.dailyAiMessagesUsed : 0;
    return (UserModel.freeAiDailyLimit - used)
        .clamp(0, UserModel.freeAiDailyLimit);
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Streak logic
  // ───────────────────────────────────────────────────────────────────────────

  Future<void> _updateStreak() async {
    final u = _user;
    if (u == null) return;

    final today = _todayStr();

    // Already updated today → skip
    if (u.lastOpenedDate == today) return;

    final yesterday = _yesterdayStr();
    final newStreak = u.lastOpenedDate == yesterday ? u.currentStreak + 1 : 1;

    try {
      await _db.collection('users').doc(u.uid).update({
        'currentStreak': newStreak,
        'lastOpenedDate': today,
      });
      _user = u.copyWith(
        currentStreak: newStreak,
        lastOpenedDate: today,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('AuthProvider: error updating streak — $e');
    }
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Helpers
  // ───────────────────────────────────────────────────────────────────────────

  String _todayStr() {
    final now = DateTime.now();
    return '${now.year}'
        '-${now.month.toString().padLeft(2, '0')}'
        '-${now.day.toString().padLeft(2, '0')}';
  }

  String _yesterdayStr() {
    final y = DateTime.now().subtract(const Duration(days: 1));
    return '${y.year}'
        '-${y.month.toString().padLeft(2, '0')}'
        '-${y.day.toString().padLeft(2, '0')}';
  }
}
