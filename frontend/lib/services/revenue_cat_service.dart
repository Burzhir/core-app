import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../core/secrets.dart';

/// RevenueCat service — single entry point for all subscription logic.
///
/// SETUP CHECKLIST (do this once):
/// 1. Create a RevenueCat account at revenuecat.com (free)
/// 2. Create a new Project → name it "CORE"
/// 3. Add an App for Android (and/or iOS)
/// 4. Copy your API keys into the constants below
/// 5. Create an Entitlement called "premium"
/// 6. Create two Products in App Store / Play Store (see SETUP.md)
/// 7. Attach those products to the "premium" entitlement
class RevenueCatService {
  RevenueCatService._();

  // ── ⚙️  PASTE YOUR KEYS HERE ──────────────────────────────────────────────
  // Get these from: RevenueCat Dashboard → Project → Apps → [your app] → API Key
  static const String _androidApiKey = Secrets.revenueCatAndroidKey;
  static const String _iosApiKey     = Secrets.revenueCatIosKey;

  // ── Product IDs — must match exactly what you create in the stores ────────
  // You will create these in Google Play Console / App Store Connect
  static const String monthlyProductId = 'core_premium_monthly';
  static const String annualProductId  = 'core_premium_annual';

  // ── Entitlement ID — must match what you create in RevenueCat dashboard ───
  static const String entitlementId = 'premium';

  // ─────────────────────────────────────────────────────────────────────────

  static bool _initialized = false;

  static bool get _hasConfiguredKeys {
    const placeholder = 'PASTE_YOUR_REVENUECAT';
    return !_androidApiKey.contains(placeholder) &&
        !_iosApiKey.contains(placeholder);
  }

  /// Call this once in main() after Firebase.initializeApp()
  static Future<void> initialize() async {
    if (_initialized) return;

    if (!_hasConfiguredKeys) {
      debugPrint(
        'RevenueCat: skipping init — paste your API keys in lib/core/secrets.dart',
      );
      return;
    }

    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    final PurchasesConfiguration config;

    if (defaultTargetPlatform == TargetPlatform.android) {
      config = PurchasesConfiguration(_androidApiKey);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      config = PurchasesConfiguration(_iosApiKey);
    } else {
      // Web / desktop — not supported by RevenueCat
      return;
    }

    await Purchases.configure(config);
    _initialized = true;
  }

  /// Log in the RevenueCat user with the same UID as Firebase.
  /// This links purchases to the correct user account.
  static Future<void> loginUser(String uid) async {
    if (!_initialized) return;
    try {
      await Purchases.logIn(uid);
    } catch (e) {
      debugPrint('RevenueCat: login error — $e');
    }
  }

  /// Log out (call when user signs out of the app).
  static Future<void> logoutUser() async {
    if (!_initialized) return;
    try {
      await Purchases.logOut();
    } catch (e) {
      debugPrint('RevenueCat: logout error — $e');
    }
  }

  /// Returns true if the current user has an active premium subscription.
  static Future<bool> checkPremium() async {
    if (!_initialized) return false;
    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey(entitlementId);
    } catch (e) {
      debugPrint('RevenueCat: checkPremium error — $e');
      return false;
    }
  }

  /// Fetches the available subscription packages from RevenueCat.
  /// Returns null if offerings cannot be loaded.
  static Future<Offerings?> fetchOfferings() async {
    if (!_initialized) return null;
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('RevenueCat: fetchOfferings error — $e');
      return null;
    }
  }

  /// Attempts to purchase [package]. Returns true on success.
  /// Returns false if the user cancelled or if there's an error.
  static Future<({bool success, String? error})> purchasePackage(
      Package package) async {
    if (!_initialized) {
      return (success: false, error: 'Payments not available.');
    }
    try {
      final info = await Purchases.purchasePackage(package);
      final hasPremium = info.entitlements.active.containsKey(entitlementId);
      return (success: hasPremium, error: null);
    } on PurchasesError catch (e) {
      if (e.code == PurchasesErrorCode.purchaseCancelledError) {
        return (success: false, error: null); // User cancelled — no message
      }
      return (success: false, error: _userFriendlyError(e));
    } catch (e) {
      debugPrint('RevenueCat: unexpected purchase error — $e');
      return (success: false, error: 'Something went wrong. Please try again.');
    }
  }

  /// Restores previous purchases (required by App Store policy).
  static Future<({bool success, String? error})> restorePurchases() async {
    if (!_initialized) {
      return (success: false, error: 'Payments not available.');
    }
    try {
      final info = await Purchases.restorePurchases();
      final hasPremium = info.entitlements.active.containsKey(entitlementId);
      return (
        success: hasPremium,
        error: hasPremium ? null : 'No previous purchases found.',
      );
    } catch (e) {
      debugPrint('RevenueCat: restorePurchases error — $e');
      return (success: false, error: 'Could not restore purchases.');
    }
  }

  static String _userFriendlyError(PurchasesError e) {
    switch (e.code) {
      case PurchasesErrorCode.networkError:
        return 'No internet connection. Please try again.';
      case PurchasesErrorCode.paymentPendingError:
        return 'Payment pending. Check your payment method.';
      case PurchasesErrorCode.productAlreadyPurchasedError:
        return 'Already purchased! Try "Restore Purchases".';
      default:
        return 'Purchase failed. Please try again.';
    }
  }
}
