import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Drop this anywhere as a Stack child to get the animated cosmic background.
/// It uses a Ticker so keep it in a widget that lives as long as needed.
class CosmicBackground extends StatefulWidget {
  final List<Color>? accentColors;
  const CosmicBackground({super.key, this.accentColors});

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => CustomPaint(
        painter: _CosmicPainter(
          t: _ctrl.value,
          accent1: widget.accentColors?[0] ?? const Color(0xFFBF5AF2),
          accent2: widget.accentColors?[1] ?? const Color(0xFF5E5CE6),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _CosmicPainter extends CustomPainter {
  final double t;
  final Color accent1;
  final Color accent2;

  static final _rng = math.Random(7);
  static final List<_StarData> _stars =
      List.generate(150, (_) => _StarData(_rng));

  _CosmicPainter(
      {required this.t, required this.accent1, required this.accent2});

  @override
  void paint(Canvas canvas, Size size) {
    // Deep background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.6, -0.8),
          radius: 1.4,
          colors: [Color(0xFF14102A), Color(0xFF07050F)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // Nebula clouds
    _paintNebula(canvas, size, const Alignment(-0.7, -0.6), accent1, 0.06);
    _paintNebula(canvas, size, const Alignment(0.8, 0.7), accent2, 0.04);

    // Stars
    for (final s in _stars) {
      final twinkle = math.sin(t * math.pi * 2 * s.speed + s.phase) * 0.5 + 0.5;
      canvas.drawCircle(
        Offset(s.x * size.width, s.y * size.height),
        s.r * (0.7 + twinkle * 0.3),
        Paint()
          ..color =
              Colors.white.withValues(alpha: s.opacity * (0.3 + twinkle * 0.7)),
      );
    }

    // Moving aurora band
    _paintAurora(canvas, size);

    // Vignette
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = RadialGradient(
          center: Alignment.center,
          radius: 0.9,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  void _paintNebula(
      Canvas canvas, Size size, Alignment pos, Color color, double opacity) {
    final cx = (pos.x * 0.5 + 0.5) * size.width;
    final cy = (pos.y * 0.5 + 0.5) * size.height;
    final radius = size.width * 0.55;
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: opacity), Colors.transparent],
        ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60),
    );
  }

  void _paintAurora(Canvas canvas, Size size) {
    final path = Path();
    final y0 = size.height * (0.25 + math.sin(t * math.pi * 2) * 0.05);
    path.moveTo(0, y0);
    for (double x = 0; x <= size.width; x += 6) {
      final y = y0 +
          math.sin(x / size.width * math.pi * 3 + t * math.pi * 2) * 18 +
          math.cos(x / size.width * math.pi * 5 + t * math.pi * 1.3) * 8;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          colors: [
            accent1.withValues(alpha: 0.04),
            accent2.withValues(alpha: 0.02),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(_CosmicPainter old) =>
      old.t != t || old.accent1 != accent1 || old.accent2 != accent2;
}

class _StarData {
  final double x, y, r, speed, phase, opacity;
  _StarData(math.Random rng)
      : x = rng.nextDouble(),
        y = rng.nextDouble(),
        r = rng.nextDouble() * 1.4 + 0.2,
        speed = rng.nextDouble() * 0.6 + 0.1,
        phase = rng.nextDouble() * math.pi * 2,
        opacity = rng.nextDouble() * 0.5 + 0.1;
}
