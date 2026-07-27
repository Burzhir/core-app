import 'package:cloud_firestore/cloud_firestore.dart';

class JournalEntry {
  final String id;
  final String text;
  final String mood;
  final String prompt;
  final DateTime createdAt;

  // Analysis cache fields
  final String? philosophyMatch;
  final String? insight;
  final String? suggestedAction;
  final String? emotionalTone;
  final List<String>? themes;
  final String? recurringPattern;

  const JournalEntry({
    required this.id,
    required this.text,
    required this.mood,
    required this.prompt,
    required this.createdAt,
    this.philosophyMatch,
    this.insight,
    this.suggestedAction,
    this.emotionalTone,
    this.themes,
    this.recurringPattern,
  });

  factory JournalEntry.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return JournalEntry(
      id: doc.id,
      text: d['text'] as String? ?? '',
      mood: d['mood'] as String? ?? '',
      prompt: d['prompt'] as String? ?? '',
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      philosophyMatch: d['philosophyMatch'] as String?,
      insight: d['insight'] as String?,
      suggestedAction: d['suggestedAction'] as String?,
      emotionalTone: d['emotionalTone'] as String?,
      themes: (d['themes'] as List<dynamic>?)?.cast<String>(),
      recurringPattern: d['recurringPattern'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'text': text,
        'mood': mood,
        'prompt': prompt,
        'createdAt': Timestamp.fromDate(createdAt),
        if (philosophyMatch != null) 'philosophyMatch': philosophyMatch,
        if (insight != null) 'insight': insight,
        if (suggestedAction != null) 'suggestedAction': suggestedAction,
        if (emotionalTone != null) 'emotionalTone': emotionalTone,
        if (themes != null) 'themes': themes,
        if (recurringPattern != null) 'recurringPattern': recurringPattern,
      };
}
