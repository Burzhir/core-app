import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../models/philosophy_model.dart';
import 'maya_chat_screen.dart';

class PhilosophyDetailScreen extends StatelessWidget {
  final PhilosophyModel philosophy;
  const PhilosophyDetailScreen({super.key, required this.philosophy});

  @override
  Widget build(BuildContext context) {
    final p = philosophy;
    final daily = p.todayContent;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          // ── Hero header ─────────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: AppColors.bg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: AppColors.textPrimary),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      p.gradient[0].withValues(alpha: 0.3),
                      p.gradient[1].withValues(alpha: 0.15),
                      AppColors.bg,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.emoji, style: const TextStyle(fontSize: 48)),
                        const SizedBox(height: 8),
                        Text(p.name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Outfit',
                            )),
                        const SizedBox(height: 6),
                        Text(p.tagline,
                            style: TextStyle(
                              color: p.gradient[0],
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Overview
                _Section(
                  title: 'OVERVIEW',
                  color: p.gradient[0],
                  child: Text(p.overview,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.75,
                      )),
                ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 16),

                // Core beliefs
                _Section(
                  title: 'CORE BELIEFS',
                  color: p.gradient[0],
                  child: Column(
                    children: p.coreBeliefs
                        .map((b) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(
                                        top: 6, right: 10),
                                    decoration: BoxDecoration(
                                      color: p.gradient[0],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(b,
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 14,
                                          height: 1.6,
                                        )),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 16),

                // Key thinkers
                _Section(
                  title: 'KEY THINKERS',
                  color: AppColors.gold,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: p.keyThinkers
                        .map((t) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceAlt,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(t,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ))
                        .toList(),
                  ),
                ).animate(delay: 300.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 16),

                // Practical application
                _Section(
                  title: 'IN REAL LIFE',
                  color: AppColors.teal,
                  child: Text(p.practicalApplication,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.75,
                      )),
                ).animate(delay: 400.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 16),

                // Criticisms
                _Section(
                  title: 'CRITICISMS',
                  color: const Color(0xFFFF9500),
                  child: Text(p.criticisms,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.75,
                      )),
                ).animate(delay: 500.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 16),

                // Today's entry
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        p.gradient[0].withValues(alpha: 0.18),
                        p.gradient[1].withValues(alpha: 0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: p.gradient[0].withValues(alpha: 0.35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TODAY\'S PRACTICE',
                          style: TextStyle(
                            color: p.gradient[0],
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          )),
                      const SizedBox(height: 14),
                      Text('"${daily.quote}"',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          )),
                      const SizedBox(height: 4),
                      Text('— ${daily.quoteAuthor}',
                          style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 12)),
                      const SizedBox(height: 14),
                      _PracticeRow(
                        icon: '🔍',
                        label: 'Reflect',
                        text: daily.reflectionQuestion,
                      ),
                      const SizedBox(height: 10),
                      _PracticeRow(
                        icon: '⚡',
                        label: 'Act',
                        text: daily.actionChallenge,
                      ),
                    ],
                  ),
                ).animate(delay: 600.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 24),

                // Discuss with Maya Button
                GestureDetector(
                  onTap: () {
                    // Navigate to Maya chat with a prefilled prompt
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MayaChatScreen(
                          initialPrompt:
                              "I'm reading about ${p.name}. Can you explain its core ideas to me simply?",
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.easeOutQuart;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                              position: animation.drive(tween), child: child);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFBF5AF2).withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text('Discuss with Maya',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            )),
                      ],
                    ),
                  ),
                ).animate(delay: 700.ms).fadeIn(duration: 400.ms),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Color color;
  final Widget child;
  const _Section(
      {required this.title, required this.color, required this.child});

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
                color: color,
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

class _PracticeRow extends StatelessWidget {
  final String icon, label, text;
  const _PracticeRow(
      {required this.icon, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  )),
              const SizedBox(height: 3),
              Text(text,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.5,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
