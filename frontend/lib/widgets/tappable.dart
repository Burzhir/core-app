import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Wraps any widget with a satisfying press-scale effect and optional haptic
/// feedback. Drop-in replacement for [GestureDetector] on tappable cards.
class Tappable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  /// How much to scale down on press. Defaults to 0.96.
  final double scale;

  /// Whether to fire a light haptic click on press-down.
  final bool haptic;

  const Tappable({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.96,
    this.haptic = true,
  });

  @override
  State<Tappable> createState() => _TappableState();
}

class _TappableState extends State<Tappable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 220),
    );
    _anim = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _down(TapDownDetails _) {
    if (widget.haptic) HapticFeedback.selectionClick();
    _ctrl.forward();
  }

  void _up(TapUpDetails _) => _ctrl.reverse();
  void _cancel() => _ctrl.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _down,
      onTapUp: _up,
      onTapCancel: _cancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(scale: _anim, child: widget.child),
    );
  }
}
