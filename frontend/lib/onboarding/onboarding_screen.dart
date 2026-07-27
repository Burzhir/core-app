import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_colors.dart';
import '../widgets/cosmic_background.dart';
import '../app.dart';
import '../data/comparisons_data.dart';
import '../models/comparison_model.dart';

/// First-time onboarding:
/// 1. Welcome → 2. "What are you struggling with?" → 3. Show 3 perspectives
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;
  ComparisonSituation? _selectedSituation;

  void _next() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    setState(() => _page++);
  }

  void _selectSituation(ComparisonSituation situation) {
    setState(() => _selectedSituation = situation);
    Future.delayed(const Duration(milliseconds: 200), _next);
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const CosmicBackground(),
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _WelcomePage(onNext: _next),
              _SituationPage(onSelect: _selectSituation),
              if (_selectedSituation != null)
                _PerspectivesPage(
                  situation: _selectedSituation!,
                  onFinish: _finish,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Page 1: Welcome ──────────────────────────────────────────────────────────

class _WelcomePage extends StatelessWidget {
  final VoidCallback onNext;
  const _WelcomePage({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 60, 28, 40),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [Color(0xFF3D1F6E), Color(0xFF0E0B1A)],
                ),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.7),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.4),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                ),
            const SizedBox(height: 28),
            ShaderMask(
              shaderCallback: (b) => const LinearGradient(
                colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
              ).createShader(b),
              child: const Text(
                'CORE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10,
                  fontFamily: 'Outfit',
                ),
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 600.ms),
            const SizedBox(height: 8),
            const Text(
              'Forge Yourself',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 15,
                letterSpacing: 4,
                fontFamily: 'Outfit',
              ),
            ).animate(delay: 300.ms).fadeIn(duration: 600.ms),
            const Spacer(flex: 2),
            const Text(
              'Get guidance from history\'s greatest\nphilosophical traditions.\n\nJournal, reflect, and challenge your\nthinking from multiple perspectives.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                height: 1.7,
              ),
            ).animate(delay: 500.ms).fadeIn(duration: 700.ms),
            const Spacer(flex: 3),
            _BigButton(
              label: "Let's begin",
              onTap: onNext,
              delay: 800,
            ),
            const SizedBox(height: 20),
            const Text(
              '12 philosophies · AI mentors · Daily practice',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, fontSize: 12),
            ).animate(delay: 1000.ms).fadeIn(duration: 500.ms),
          ],
        ),
      ),
    );
  }
}

// ── Page 2: Situation picker ──────────────────────────────────────────────────

class _SituationPage extends StatelessWidget {
  final ValueChanged<ComparisonSituation> onSelect;
  const _SituationPage({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What are you\nstruggling with today?',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 1.2,
                fontFamily: 'Outfit',
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            const Text(
              'Pick what feels most relevant. CORE will show you\nhow different philosophies see your situation.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 500.ms),
            const SizedBox(height: 28),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.6,
                ),
                itemCount: kComparisonSituations.length,
                itemBuilder: (context, i) {
                  final s = kComparisonSituations[i];
                  return GestureDetector(
                    onTap: () => onSelect(s),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(s.icon, style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 6),
                          Text(
                            s.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate(delay: Duration(milliseconds: 300 + i * 60))
                      .fadeIn(duration: 400.ms)
                      .scale(
                          begin: const Offset(0.95, 0.95),
                          end: const Offset(1, 1));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Page 3: Perspectives result ───────────────────────────────────────────────

class _PerspectivesPage extends StatelessWidget {
  final ComparisonSituation situation;
  final VoidCallback onFinish;

  const _PerspectivesPage({
    required this.situation,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final free = situation.perspectives.take(3).toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderGlow),
                  ),
                  child: Text(
                    '${situation.icon}  ${situation.title}',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 14),
                const Text(
                  'Three perspectives',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Outfit',
                  ),
                ).animate(delay: 100.ms).fadeIn(duration: 500.ms),
                const SizedBox(height: 4),
                const Text(
                  'Each philosophy approaches this differently. This is what CORE does.',
                  style:
                      TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ).animate(delay: 200.ms).fadeIn(duration: 500.ms),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: free.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final p = free[i];
                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(p.emoji, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 10),
                          Text(
                            p.philosophyName,
                            style: const TextStyle(
                              color: AppColors.accent,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Outfit',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        p.keyInsight,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p.perspective.split('\n\n').first,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.6,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
                    .animate(delay: Duration(milliseconds: 300 + i * 120))
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.15, end: 0);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: _BigButton(
              label: 'Enter CORE',
              onTap: onFinish,
              delay: 800,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Shared ────────────────────────────────────────────────────────────────────

class _BigButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final int delay;

  const _BigButton({
    required this.label,
    required this.onTap,
    this.delay = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              fontFamily: 'Outfit',
            ),
          ),
        ),
      ),
    ).animate(delay: Duration(milliseconds: delay)).fadeIn(duration: 500.ms);
  }
}
