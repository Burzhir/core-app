import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/app_colors.dart';
import '../data/philosophies_data.dart';
import '../providers/ai_chat_provider.dart';
import '../providers/auth_provider.dart' as core;
import '../screens/paywall_screen.dart';

class AiChatScreen extends StatefulWidget {
  final String? initialPhilosophy;
  const AiChatScreen({super.key, this.initialPhilosophy});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _controller = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialPhilosophy != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context
            .read<AiChatProvider>()
            .selectPhilosophy(widget.initialPhilosophy!);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final auth = context.read<core.AuthProvider>();
    final chat = context.read<AiChatProvider>();

    _controller.clear();
    _focusNode.unfocus();

    final ok = await chat.sendMessage(text: text, user: auth.user);

    if (ok) {
      // Increment quota counter in Firestore for free users
      await auth.consumeAiMessage();
    } else if (chat.error != null && mounted) {
      if (!auth.isPremium) {
        _openPaywall(chat.error!);
        chat.clearError();
      }
    }

    _scrollToBottom();
  }

  void _openPaywall(String reason) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.92,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: PaywallScreen(triggerReason: reason),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<AiChatProvider>();
    final auth = context.watch<core.AuthProvider>();

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
        title: chat.selectedPhilosophy == null
            ? const Text(
                'AI Philosopher',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Outfit',
                ),
              )
            : _PhilosopherChip(name: chat.selectedPhilosophy!),
        centerTitle: true,
        actions: [
          if (chat.hasConversation)
            IconButton(
              icon: const Icon(Icons.refresh_rounded,
                  color: AppColors.textMuted, size: 20),
              tooltip: 'New conversation',
              onPressed: () => chat.clearConversation(),
            ),
        ],
      ),
      body: Column(
        children: [
          // Quota bar
          if (!auth.isPremium && auth.user != null)
            _QuotaBar(
                user: auth.user!,
                onUpgrade: () => _openPaywall('Get unlimited AI messages')),

          // Philosophy selector (shown when no philosophy is selected OR as a top picker)
          if (chat.selectedPhilosophy == null)
            Expanded(child: _PhilosophyPicker(onSelect: (name) {
              chat.selectPhilosophy(name);
            }))
          else
            Expanded(
              child: _ChatBody(
                chat: chat,
                scrollController: _scrollCtrl,
              ),
            ),

          // Input
          if (chat.selectedPhilosophy != null)
            _ChatInput(
              controller: _controller,
              focusNode: _focusNode,
              isLoading: chat.isLoading,
              canSend: auth.user?.canSendAiMessage ?? true,
              onSend: _send,
              onUpgrade: () => _openPaywall('Get unlimited AI messages'),
            ),
        ],
      ),
    );
  }
}

// ── Philosopher chip in app bar ────────────────────────────────────────────────

class _PhilosopherChip extends StatelessWidget {
  final String name;
  const _PhilosopherChip({required this.name});

  @override
  Widget build(BuildContext context) {
    final p = kPhilosophies.where((p) => p.name == name).firstOrNull;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (p != null) ...[
          Text(p.emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
        ],
        Text(
          name,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
          ),
        ),
      ],
    );
  }
}

// ── Quota bar ─────────────────────────────────────────────────────────────────

