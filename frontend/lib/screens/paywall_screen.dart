import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../core/app_colors.dart';
import '../providers/auth_provider.dart' as core;
import '../services/revenue_cat_service.dart';

class PaywallScreen extends StatefulWidget {
  final String? triggerReason;
  const PaywallScreen({super.key, this.triggerReason});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  Offerings? _offerings;
  Package? _selectedPackage;
  bool _loadingOfferings = true;
  bool _purchasing = false;
  bool _restoring = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    setState(() => _loadingOfferings = true);
    final offerings = await RevenueCatService.fetchOfferings();
    if (!mounted) return;
    setState(() {
      _offerings = offerings;
      _loadingOfferings = false;
      // Default: pre-select the annual package (best value)
      if (offerings?.current != null) {
        _selectedPackage =
            offerings!.current!.annual ?? offerings.current!.monthly;
      }
    });
  }

  // ── Purchase flow ─────────────────────────────────────────────────────────

  Future<void> _purchase() async {
    final pkg = _selectedPackage;
    if (pkg == null) return;

    setState(() {
      _purchasing = true;
      _error = null;
    });

    final result = await RevenueCatService.purchasePackage(pkg);

    if (!mounted) return;

    if (result.success) {
      // Sync the premium status into AuthProvider (updates Firestore + UI)
      await context.read<core.AuthProvider>().syncPremiumStatus();
      if (!mounted) return;
      Navigator.pop(context);
      _showSnack('Welcome to CORE Premium!', success: true);
    } else if (result.error != null) {
      setState(() {
        _error = result.error;
        _purchasing = false;
      });
    } else {
      setState(() => _purchasing = false); // User cancelled — no message
    }
  }

  Future<void> _restore() async {
    setState(() {
      _restoring = true;
      _error = null;
    });

    final result = await RevenueCatService.restorePurchases();

    if (!mounted) return;

    if (result.success) {
      await context.read<core.AuthProvider>().syncPremiumStatus();
      if (!mounted) return;
      Navigator.pop(context);
      _showSnack('Purchases restored!', success: true);
    } else {
      setState(() {
        _error = result.error;
        _restoring = false;
      });
    }
  }

  void _showSnack(String message, {required bool success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? AppColors.surface : const Color(0xFFFF3B30),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ── UI ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Background glow
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.close_rounded,
                            color: AppColors.textMuted, size: 18),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Trigger chip
                        if (widget.triggerReason != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      AppColors.accent.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              widget.triggerReason!,
                              style: const TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ).animate().fadeIn(duration: 400.ms),

                        const SizedBox(height: 20),

                        // Headline
                        ShaderMask(
                          shaderCallback: (b) => const LinearGradient(
                            colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
                          ).createShader(b),
                          child: const Text(
                            'Go\nPremium.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        )
                            .animate(delay: 100.ms)
                            .fadeIn(duration: 500.ms)
                            .slideY(begin: 0.2, end: 0),

                        const SizedBox(height: 12),

                        const Text(
                          'Unlimited access to all philosophies,\nunlimited AI diagnoses, zero limits.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

                        const SizedBox(height: 28),

                        // Feature list
                        ..._features.asMap().entries.map((e) => _FeatureRow(
                              icon: e.value.$1,
                              title: e.value.$2,
                              subtitle: e.value.$3,
                              delay: 300 + e.key * 80,
                            )),

                        const SizedBox(height: 28),

                        // Pricing options
                        _loadingOfferings
                            ? _PricingSkeleton()
                            : _offerings?.current == null
                                ? _FallbackPricingCard(
                                    selected: _selectedPackage,
                                    onSelect: (p) =>
                                        setState(() => _selectedPackage = p),
                                  )
                                : _PricingOptions(
                                    offering: _offerings!.current!,
                                    selected: _selectedPackage,
                                    onSelect: (p) =>
                                        setState(() => _selectedPackage = p),
                                  ),

                        const SizedBox(height: 20),

                        // Error message
                        if (_error != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              _error!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color(0xFFFF6B6B), fontSize: 13),
                            ),
                          ),

                        // CTA button
                        _UnlockButton(
                          loading: _purchasing,
                          disabled:
                              _selectedPackage == null || _loadingOfferings,
                          onTap: _purchase,
                        ).animate(delay: 800.ms).fadeIn(duration: 500.ms),

                        const SizedBox(height: 12),

                        // Restore + legal
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _restoring ? null : _restore,
                              child: _restoring
                                  ? const SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                          color: AppColors.textMuted),
                                    )
                                  : const Text(
                                      'Restore purchases',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.textMuted,
                                      ),
                                    ),
                            ),
                            const Text(
                              '  ·  ',
                              style: TextStyle(
                                  color: AppColors.textMuted, fontSize: 12),
                            ),
                            const Text(
                              'Cancel anytime',
                              style: TextStyle(
                                  color: AppColors.textMuted, fontSize: 12),
                            ),
                          ],
                        ).animate(delay: 950.ms).fadeIn(duration: 400.ms),

                        const SizedBox(height: 8),

                        const Center(
                          child: Text(
                            'Billed via App Store / Google Play.\n'
                            'Subscription renews automatically until cancelled.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 10,
                                height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const List<(String, String, String)> _features = [
    (
      '⚡',
      'Unlimited AI Diagnoses',
      'No daily cap — diagnose as much as you need'
    ),
    (
      '📚',
      'Full Philosophy Library',
      'All 30 isms unlocked with deep insights'
    ),
    ('🎨', 'Exclusive AI Art', 'Unique generative art for every philosophy'),
    ('📊', 'Advanced Analytics', 'Track your philosophy patterns over time'),
    ('🔥', 'Priority AI', 'Faster responses, better AI model access'),
  ];
}

// ── Pricing options (live from RevenueCat) ────────────────────────────────────

class _PricingOptions extends StatelessWidget {
  final Offering offering;
  final Package? selected;
  final ValueChanged<Package?> onSelect;

  const _PricingOptions({
    required this.offering,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final packages = <Package?>[offering.annual, offering.monthly]
        .whereType<Package>()
        .toList();

    if (packages.isEmpty) {
      return _FallbackPricingCard(selected: selected, onSelect: onSelect);
    }

    return Column(
      children: packages.map((pkg) {
        final isAnnual = pkg.packageType == PackageType.annual;
        final isSelected = selected?.identifier == pkg.identifier;
        final price = pkg.storeProduct.priceString;

        return GestureDetector(
          onTap: () => onSelect(pkg),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(colors: [
                      AppColors.accent.withValues(alpha: 0.18),
                      AppColors.teal.withValues(alpha: 0.08),
                    ])
                  : null,
              color: isSelected ? null : AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected
                    ? AppColors.accent.withValues(alpha: 0.6)
                    : AppColors.border,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            isAnnual ? 'Annual' : 'Monthly',
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          if (isAnnual) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.gold.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color:
                                        AppColors.gold.withValues(alpha: 0.4)),
                              ),
                              child: const Text(
                                'SAVE 44%',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        isAnnual
                            ? 'Full year · billed annually'
                            : 'Billed every month',
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  isAnnual ? price : price,
                  style: TextStyle(
                    color:
                        isSelected ? AppColors.accent : AppColors.textSecondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Outfit',
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Fallback when RevenueCat is not yet configured ────────────────────────────

class _FallbackPricingCard extends StatelessWidget {
  final Package? selected;
  final ValueChanged<Package?> onSelect;

  const _FallbackPricingCard({
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.15),
            AppColors.teal.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.4), width: 1.5),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CORE Premium',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$2.99',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 6),
              Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  '/ month',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            'Or \$19.99/year — save 44%',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Payments coming soon — configure RevenueCat to enable.',
            style: TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ── Loading skeleton ──────────────────────────────────────────────────────────

class _PricingSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          2,
          (i) => Container(
                height: 80,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .shimmer(duration: 1200.ms, color: AppColors.surfaceGlass)),
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────────

class _FeatureRow extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final int delay;

  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGlow),
            ),
            child: Center(
              child: Text(icon, style: const TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      height: 1.4,
                    )),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded,
              color: AppColors.accent, size: 18),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.1, end: 0);
  }
}

class _UnlockButton extends StatelessWidget {
  final bool loading;
  final bool disabled;
  final VoidCallback onTap;

  const _UnlockButton({
    required this.loading,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (loading || disabled) ? null : onTap,
      child: AnimatedOpacity(
        opacity: disabled ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Text(
                    'UNLOCK PREMIUM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      fontFamily: 'Outfit',
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
