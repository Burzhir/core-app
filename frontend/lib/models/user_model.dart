import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final bool isPremium;
  final int dailyAiMessagesUsed;
  final String lastAiMessageDate;
  final DateTime createdAt;
  final int currentStreak;
  final String lastOpenedDate;

  /// Philosophy quiz result — e.g. {'stoicism': 0.42, 'existentialism': 0.28}
  final Map<String, double>? quizResult;

  const UserModel({
    required this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.isPremium = false,
    this.dailyAiMessagesUsed = 0,
    this.lastAiMessageDate = '',
    required this.createdAt,
    this.currentStreak = 0,
    this.lastOpenedDate = '',
    this.quizResult,
  });

  // ── Freemium limits ───────────────────────────────────────────────────────

  /// Free users get 5 AI philosopher messages per day.
  static const int freeAiDailyLimit = 5;

  bool get canSendAiMessage =>
      isPremium || dailyAiMessagesUsed < freeAiDailyLimit;

  int get remainingAiMessages => isPremium
      ? 999
      : (freeAiDailyLimit - dailyAiMessagesUsed).clamp(0, freeAiDailyLimit);

  // ── Serialisation ─────────────────────────────────────────────────────────

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    final quizRaw = map['quizResult'] as Map<String, dynamic>?;
    return UserModel(
      uid: uid,
      displayName: map['displayName'] as String?,
      email: map['email'] as String?,
      photoUrl: map['photoUrl'] as String?,
      isPremium: map['isPremium'] as bool? ?? false,
      dailyAiMessagesUsed: map['dailyAiMessagesUsed'] as int? ?? 0,
      lastAiMessageDate: map['lastAiMessageDate'] as String? ?? '',
      createdAt: _parseCreatedAt(map['createdAt']),
      quizResult: quizRaw?.map((k, v) => MapEntry(k, (v as num).toDouble())),
      currentStreak: map['currentStreak'] as int? ?? 0,
      lastOpenedDate: map['lastOpenedDate'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'isPremium': isPremium,
        'dailyAiMessagesUsed': dailyAiMessagesUsed,
        'lastAiMessageDate': lastAiMessageDate,
        'createdAt': createdAt.toIso8601String(),
        'quizResult': quizResult,
        'currentStreak': currentStreak,
        'lastOpenedDate': lastOpenedDate,
      };

  UserModel copyWith({
    String? displayName,
    String? email,
    String? photoUrl,
    bool? isPremium,
    int? dailyAiMessagesUsed,
    String? lastAiMessageDate,
    Map<String, double>? quizResult,
    int? currentStreak,
    String? lastOpenedDate,
  }) {
    return UserModel(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      isPremium: isPremium ?? this.isPremium,
      dailyAiMessagesUsed: dailyAiMessagesUsed ?? this.dailyAiMessagesUsed,
      lastAiMessageDate: lastAiMessageDate ?? this.lastAiMessageDate,
      createdAt: createdAt,
      quizResult: quizResult ?? this.quizResult,
      currentStreak: currentStreak ?? this.currentStreak,
      lastOpenedDate: lastOpenedDate ?? this.lastOpenedDate,
    );
  }

  static DateTime _parseCreatedAt(Object? value) {
    if (value == null) return DateTime.now();
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    return DateTime.now();
  }
}
