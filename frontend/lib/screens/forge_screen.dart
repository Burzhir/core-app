import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../widgets/tappable.dart';
import 'comparison_screen.dart';
import 'ai_chat_screen.dart';

class ForgeScreen extends StatelessWidget {
  const ForgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FORGE',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                        fontFamily: 'Outfit',
                      ),
                    ).animate().fadeIn(duration: 400.ms),
                    const SizedBox(height: 6),
                    const Text(
                      'Tools to think differently',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Outfit',
                        height: 1.2,
                      ),
                    ).animate(delay: 80.ms).fadeIn(duration: 400.ms),
                    const SizedBox(height: 6),
                    const Text(
                      'Compare how different philosophies approach your situation, or talk directly with an AI philosopher.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ).animate(delay: 160.ms).fadeIn(duration: 400.ms),
                  ],
                ),
              ),
            ),

            // ── Cards ─────────────────────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _ToolCard(
                    icon: Icons.compare_arrows_rounded,
                    iconColor: AppColors.teal,
                    title: 'Compare Philosophies',
                    subtitle:
                        'Pick a situation you\'re facing and see how Stoicism, Buddhism, Existentialism — and 9 others — would approach it.',
                    badge: '8 situations',
                    badgeColor: AppColors.teal,
                    onTap: () => Navigator.of(context).push(
                      _fadeRoute(const ComparisonScreen()),
                    ),
                    gradient: const [Color(0xFF00B4D8), Color(0xFF0077B6)],
                    preview: const _ComparePreview(),
                    animDelay: 240,
                  ),
                  const SizedBox(height: 20),
                  _ToolCard(
                    icon: Icons.chat_bubble_outline_rounded,
                    iconColor: AppColors.accent,
                    title: 'AI Philosopher',
                    subtitle:
                        'Have a real conversation. Pick any philosophy and ask it anything — about your life, your choices, or just ideas.',
                    badge: '12 philosophers',
                    badgeColor: AppColors.accent,
                    onTap: () => Navigator.of(context).push(
                      _fadeRoute(const AiChatScreen()),
                    ),
                    gradient: const [Color(0xFFBF5AF2), Color(0xFF5E5CE6)],
                    preview: const _AiPreview(),
                    animDelay: 340,
                  ),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

PageRouteBuilder _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final tween = Tween(begin: const Offset(0.0, 0.05), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOutCubic));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: animation.drive(tween), child: child),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}

// ── Tool card ─────────────────────────────────────────────────────────────

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String badge;
  final Color badgeColor;
  final VoidCallback onTap;
  final List<Color> gradient;
  final Widget preview;
  final int animDelay;

  const _ToolCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.badgeColor,
    required this.onTap,
    required this.gradient,
    required this.preview,
    required this.animDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Tappable(
      scale: 0.97,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withValues(alpha: 0.10),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top gradient strip
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon + badge row
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              gradient[0].withValues(alpha: 0.25),
                              gradient[1].withValues(alpha: 0.15),
                            ],
                          ),
                          border: Border.all(
                              color: gradient[0].withValues(alpha: 0.4)),
                        ),
                        child: Icon(icon, color: iconColor, size: 22),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: badgeColor.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          badge,
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  preview,

                  const SizedBox(height: 18),

                  // CTA
                  Row(
                    children: [
                      Text(
                        'Get started',
                        style: TextStyle(
                          color: gradient[0],
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded,
                          color: gradient[0], size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: animDelay))
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.08, end: 0);
  }
}

// ── Compare preview ───────────────────────────────────────────────────────

class _ComparePreview extends StatelessWidget {
  const _ComparePreview();

  static const _situations = [
    'Going through a breakup',
    'Dealing with failure',
    'Feeling lost'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent situations',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          ..._situations.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.teal, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      s,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ── AI preview ────────────────────────────────────────────────────────────

class _AiPreview extends StatelessWidget {
  const _AiPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withValues(alpha: 0.15),
                  border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.4)),
                ),
                child: const Icon(Icons.psychology_alt_rounded,
                    color: AppColors.accent, size: 14),
              ),
              const SizedBox(width: 8),
              const Text(
                'Marcus Aurelius (Stoicism)',
                style:
                    TextStyle(color: AppColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '"What unsettles you today? Name it — and then let us examine whether it is truly within your power."',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
