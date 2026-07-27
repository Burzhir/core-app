import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../providers/maya_provider.dart';
import '../providers/auth_provider.dart' as core;
import 'paywall_screen.dart';

class MayaChatScreen extends StatefulWidget {
  final String? initialPrompt;
  const MayaChatScreen({super.key, this.initialPrompt});

  @override
  State<MayaChatScreen> createState() => _MayaChatScreenState();
}

class _MayaChatScreenState extends State<MayaChatScreen> {
  late final TextEditingController _textController;
  final ScrollController _scrollController = ScrollController();
  MayaProvider? _maya;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    if (widget.initialPrompt != null && widget.initialPrompt!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final maya = context.read<MayaProvider>();
        final auth = context.read<core.AuthProvider>();
        maya.sendMessage(widget.initialPrompt!, auth.user).then((_) {
          _scrollToBottom();
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final maya = context.read<MayaProvider>();
    if (_maya != maya) {
      _maya?.removeListener(_handlePaywall);
      _maya = maya;
      _maya!.addListener(_handlePaywall);
    }
  }

  void _handlePaywall() {
    final maya = _maya;
    if (maya == null || !maya.showPaywall || !mounted) return;
    maya.resetPaywallState();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PaywallScreen()),
    );
  }

  @override
  void dispose() {
    _maya?.removeListener(_handlePaywall);
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final maya = context.watch<MayaProvider>();
    final auth = context.read<core.AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Maya OS', style: TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.bold)),
        centerTitle: true,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      body: Column(
        children: [
          if (maya.error != null)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red.withValues(alpha: 0.1),
              child: Text(maya.error!, style: const TextStyle(color: Colors.redAccent)),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: maya.messages.length + (maya.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == maya.messages.length) {
                  return const _LoadingBubble();
                }
                final msg = maya.messages[index];
                return _MessageBubble(message: msg);
              },
            ),
          ),
          _ChatInput(
            controller: _textController,
            isSending: maya.isLoading,
            onSend: (text) async {
              _scrollToBottom();
              await maya.sendMessage(text, auth.user);
              _scrollToBottom();
            },
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final MayaMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.accent.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: message.isUser ? const Radius.circular(0) : const Radius.circular(20),
            bottomLeft: !message.isUser ? const Radius.circular(0) : const Radius.circular(20),
          ),
          border: message.isUser ? Border.all(color: AppColors.accent.withValues(alpha: 0.3)) : Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 14, color: AppColors.accent),
                    SizedBox(width: 4),
                    Text('Maya', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
            Text(
              message.text,
              style: const TextStyle(color: AppColors.textPrimary, height: 1.4),
            ),
            if (message.improvement != null && message.improvement!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF64D2FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF64D2FF).withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.tips_and_updates, color: Color(0xFF64D2FF), size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message.improvement!,
                        style: const TextStyle(color: Color(0xFFE0F7FF), fontSize: 13, height: 1.4),
                      ),
                    ),
                  ],
                ),
              )
            ],
            if (message.target != null && message.target != 'today') ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // In a real app, you would use a global navigator key or
                  // pop this screen and set the main tab index.
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Go to ${message.target}',
                  style: const TextStyle(color: AppColors.accent, decoration: TextDecoration.underline),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class _LoadingBubble extends StatelessWidget {
  const _LoadingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20).copyWith(bottomLeft: const Radius.circular(0)),
          border: Border.all(color: AppColors.border),
        ),
        child: const SizedBox(
          width: 40,
          height: 16,
          child: Center(
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final ValueChanged<String> onSend;

  const _ChatInput({
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Talk to Maya...',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.bg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onSubmitted: isSending ? null : (v) {
                if (v.trim().isNotEmpty) {
                  controller.clear();
                  onSend(v);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: isSending ? null : () {
              if (controller.text.trim().isNotEmpty) {
                final text = controller.text;
                controller.clear();
                onSend(text);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Color(0xFFBF5AF2), Color(0xFF64D2FF)]),
              ),
              child: isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
