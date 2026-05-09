import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatScreen({super.key, required this.userId, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // TODO: Fetch real messages from provider
  final List<Map<String, dynamic>> _mockMessages = [
    {
      'id': '1',
      'text': 'Merhaba! Maça katılmak istiyorum.',
      'isMine': false,
      'timestamp': '10:25',
    },
    {
      'id': '2',
      'text': 'Harika! Hoş geldin. Saat 19:00\'da başlıyoruz.',
      'isMine': true,
      'timestamp': '10:26',
    },
    {
      'id': '3',
      'text': 'Hangi pozisyonda oynuyorsun?',
      'isMine': true,
      'timestamp': '10:26',
    },
    {
      'id': '4',
      'text': 'Genelde orta sahada oynuyorum.',
      'isMine': false,
      'timestamp': '10:28',
    },
    {
      'id': '5',
      'text': 'Mükemmel! Tam ihtiyacımız olan pozisyon.',
      'isMine': true,
      'timestamp': '10:29',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(widget.userName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show chat options
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: _mockMessages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(_mockMessages[index]);
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMine = message['isMine'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        mainAxisAlignment: isMine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMine) ...[
            GradientAvatarRing(
              imageUrl: null,
              size: 32,
              initials: widget.userName[0],
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    gradient: isMine ? AppColors.gradientPrimary : null,
                    color: isMine ? null : AppColors.glassTintLight,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: isMine
                          ? const Radius.circular(12)
                          : Radius.zero,
                      bottomRight: isMine
                          ? Radius.zero
                          : const Radius.circular(12),
                    ),
                    border: isMine
                        ? null
                        : Border.all(color: AppColors.glassBorderSoft),
                  ),
                  child: Text(
                    message['text'],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isMine ? Colors.black : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  message['timestamp'],
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          if (isMine) const SizedBox(width: AppSpacing.xs),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(0.95),
        border: const Border(
          top: BorderSide(color: AppColors.glassBorderSoft, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.glassTintLight,
                borderRadius: AppRadii.brLg,
                border: Border.all(color: AppColors.glassBorderSoft),
              ),
              child: TextField(
                controller: _messageController,
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: 'Mesaj yaz...',
                  hintStyle: GoogleFonts.inter(
                    color: AppColors.textMuted,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                maxLines: null,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: _handleSendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                gradient: AppColors.gradientPrimary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    // TODO: Implement send message
    _messageController.clear();
  }
}