class _QuotaBar extends StatelessWidget {
  final dynamic user;
  final VoidCallback onUpgrade;
  const _QuotaBar({required this.user, required this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    final remaining = user.remainingAiMessages as int;
    final pct = remaining / 5.0;
    final color = pct > 0.4
        ? AppColors.teal
        : pct > 0.2
            ? const Color(0xFFFF9500)
            : const Color(0xFFFF3B30);

    return GestureDetector(
      onTap: remaining == 0 ? onUpgrade : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Icon(Icons.chat_bubble_outline_rounded, color: color, size: 13),
            const SizedBox(width: 6),
            Text(
              remaining == 0
                  ? 'Daily limit reached'
                  : '$remaining free message${remaining == 1 ? '' : 's'} left today',
              style: TextStyle(
                  color: color, fontSize: 11, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            if (remaining == 0)
              Text(
                'Upgrade ↗',
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Philosophy picker ─────────────────────────────────────────────────────────

class _PhilosophyPicker extends StatelessWidget {
  final ValueChanged<String> onSelect;
  const _PhilosophyPicker({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 24, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose a philosopher',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Outfit',
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Each philosopher responds from within their philosophy — not as an encyclopedia, but as a living voice.',
                  style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      height: 1.5),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final p = kPhilosophies[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () => onSelect(p.name),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  p.gradient[0].withValues(alpha: 0.3),
                                  p.gradient[1].withValues(alpha: 0.15),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(p.emoji,
                                  style: const TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.name,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  p.tagline,
                                  style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded,
                              color: AppColors.textMuted, size: 18),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: kPhilosophies.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }
}

// ── Chat body ─────────────────────────────────────────────────────────────────

class _ChatBody extends StatelessWidget {
  final AiChatProvider chat;
  final ScrollController scrollController;

  const _ChatBody({required this.chat, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    if (chat.messages.isEmpty) {
      return _EmptyChat(philosophyName: chat.selectedPhilosophy!);
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: chat.messages.length + (chat.isLoading ? 1 : 0),
      itemBuilder: (context, i) {
        if (i == chat.messages.length) {
          return const _TypingBubble();
        }
        final m = chat.messages[i];
        return _MessageBubble(message: m);
      },
    );
  }
}

class _EmptyChat extends StatelessWidget {
  final String philosophyName;
  const _EmptyChat({required this.philosophyName});

  static const _starters = [
    'What does your philosophy say about failure?',
    'How should I think about a big life decision?',
    'What is the most important thing to focus on?',
    'How do I deal with uncertainty?',
  ];

  @override
  Widget build(BuildContext context) {
    final chat = context.read<AiChatProvider>();
    final p = kPhilosophies.where((p) => p.name == philosophyName).firstOrNull;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: p != null
                  ? LinearGradient(colors: p.gradient)
                  : const LinearGradient(
                      colors: [AppColors.accent, Color(0xFF5E5CE6)]),
              boxShadow: [
                BoxShadow(
                  color: (p?.gradient[0] ?? AppColors.accent)
                      .withValues(alpha: 0.35),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child:
                  Text(p?.emoji ?? '💬', style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Talking with $philosophyName',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ask anything — about life, decisions, struggles, or ideas.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.textSecondary, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 28),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'STARTER QUESTIONS',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ..._starters.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    final auth = context.read<core.AuthProvider>();
                    chat.sendMessage(text: s, user: auth.user);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      s,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentSoft,
                border:
                    Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
              ),
              child: const Icon(Icons.psychology_alt_rounded,
                  color: AppColors.accent, size: 14),
            ),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.accent.withValues(alpha: 0.18)
                    : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                border: Border.all(
                  color: isUser
                      ? AppColors.accent.withValues(alpha: 0.3)
                      : AppColors.border,
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color:
                      isUser ? AppColors.textPrimary : AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.55,
                ),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentSoft,
              border:
                  Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.psychology_alt_rounded,
                color: AppColors.accent, size: 14),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _Dot(delay: i * 200)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  final int delay;
  const _Dot({required this.delay});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: FadeTransition(
        opacity: _anim,
        child: Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

// ── Chat input ────────────────────────────────────────────────────────────────

class _ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isLoading;
  final bool canSend;
  final VoidCallback onSend;
  final VoidCallback onUpgrade;

  const _ChatInput({
    required this.controller,
    required this.focusNode,
    required this.isLoading,
    required this.canSend,
    required this.onSend,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    if (!canSend) {
      return Container(
        padding: EdgeInsets.fromLTRB(
            16, 12, 16, 12 + MediaQuery.of(context).padding.bottom),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: GestureDetector(
          onTap: onUpgrade,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [AppColors.accent, Color(0xFF5E5CE6)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text(
                'Upgrade for unlimited messages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 10, 16, 10 + MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: !isLoading,
              maxLines: null,
              style:
                  const TextStyle(color: AppColors.textPrimary, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Ask anything…',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surfaceAlt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (_) => onSend(),
              textInputAction: TextInputAction.send,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: isLoading ? null : onSend,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isLoading
                    ? null
                    : const LinearGradient(
                        colors: [AppColors.accent, Color(0xFF5E5CE6)]),
                color: isLoading ? AppColors.surfaceAlt : null,
              ),
              child: Icon(
                Icons.arrow_upward_rounded,
                color: isLoading ? AppColors.textMuted : Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
