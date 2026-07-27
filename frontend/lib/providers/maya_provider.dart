import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../services/revenue_cat_service.dart';

class MayaMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? improvement;
  final String? target;

  const MayaMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.improvement,
    this.target,
  });
}

class MayaProvider extends ChangeNotifier {
  final List<MayaMessage> _messages = [
    MayaMessage(
      text: "Hello. I'm Maya. How can I guide you today?",
      isUser: false,
      timestamp: DateTime.now(),
    )
  ];
  bool _isLoading = false;
  bool _showPaywall = false;
  String? _error;

  List<MayaMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get showPaywall => _showPaywall;

  static const String _baseUrl = 'https://core-app-x3ok.onrender.com';
  static const Duration _timeout = Duration(seconds: 45);

  Future<void> sendMessage(String text, UserModel? user) async {
    if (text.trim().isEmpty) return;

    _messages.add(MayaMessage(
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    ));
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final isPremium = await RevenueCatService.checkPremium();
      // Count user messages to Maya (in a real app, this would be persisted in Firestore)
      int userMessageCount = _messages.where((m) => m.isUser).length;

      final history = _messages.map((m) {
        return {'role': m.isUser ? 'user' : 'assistant', 'content': m.text};
      }).toList();

      final response = await http
          .post(
            Uri.parse('$_baseUrl/api/maya'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'messages': history,
              'subscription_status': isPremium ? 'premium' : 'free',
              'message_count': userMessageCount,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['action'] == 'paywall') {
          _showPaywall = true;
          _messages.add(MayaMessage(
            text: data['message'] ?? 'You have reached your free limit.',
            improvement: data['improvement'],
            isUser: false,
            timestamp: DateTime.now(),
          ));
        } else {
          _messages.add(MayaMessage(
            text: data['message'] ?? '',
            improvement: data['improvement'],
            target: data['target'],
            isUser: false,
            timestamp: DateTime.now(),
          ));
        }
      } else {
        _error = 'Maya is currently unavailable.';
      }
    } catch (e) {
      _error = 'Could not reach Maya. Check your connection.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetPaywallState() {
    _showPaywall = false;
    notifyListeners();
  }
}
