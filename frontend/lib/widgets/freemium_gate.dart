import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/auth_provider.dart' as core;
import '../screens/paywall_screen.dart';

/// Wraps any widget with a freemium blur gate.
/// If [locked] is true and user is not premium, it shows a blurred overlay.
class FreemiumGate extends StatelessWidget {
  final bool   locked;
  final Widget child;
  final String reason;

  const FreemiumGate({
    super.key,
    required this.locked,
    required this.child,
    this.reason = 'Unlock Premium to access this.',
  });

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();
    final isLocked = locked && !auth.isPremium;

    if (!isLocked) return child;

    return Stack(
      children: [
        // Blurred / dimmed child
        Opacity(opacity: 0.25, child: child),

        // Lock overlay
        Positioned.fill(
          child: GestureDetector(
            onTap: () => _openPaywall(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bg.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.accent.withValues(alpha: 0.3),
                          AppColors.accent.withValues(alpha: 0.1),
                        ],
                      ),
                      border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.5)),
                    ),
                    child: const Icon(Icons.lock_rounded,
                        color: AppColors.accent, size: 20),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'PREMIUM',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openPaywall(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: PaywallScreen(triggerReason: reason),
        ),
      ),
    );
  }
}

/// Shows remaining AI messages badge (used in chat-adjacent UIs).
class AiQuotaBadge extends StatelessWidget {
  const AiQuotaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();
    if (auth.isPremium) return const SizedBox.shrink();

    final remaining = auth.remainingAiMessagesToday;
    final color = remaining > 1
        ? AppColors.accent
        : remaining == 1
            ? const Color(0xFFFF9500)
            : const Color(0xFFFF3B30);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.92,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: PaywallScreen(
              triggerReason: remaining == 0
                  ? 'You\'ve used all 5 free AI messages today'
                  : null,
            ),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat_bubble_outline_rounded, color: color, size: 13),
            const SizedBox(width: 4),
            Text(
              remaining == 0
                  ? 'No AI messages left'
                  : '$remaining left today',
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
