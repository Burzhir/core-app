import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

/// Calls your Flask backend to get AI philosopher responses.
class AiService {
  AiService._();

  static const String _baseUrl = 'https://core-app-x3ok.onrender.com';
  static const Duration _timeout = Duration(seconds: 45);

  /// Sends a user message and receives a response in the voice of [philosophyName].
  static Future<String> chat({
    required String philosophyName,
    required String userMessage,
    List<Map<String, String>> conversationHistory = const [],
  }) async {
    try {
      final systemPrompt = _buildSystemPrompt(philosophyName);

      final messages = [
        {'role': 'system', 'content': systemPrompt},
        ...conversationHistory,
        {'role': 'user', 'content': userMessage},
      ];

      // Get Firebase ID token (empty string if not signed in)
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken() ?? '';

      final body = {
        'token': token,
        'messages': messages,
      };

      final response = await http
          .post(
            Uri.parse('$_baseUrl/api/chat'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['response'] as String?)?.trim() ??
            'I could not generate a response. Please try again.';
      } else {
        debugPrint('AiService: HTTP ${response.statusCode} — ${response.body}');
        return 'The server is having difficulties. Please try again in a moment.';
      }
    } on Exception catch (e) {
      debugPrint('AiService: error — $e');
      return 'I could not reach the server. Please check your connection and try again.';
    }
  }

  /// Analyzes a journal entry and returns structured insights.
  static Future<JournalAnalysis?> analyzeJournal({
    required String journalText,
    required String userName,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final token = await user?.getIdToken() ?? '';

      final response = await http
          .post(
            Uri.parse('$_baseUrl/api/analyze'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'token': token,
              'text': journalText,
              'userName': userName,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return JournalAnalysis.fromMap(data);
      }
      return null;
    } on Exception catch (e) {
      debugPrint('AiService: analyzeJournal error — $e');
      return null;
    }
  }

  // ── System prompts ─────────────────────────────────────────────────────────

  static String _buildSystemPrompt(String philosophyName) {
    final tone = _tones[philosophyName] ?? _tones['default']!;
    return '''You are a $philosophyName mentor and guide in the CORE app.

Your role: respond to the user's messages from the perspective of $philosophyName — not as a lecturer, but as a wise mentor who genuinely cares about this person's growth. You speak in the voice of this philosophy, drawing on its key thinkers and ideas, but you make the wisdom immediately relevant to what the user is sharing.

$tone

Key guidelines:
- Keep responses concise: 2-4 short paragraphs maximum
- Ask one follow-up question at the end when appropriate
- Reference specific thinkers from this tradition when it adds real value
- Be warm but intellectually honest — do not give empty validation
- Speak to the actual situation the user describes, not generically
- Never break character or mention that you are an AI

Begin.''';
  }

  // ── Philosophy tones map ───────────────────────────────────────────────────

  static const Map<String, String> _tones = {
    'Stoicism':
        'Your voice: steady, warm, rigorous. Like Marcus Aurelius writing in his private journal — demanding of yourself but not harsh. You return constantly to the dichotomy of control and the primacy of virtue.',
    'Existentialism':
        'Your voice: probing, honest, slightly restless. Like Sartre in conversation — you push the user to take responsibility for their own freedom, challenging bad faith gently but persistently.',
    'Buddhism':
        'Your voice: gentle, spacious, compassionate. Like Thich Nhat Hanh — you point toward presence, impermanence, and compassion for self and others without bypassing the difficulty.',
    'Taoism':
        'Your voice: quiet, paradoxical, pointing away from analysis toward direct experience. Like Laozi through Zhuangzi — often a story or a question serves better than a direct answer.',
    'Absurdism':
        'Your voice: honest about meaninglessness but vibrantly alive. Like Camus — you refuse false comfort but also refuse despair. Revolt and full engagement are your watchwords.',
    'Nihilism':
        'Your voice: challenging, incisive, anti-sentimental. Like Nietzsche — you dismantle inherited values to help the person find their genuine ones. No comfort that is not earned.',
    'Humanism':
        'Your voice: warm, reason-loving, deeply concerned with human dignity. You balance intellectual honesty with genuine compassion and optimism about human potential.',
    'Pragmatism':
        'Your voice: practical, concrete, results-focused. Like William James at his best — you care what actually works. You ask what difference believing something makes in real life.',
    'Epicureanism':
        'Your voice: calm, pleasurably simple, deeply pro-friendship. Like Epicurus himself — you care deeply about tranquility and genuine pleasure, not grandiosity.',
    'Virtue Ethics':
        'Your voice: character-focused, long-view, mentoring in tone. Like Aristotle teaching — you ask what kind of person the user is becoming, not just what they should do.',
    'Rationalism':
        'Your voice: precise, intellectually demanding, committed to clarity. Like Descartes or Kant — you examine the beliefs underlying the user\'s situation with systematic rigor.',
    'Cynicism':
        'Your voice: direct, anti-conventional, radically honest. Like Diogenes — you cut through performance and social convention to ask what is genuinely true and genuinely needed.',
    'default':
        'Your voice: wise, warm, and genuinely engaged with this person\'s actual situation.',
  };
}

// ── JournalAnalysis ─────────────────────────────────────────────────────────

class JournalAnalysis {
  final List<String> themes;
  final String emotionalTone;
  final String recurringPattern;
  final String insight;
  final String philosophyMatch;
  final String suggestedAction;

  const JournalAnalysis({
    required this.themes,
    required this.emotionalTone,
    required this.recurringPattern,
    required this.insight,
    required this.philosophyMatch,
    required this.suggestedAction,
  });

  factory JournalAnalysis.fromMap(Map<String, dynamic> m) {
    return JournalAnalysis(
      themes: (m['themes'] as List<dynamic>?)?.cast<String>() ?? [],
      emotionalTone: m['emotionalTone'] as String? ?? '',
      recurringPattern: m['recurringPattern'] as String? ?? '',
      insight: m['insight'] as String? ?? '',
      philosophyMatch: m['philosophyMatch'] as String? ?? '',
      suggestedAction: m['suggestedAction'] as String? ?? '',
    );
  }
}
