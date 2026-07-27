import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/journal_entry_model.dart';
import 'ai_service.dart';

class JournalService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _db.collection('users').doc(uid).collection('journal');

  /// Live stream of all entries, newest first.
  Stream<List<JournalEntry>> entriesStream(String uid) {
    return _col(uid).orderBy('createdAt', descending: true).snapshots().map(
        (snap) => snap.docs
            .map((d) => JournalEntry.fromDoc(d))
            .toList()); // ← removed extra semicolon
  }

  /// Save a new entry and return it.
  Future<JournalEntry> addEntry({
    required String uid,
    required String text,
    required String mood,
    required String prompt,
  }) async {
    final ref = await _col(uid).add(JournalEntry(
      id: '',
      text: text.trim(),
      mood: mood,
      prompt: prompt,
      createdAt: DateTime.now(),
    ).toMap());

    final doc = await ref.get();
    return JournalEntry.fromDoc(doc);
  }

  /// Update an entry with AI analysis results.
  Future<void> updateEntryAnalysis({
    required String uid,
    required String entryId,
    required JournalAnalysis analysis,
  }) async {
    await _col(uid).doc(entryId).update({
      'philosophyMatch': analysis.philosophyMatch,
      'insight': analysis.insight,
      'suggestedAction': analysis.suggestedAction,
      'emotionalTone': analysis.emotionalTone,
      'themes': analysis.themes,
      'recurringPattern': analysis.recurringPattern,
    });
  }

  /// Permanently delete an entry.
  Future<void> deleteEntry({required String uid, required String entryId}) =>
      _col(uid).doc(entryId).delete();
}
