import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../providers/auth_provider.dart' as core;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late final AnimationController _starCtrl;
  late final AnimationController _pulseCtrl;

  static final List<_Star> _stars =
      List.generate(120, (_) => _Star(math.Random(42)));

  static const List<String> _chips = [
    'Stoicism',
    'Existentialism',
    'Buddhism',
    'Nihilism',
    'Taoism',
    'Absurdism',
  ];

  @override
  void initState() {
    super.initState();
    _starCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _starCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _starCtrl,
            builder: (_, __) => CustomPaint(
              painter: _StarFieldPainter(t: _starCtrl.value, stars: _stars),
              child: const SizedBox.expand(),
            ),
          ),
          AnimatedBuilder(
            animation: _pulseCtrl,
            builder: (_, __) {
              final p = _pulseCtrl.value;
              return Stack(
                children: [
                  Positioned(
                    top: -100 + p * 20,
                    left: -80,
                    child: _GlowOrb(
                        size: 300,
                        color: AppColors.accent,
                        opacity: 0.12 + p * 0.04),
                  ),
                  Positioned(
                    bottom: -80 + p * 15,
                    right: -60,
                    child: _GlowOrb(
                        size: 250,
                        color: AppColors.teal,
                        opacity: 0.08 + p * 0.03),
                  ),
                ],
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _buildLogo(),
                  const Spacer(flex: 2),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: _chips
                        .asMap()
                        .entries
                        .map(
                          (e) => _PhilosophyChip(
                              label: e.value, delay: e.key * 80),
                        )
                        .toList(),
                  ),
                  const Spacer(flex: 1),
                  if (auth.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        auth.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xFFFF6B6B), fontSize: 13),
                      ),
                    ),
                  _GoogleSignInButton(
                    loading: auth.loading,
                    onTap: () =>
                        context.read<core.AuthProvider>().signInWithGoogle(),
                  )
                      .animate(delay: 800.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 16),
                  const Text(
                    'By continuing, you agree to our Terms & Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textMuted, fontSize: 11, height: 1.5),
                  ).animate(delay: 1000.ms).fadeIn(duration: 500.ms),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [Color(0xFF3D1F6E), Color(0xFF0E0B1A)],
            ),
            border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.6), width: 1.5),
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
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
        const SizedBox(height: 20),
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
          ).createShader(b),
          child: const Text(
            'CORE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              letterSpacing: 12,
              fontFamily: 'Outfit',
            ),
          ),
        )
            .animate(delay: 200.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),
        const Text(
          'Forge Yourself',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 14,
            letterSpacing: 4,
            fontFamily: 'Outfit',
          ),
        ).animate(delay: 350.ms).fadeIn(duration: 600.ms),
        const SizedBox(height: 12),
        const Text(
          'Guidance from the world\'s greatest\nphilosophical traditions.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.6,
            fontFamily: 'Outfit',
          ),
        ).animate(delay: 400.ms).fadeIn(duration: 600.ms),
      ],
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  final bool loading;
  final VoidCallback onTap;
  const _GoogleSignInButton({required this.loading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: AppColors.accent),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            color: Color(0xFF4285F4),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _PhilosophyChip extends StatelessWidget {
  final String label;
  final int delay;
  const _PhilosophyChip({required this.label, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceGlass,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'Outfit',
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: 600 + delay))
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
}

class _GlowOrb extends StatelessWidget {
  final double size, opacity;
  final Color color;
  const _GlowOrb(
      {required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: opacity), Colors.transparent],
          ),
        ),
      );
}

class _StarFieldPainter extends CustomPainter {
  final double t;
  final List<_Star> stars;
  const _StarFieldPainter({required this.t, required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in stars) {
      final twinkle = math.sin(t * math.pi * 2 * s.speed + s.phase) * 0.5 + 0.5;
      canvas.drawCircle(
        Offset(s.x * size.width, s.y * size.height),
        s.radius,
        Paint()
          ..color = Colors.white
              .withValues(alpha: s.baseOpacity * (0.4 + twinkle * 0.6)),
      );
    }
  }

  @override
  bool shouldRepaint(_StarFieldPainter old) => old.t != t;
}

class _Star {
  final double x, y, radius, speed, phase, baseOpacity;
  _Star(math.Random rng)
      : x = rng.nextDouble(),
        y = rng.nextDouble(),
        radius = rng.nextDouble() * 1.2 + 0.3,
        speed = rng.nextDouble() * 0.8 + 0.2,
        phase = rng.nextDouble() * math.pi * 2,
        baseOpacity = rng.nextDouble() * 0.5 + 0.1;
}
