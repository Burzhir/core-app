import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:share_plus/share_plus.dart';
import '../core/app_colors.dart';
import '../widgets/cosmic_background.dart';
import '../widgets/tappable.dart';
import '../data/philosophies_data.dart';
import '../providers/auth_provider.dart' as core;
import 'philosophy_detail_screen.dart';
import 'forge_screen.dart';
import 'package:provider/provider.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    final auth = context.read<core.AuthProvider>();
    await auth.syncPremiumStatus();
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<core.AuthProvider>(context);
    final streak = auth.currentStreak;
    final today = DateTime.now();
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayName = weekdays[today.weekday - 1];
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final dateStr = '$dayName, ${months[today.month - 1]} ${today.day}';
    final dayOfYear = today.difference(DateTime(today.year)).inDays;
    final featured = kPhilosophies[dayOfYear % kPhilosophies.length];
    final daily =
        featured.dailyContent[dayOfYear % featured.dailyContent.length];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          CosmicBackground(accentColors: featured.gradient),
          SafeArea(
            child: RefreshIndicator(
              key: _refreshKey,
              color: AppColors.accent,
              backgroundColor: AppColors.surface,
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: [
                  // ── Header ──────────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dateStr,
                                        style: const TextStyle(
                                          color: AppColors.textMuted,
                                          fontSize: 12,
                                          letterSpacing: 1.5,
                                        ))
                                    .animate()
                                    .fadeIn(duration: 500.ms),
                                const SizedBox(height: 4),
                                const Text('Today',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Outfit',
                                        ))
                                    .animate(delay: 100.ms)
                                    .fadeIn(duration: 500.ms),
                              ],
                            ),
                          ),
                          if (streak > 0) ...[
                            _StreakBadge(streak: streak),
                            const SizedBox(width: 10),
                          ],
                          const _QuickForgeButton(),
                        ],
                      ),
                    ),
                  ),

                  // ── Featured philosophy card ─────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Tappable(
                        scale: 0.97,
                        onTap: () => Navigator.push(
                          context,
                          _slideRoute(
                              PhilosophyDetailScreen(philosophy: featured)),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                featured.gradient[0].withValues(alpha: 0.25),
                                featured.gradient[1].withValues(alpha: 0.15),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: featured.gradient[0]
                                    .withValues(alpha: 0.4)),
                          ),
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(featured.emoji,
                                      style: const TextStyle(fontSize: 24)),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Today\'s philosophy',
                                          style: TextStyle(
                                              color: AppColors.textMuted,
                                              fontSize: 11,
                                              letterSpacing: 1.5)),
                                      Text(featured.name,
                                          style: const TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'Outfit',
                                          )),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColors.textMuted,
                                      size: 14),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(featured.tagline,
                                  style: TextStyle(
                                    color: featured.gradient[0],
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  )),
                            ],
                          ),
                        ),
                      )
                          .animate(delay: 200.ms)
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.1, end: 0),
                    ),
                  ),

                  // ── Quote ───────────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: _SectionCard(
                        title: 'Quote',
                        accentColor: AppColors.gold,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('"',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900,
                                  height: 0.8,
                                )),
                            const SizedBox(height: 6),
                            Text(daily.quote,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  height: 1.6,
                                )),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text('— ${daily.quoteAuthor}',
                                    style: const TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 12,
                                    )),
                                const Spacer(),
                                Tappable(
                                  scale: 0.93,
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    Share.share(
                                      '"${daily.quote}"\n— ${daily.quoteAuthor}\n\nFrom the CORE app',
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.gold
                                          .withValues(alpha: 0.12),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.gold
                                              .withValues(alpha: 0.25)),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.ios_share_rounded,
                                            color: AppColors.gold, size: 13),
                                        SizedBox(width: 5),
                                        Text('Share',
                                            style: TextStyle(
                                              color: AppColors.gold,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ).animate(delay: 300.ms).fadeIn(duration: 500.ms),
                  ),

                  // ── Reflection ──────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      child: _SectionCard(
                        title: '🔍  Reflection',
                        accentColor: AppColors.teal,
                        child: Text(daily.reflectionQuestion,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                              height: 1.6,
                            )),
                      ),
                    ).animate(delay: 400.ms).fadeIn(duration: 500.ms),
                  ),

                  // ── Action challenge ─────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      child: _SectionCard(
                        title: '⚡  Action Challenge',
                        accentColor: AppColors.accent,
                        child: Text(daily.actionChallenge,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                              height: 1.6,
                            )),
                      ),
                    ).animate(delay: 500.ms).fadeIn(duration: 500.ms),
                  ),

                  // ── More philosophies ────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('More philosophies',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                letterSpacing: 1.5,
                              )),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: kPhilosophies.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, i) {
                                final p = kPhilosophies[i];
                                return Tappable(
                                  scale: 0.93,
                                  onTap: () => Navigator.push(
                                    context,
                                    _slideRoute(
                                        PhilosophyDetailScreen(philosophy: p)),
                                  ),
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        p.gradient[0].withValues(alpha: 0.18),
                                        p.gradient[1].withValues(alpha: 0.08),
                                      ]),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: p.gradient[0]
                                              .withValues(alpha: 0.3)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(p.emoji,
                                            style: const TextStyle(
                                                fontSize: 22)),
                                        const SizedBox(height: 4),
                                        Text(
                                          p.name,
                                          style: const TextStyle(
                                            color: AppColors.textMuted,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ).animate(delay: 600.ms).fadeIn(duration: 500.ms),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Page transition helper ─────────────────────────────────────────────────

PageRouteBuilder _slideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) {
      final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeOutCubic));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
    transitionDuration: const Duration(milliseconds: 320),
  );
}

// ── Streak badge ──────────────────────────────────────────────────────────

class _StreakBadge extends StatelessWidget {
  final int streak;
  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B00), Color(0xFFFF3B00)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B00).withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'Outfit',
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }
}

// ── Quick forge button ────────────────────────────────────────────────────

class _QuickForgeButton extends StatelessWidget {
  const _QuickForgeButton();

  @override
  Widget build(BuildContext context) {
    return Tappable(
      scale: 0.92,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ForgeScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.compare_arrows_rounded,
                color: AppColors.accent, size: 14),
            SizedBox(width: 6),
            Text('Forge',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}

// ── Section card ──────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.accentColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                color: accentColor,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              )),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
