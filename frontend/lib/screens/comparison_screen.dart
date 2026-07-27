import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../data/comparisons_data.dart';
import '../models/comparison_model.dart';
import '../providers/auth_provider.dart' as core;
import '../screens/paywall_screen.dart';

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  ComparisonSituation? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Compare Philosophies',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
          ),
        ),
        centerTitle: true,
      ),
      body: _selected == null
          ? _SituationPicker(onSelect: (s) => setState(() => _selected = s))
          : _PerspectivesView(
              situation: _selected!,
              onBack: () => setState(() => _selected = null),
            ),
    );
  }
}

// ── Situation picker ───────────────────────────────────────────────────────────

class _SituationPicker extends StatelessWidget {
  final ValueChanged<ComparisonSituation> onSelect;
  const _SituationPicker({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Text(
              'What are you dealing with?',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: 'Outfit',
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 20),
            child: Text(
              'Pick a situation and see how 12 philosophies would approach it.',
              style: TextStyle(
                  color: AppColors.textSecondary, fontSize: 13, height: 1.5),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) => _SituationTile(
                situation: kComparisonSituations[i],
                onTap: () => onSelect(kComparisonSituations[i]),
              ),
              childCount: kComparisonSituations.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

class _SituationTile extends StatelessWidget {
  final ComparisonSituation situation;
  final VoidCallback onTap;
  const _SituationTile({required this.situation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(situation.icon, style: const TextStyle(fontSize: 28)),
            const Spacer(),
            Text(
              situation.title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Outfit',
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Perspectives view ─────────────────────────────────────────────────────────

class _PerspectivesView extends StatefulWidget {
  final ComparisonSituation situation;
  final VoidCallback onBack;
  const _PerspectivesView({required this.situation, required this.onBack});

  @override
  State<_PerspectivesView> createState() => _PerspectivesViewState();
}

class _PerspectivesViewState extends State<_PerspectivesView> {
  PhilosophyPerspective? _expanded;

  static const int _freePerspectives = 3;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();
    final isPremium = auth.isPremium;
    final perspectives = widget.situation.perspectives;

    return CustomScrollView(
      slivers: [
        // Situation header
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.situation.icon,
                        style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.situation.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onBack,
                      child: const Icon(Icons.close_rounded,
                          color: AppColors.textMuted, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.situation.prompt,
                  style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.5),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.visibility_outlined,
                        color: AppColors.textMuted, size: 13),
                    const SizedBox(width: 4),
                    Text(
                      isPremium
                          ? '${perspectives.length} philosophy perspectives'
                          : '$_freePerspectives of ${perspectives.length} • Upgrade for all',
                      style: const TextStyle(
                          color: AppColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Perspective cards
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final p = perspectives[i];
                final locked = !isPremium && i >= _freePerspectives;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: locked
                      ? _LockedPerspectiveTile(perspective: p)
                      : _PerspectiveTile(
                          perspective: p,
                          isExpanded: _expanded == p,
                          onTap: () => setState(
                            () => _expanded = _expanded == p ? null : p,
                          ),
                        ),
                );
              },
              childCount: perspectives.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

class _PerspectiveTile extends StatelessWidget {
  final PhilosophyPerspective perspective;
  final bool isExpanded;
  final VoidCallback onTap;

  const _PerspectiveTile({
    required this.perspective,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isExpanded
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.border,
          ),
          boxShadow: isExpanded
              ? const [BoxShadow(color: AppColors.accentGlow, blurRadius: 12)]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Text(perspective.emoji, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 10),
                  Text(
                    perspective.philosophyName,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Key insight
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '"${perspective.keyInsight}"',
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Expanded content
              if (isExpanded) ...[
                const SizedBox(height: 14),
                Text(
                  perspective.perspective,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ACTION STEP',
                        style: TextStyle(
                          color: AppColors.teal,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        perspective.actionStep,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LockedPerspectiveTile extends StatelessWidget {
  final PhilosophyPerspective perspective;
  const _LockedPerspectiveTile({required this.perspective});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPaywall(context),
      child: Opacity(
        opacity: 0.45,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Text(perspective.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Text(
                perspective.philosophyName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Outfit',
                ),
              ),
              const Spacer(),
              const Icon(Icons.lock_rounded, color: AppColors.accent, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _openPaywall(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: const ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          child: PaywallScreen(
            triggerReason: 'Unlock all 12 philosophy perspectives',
          ),
        ),
      ),
    );
  }
}
