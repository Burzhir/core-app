import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../models/journal_entry_model.dart';
import '../providers/auth_provider.dart' as core;
import '../services/journal_service.dart';
import '../services/ai_service.dart';
import 'paywall_screen.dart';
import 'maya_chat_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _service = JournalService();

  String _getDominantMood(List<JournalEntry> entries) {
    if (entries.isEmpty) return '😐';
    final counts = <String, int>{};
    for (final e in entries) {
      if (e.mood.isNotEmpty) {
        counts[e.mood] = (counts[e.mood] ?? 0) + 1;
      }
    }
    if (counts.isEmpty) return '😐';
    return counts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<core.AuthProvider>();
    final uid = auth.user?.uid;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: StreamBuilder<List<JournalEntry>>(
          stream: uid != null ? _service.entriesStream(uid) : const Stream.empty(),
          builder: (context, snap) {
            final entries = snap.data ?? [];
            final hasData = snap.hasData && snap.connectionState != ConnectionState.waiting;

            return CustomScrollView(
              slivers: [
                // ── Header ─────────────────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'JOURNAL',
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 4,
                                  fontFamily: 'Outfit',
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Reflect & grow',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Outfit',
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _openNewEntry(context, uid),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [AppColors.accent, Color(0xFF5E5CE6)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accent.withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.add_rounded,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Statistics Card ───────────────────────────────────────────
                if (uid != null && hasData && entries.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
                      child: _StatsCard(
                        totalEntries: entries.length,
                        streak: auth.currentStreak,
                        dominantMood: _getDominantMood(entries),
                      ),
                    ),
                  ),

                // ── Today's prompt card ─────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                    child: _DailyPromptCard(
                      onTap: () => _openNewEntry(context, uid),
                    ),
                  ),
                ),

                // ── Entries ─────────────────────────────────────────────────────
                if (uid == null)
                  const SliverToBoxAdapter(child: _EmptyJournal())
                else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PAST ENTRIES',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (snap.connectionState == ConnectionState.waiting)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: CircularProgressIndicator(
                                  color: AppColors.accent,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          else if (entries.isEmpty)
                            const _EmptyJournal()
                          else
                            Column(
                              children: entries
                                  .map((e) => _EntryCard(
                                        entry: e,
                                        onDelete: () =>
                                            _confirmDelete(context, uid, e),
                                        onTapInsight: () =>
                                            _getOrRequestInsight(context, e, uid),
                                        onViewInsight: () =>
                                            _showInsightBottomSheet(context, e, uid),
                                      ))
                                  .toList(),
                            ),
                        ],
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            );
          },
        ),
      ),
    );
  }

  void _openNewEntry(BuildContext context, String? uid) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NewEntrySheet(uid: uid, service: _service),
    );
  }

  Future<void> _getOrRequestInsight(
      BuildContext context, JournalEntry entry, String uid) async {
    final auth = Provider.of<core.AuthProvider>(context, listen: false);
    if (!auth.isPremium) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const PaywallScreen()),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
      ),
    );

    try {
      final analysis = await AiService.analyzeJournal(
        journalText: entry.text,
        userName: auth.user?.displayName ?? 'Seeker',
      );

      if (context.mounted) {
        Navigator.of(context).pop(); // Dismiss loading indicator
      }

      if (analysis != null) {
        await _service.updateEntryAnalysis(
          uid: uid,
          entryId: entry.id,
          analysis: analysis,
        );

        final updatedEntry = JournalEntry(
          id: entry.id,
          text: entry.text,
          mood: entry.mood,
          prompt: entry.prompt,
          createdAt: entry.createdAt,
          philosophyMatch: analysis.philosophyMatch,
          insight: analysis.insight,
          suggestedAction: analysis.suggestedAction,
          emotionalTone: analysis.emotionalTone,
          themes: analysis.themes,
          recurringPattern: analysis.recurringPattern,
        );

        if (context.mounted) {
          _showInsightBottomSheet(context, updatedEntry, uid);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to analyze entry. Please try again.')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // Dismiss loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error analyzing entry: $e')),
        );
      }
    }
  }

  void _showInsightBottomSheet(
      BuildContext context, JournalEntry entry, String uid) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pull handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content Area
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.auto_awesome_rounded,
                                color: AppColors.accent, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${entry.philosophyMatch ?? "Stoicism"} Insight',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Outfit',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Emotional Tone & Pattern
                      Row(
                        children: [
                          if (entry.emotionalTone != null) ...[
                            _buildInfoChip(
                              Icons.mood_rounded,
                              'Tone: ${entry.emotionalTone}',
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (entry.themes != null && entry.themes!.isNotEmpty)
                            _buildInfoChip(
                              Icons.label_outline_rounded,
                              entry.themes!.first,
                            ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Insight Section
                      const Text(
                        'PHILOSOPHICAL REFLECTION',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.insight ?? 'No insight available.',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Recurring Pattern Section
                      if (entry.recurringPattern != null && entry.recurringPattern!.isNotEmpty) ...[
                        const Text(
                          'OBSERVED PATTERN',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.recurringPattern!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Suggested Action Section
                      const Text(
                        'PRACTICAL EXERCISE',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceAlt,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          entry.suggestedAction ?? 'No exercise available.',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Discuss with Maya Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close sheet
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MayaChatScreen(
                                initialPrompt:
                                    'Hi Maya, I want to discuss my journal entry and the ${entry.philosophyMatch} insight I received. My entry was: "${entry.text}". The insight was: "${entry.insight}". How can I apply this practical exercise: "${entry.suggestedAction}"?',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFBF5AF2).withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_bubble_outline_rounded,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Discuss with Maya',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, String uid, JournalEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete entry?',
            style:
                TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit')),
        content: const Text('This cannot be undone.',
            style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFFF3B30))),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _service.deleteEntry(uid: uid, entryId: entry.id);
    }
  }
}

// ── Statistics Card ───────────────────────────────────────────────────────────

class _StatsCard extends StatelessWidget {
  final int totalEntries;
  final int streak;
  final String dominantMood;

  const _StatsCard({
    required this.totalEntries,
    required this.streak,
    required this.dominantMood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total Entries', totalEntries.toString(), Icons.book_rounded),
          _buildDivider(),
          _buildStatItem('Streak', '$streak Days', Icons.local_fire_department_rounded, color: Colors.orange),
          _buildDivider(),
          _buildStatItem('Dominant Mood', dominantMood, null),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 28,
      width: 1,
      color: AppColors.border,
    );
  }

  Widget _buildStatItem(String label, String value, IconData? icon, {Color? color}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: color ?? AppColors.accent),
              const SizedBox(width: 4),
            ],
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Outfit',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ── Daily prompt card ─────────────────────────────────────────────────────────

class _DailyPromptCard extends StatelessWidget {
  final VoidCallback onTap;
  const _DailyPromptCard({required this.onTap});

  static const _prompts = [
    'What is one belief you hold that you have never truly examined?',
    'Describe a moment today where you chose comfort over courage.',
    'What would your ideal self have done differently today?',
    'What are you most resistant to right now — and why?',
    'Where did you give away your agency today?',
    'What are you pretending not to know?',
    'What would you do if you knew it would fail?',
  ];

  String get _todayPrompt {
    final day = DateTime.now().weekday - 1;
    return _prompts[day % _prompts.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.accent.withValues(alpha: 0.15),
              const Color(0xFF5E5CE6).withValues(alpha: 0.08),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'TODAY\'S PROMPT',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.edit_note_rounded,
                    color: AppColors.accent, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '"$_todayPrompt"',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                Text(
                  'Write your reflection',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded,
                    color: AppColors.accent, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Entry card ────────────────────────────────────────────────────────────────

class _EntryCard extends StatelessWidget {
  final JournalEntry entry;
  final VoidCallback onDelete;
  final VoidCallback onTapInsight;
  final VoidCallback onViewInsight;

  const _EntryCard({
    required this.entry,
    required this.onDelete,
    required this.onTapInsight,
    required this.onViewInsight,
  });

  String _formatDate(DateTime dt) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return 'Today';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (dt.year == yesterday.year &&
        dt.month == yesterday.month &&
        dt.day == yesterday.day) {
      return 'Yesterday';
    }
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: const Color(0xFFFF3B30).withValues(alpha: 0.3)),
        ),
        child: const Icon(Icons.delete_outline_rounded,
            color: Color(0xFFFF3B30), size: 22),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false; // let the Firestore stream handle removal
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
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
                if (entry.mood.isNotEmpty) ...[
                  Text(entry.mood, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                ],
                Text(
                  _formatDate(entry.createdAt),
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(Icons.delete_outline_rounded,
                      color: AppColors.textMuted, size: 16),
                ),
              ],
            ),
            if (entry.prompt.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                '"${entry.prompt}"',
                style: TextStyle(
                  color: AppColors.textMuted.withValues(alpha: 0.7),
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 10),
            Text(
              entry.text,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                height: 1.6,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            // Philosophical Insight Section
            if (entry.philosophyMatch != null) ...[
              const SizedBox(height: 16),
              InkWell(
                onTap: onViewInsight,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome_rounded, color: AppColors.accent, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${entry.philosophyMatch} Insight Available',
                              style: const TextStyle(
                                color: AppColors.accent,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Outfit',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              entry.insight ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.accent, size: 12),
                    ],
                  ),
                ),
              ),
            ] else ...[
              const SizedBox(height: 16),
              GestureDetector(
                onTap: onTapInsight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock_rounded, color: AppColors.accent, size: 14),
                      SizedBox(width: 8),
                      Text(
                        'Unlock Philosophical Insight',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────
class _EmptyJournal extends StatelessWidget {
  const _EmptyJournal();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentSoft,
            ),
            child: const Icon(Icons.book_outlined,
                color: AppColors.accent, size: 28),
          ),
          const SizedBox(height: 16),
          const Text(
            'No entries yet',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your reflections will appear here.\nStart with today\'s prompt above.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── New entry bottom sheet ───────────────────────────────────────────────────────────

class _NewEntrySheet extends StatefulWidget {
  final String? uid;
  final JournalService service;
  const _NewEntrySheet({required this.uid, required this.service});

  @override
  State<_NewEntrySheet> createState() => _NewEntrySheetState();
}

class _NewEntrySheetState extends State<_NewEntrySheet> {
  final _ctrl = TextEditingController();
  String _mood = '';
  bool _saving = false;

  static const _moods = ['😤', '😔', '😐', '🙂', '🔥'];

  static const _prompts = [
    'What is one belief you hold that you have never truly examined?',
    'Describe a moment today where you chose comfort over courage.',
    'What would your ideal self have done differently today?',
    'What are you most resistant to right now — and why?',
    'Where did you give away your agency today?',
    'What are you pretending not to know?',
    'What would you do if you knew it would fail?',
  ];

  String get _todayPrompt {
    final day = DateTime.now().weekday - 1;
    return _prompts[day % _prompts.length];
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_ctrl.text.trim().isEmpty || _saving) return;
    setState(() => _saving = true);
    try {
      if (widget.uid != null) {
        await widget.service.addEntry(
          uid: widget.uid!,
          text: _ctrl.text,
          mood: _mood,
          prompt: _todayPrompt,
        );
      }
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Entry saved ✓'),
            backgroundColor: AppColors.surface,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'New entry',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Outfit',
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Mood selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Text(
                  'Mood  ',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                ),
                ..._moods.map((m) => GestureDetector(
                      onTap: () => setState(() => _mood = m),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _mood == m
                              ? AppColors.accentSoft
                              : Colors.transparent,
                          border: _mood == m
                              ? Border.all(
                                  color:
                                      AppColors.accent.withValues(alpha: 0.5))
                              : null,
                        ),
                        child: Text(m, style: const TextStyle(fontSize: 22)),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: _ctrl,
              autofocus: true,
              maxLines: 8,
              minLines: 5,
              style: const TextStyle(
                  color: AppColors.textPrimary, fontSize: 15, height: 1.6),
              decoration: InputDecoration(
                hintText: 'Write what\'s on your mind…',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surfaceAlt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Save button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: GestureDetector(
              onTap: _saving ? null : _save,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.accent, Color(0xFF5E5CE6)]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _saving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Save entry',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
