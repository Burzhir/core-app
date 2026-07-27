import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../widgets/cosmic_background.dart';
import '../data/philosophies_data.dart';
import '../models/philosophy_model.dart';
import 'philosophy_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _search.isEmpty
        ? kPhilosophies
        : kPhilosophies
            .where((p) =>
                p.name.toLowerCase().contains(_search.toLowerCase()) ||
                p.tagline.toLowerCase().contains(_search.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          const CosmicBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // ── Header ────────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Library',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Outfit',
                          ),
                        ).animate().fadeIn(duration: 500.ms),

                        const SizedBox(height: 4),

                        Text(
                          '${kPhilosophies.length} philosophies · All free',
                          style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 13),
                        ).animate(delay: 100.ms).fadeIn(duration: 500.ms),

                        const SizedBox(height: 16),

                        // Search bar
                        Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: TextField(
                            onChanged: (v) => setState(() => _search = v),
                            style: const TextStyle(
                                color: AppColors.textPrimary, fontSize: 14),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search_rounded,
                                  color: AppColors.textMuted, size: 18),
                              hintText: 'Search philosophies…',
                              hintStyle: TextStyle(
                                  color: AppColors.textMuted, fontSize: 14),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ).animate(delay: 200.ms).fadeIn(duration: 500.ms),
                      ],
                    ),
                  ),
                ),

                // ── Grid ──────────────────────────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final p = filtered[i];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PhilosophyDetailScreen(philosophy: p),
                            ),
                          ),
                          child: _PhilosophyCard(
                            philosophy: p,
                            delay: i * 60,
                          ),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                ),

                if (filtered.isEmpty)
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'No philosophies match your search.',
                          style: TextStyle(
                              color: AppColors.textMuted, fontSize: 14),
                        ),
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
}

// ── Philosophy card ───────────────────────────────────────────────────────────

class _PhilosophyCard extends StatelessWidget {
  final PhilosophyModel philosophy;
  final int delay;
  const _PhilosophyCard({required this.philosophy, required this.delay});

  @override
  Widget build(BuildContext context) {
    final p = philosophy;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            p.gradient[0].withValues(alpha: 0.18),
            p.gradient[1].withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: p.gradient[0].withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Emoji + free badge row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(p.emoji, style: const TextStyle(fontSize: 28)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('FREE',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    )),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(p.name,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                fontFamily: 'Outfit',
              )),

          const SizedBox(height: 4),

          Text(
            p.tagline,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const Spacer(),

          // Key thinkers
          Text(
            p.keyThinkers.take(2).join(' · '),
            style: TextStyle(
              color: p.gradient[0].withValues(alpha: 0.9),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 200 + delay))
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }
}
