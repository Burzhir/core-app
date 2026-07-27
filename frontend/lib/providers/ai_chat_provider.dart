import 'package:flutter/foundation.dart';
import '../services/ai_service.dart';
import '../models/user_model.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class AiChatProvider extends ChangeNotifier {
  // ── State ─────────────────────────────────────────────────────────────────
  String? _selectedPhilosophy;
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;

  // ── Getters ───────────────────────────────────────────────────────────────
  String? get selectedPhilosophy => _selectedPhilosophy;
  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasConversation => _messages.isNotEmpty;

  // ── Philosophy selection ──────────────────────────────────────────────────

  void selectPhilosophy(String philosophyName) {
    if (_selectedPhilosophy == philosophyName) return;
    _selectedPhilosophy = philosophyName;
    _messages.clear();
    _error = null;
    notifyListeners();
  }

  // ── Send message ──────────────────────────────────────────────────────────

  Future<bool> sendMessage({
    required String text,
    required UserModel? user,
  }) async {
    final philosophy = _selectedPhilosophy;
    if (philosophy == null || text.trim().isEmpty) return false;

    // Check free tier limit
    if (user != null &&
        !user.isPremium &&
        user.dailyAiMessagesUsed >= UserModel.freeAiDailyLimit) {
      _error =
          'You have used your ${UserModel.freeAiDailyLimit} free messages today. '
          'Upgrade to continue.';
      notifyListeners();
      return false;
    }

    // Add user message
    _messages.add(ChatMessage(
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    ));
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Build conversation history (last 16 messages), excluding the user
    // message we just added (which is the last item in _messages).
    final history = <Map<String, String>>[];
    final prior = _messages.sublist(0, _messages.length - 1);
    final start = (prior.length - 16).clamp(0, prior.length);
    for (var i = start; i < prior.length; i++) {
      final m = prior[i];
      history.add({'role': m.isUser ? 'user' : 'assistant', 'content': m.text});
    }

    // Call AI
    final response = await AiService.chat(
      philosophyName: philosophy,
      userMessage: text.trim(),
      conversationHistory: history,
    );

    _messages.add(ChatMessage(
      text: response,
      isUser: false,
      timestamp: DateTime.now(),
    ));
    _isLoading = false;
    notifyListeners();
    return true;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearConversation() {
    _messages.clear();
    _error = null;
    notifyListeners();
  }
}
