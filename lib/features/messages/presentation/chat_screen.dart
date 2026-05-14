import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/features/messages/application/chat_messages_provider.dart';
import 'package:sahada_dev/core/services/supabase_service.dart';
import 'package:sahada_dev/data/models/models.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String chatId;
  final String userName;

  const ChatScreen({super.key, required this.chatId, required this.userName});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Listen to text changes to show typing indicator
    _messageController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _messageController.text.trim().isNotEmpty;
    if (hasText != _isTyping) {
      setState(() {
        _isTyping = hasText;
      });
      // TODO: Send typing status to other user via Supabase Realtime
      // For now, just local state
    }
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.chatId));
    final currentUserId = SupabaseService.instance.currentUserId;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.userName),
            // Typing indicator (simulated - would need Realtime for real implementation)
            if (_isTyping)
              Text(
                'yazıyor...',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showChatOptions();
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: messagesAsync.when(
                  data: (messages) {
                    if (messages.isEmpty) {
                      return Center(
                        child: Text(
                          'Henüz mesaj yok\nİlk mesajı gönderin!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMine = message.senderId == currentUserId;
                        return _buildMessageBubble(message, isMine);
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryBright,
                      ),
                    ),
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AppColors.danger,
                          size: 48,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Mesajlar yüklenemedi',
                          style: GoogleFonts.inter(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message, bool isMine) {
    final timeFormat = DateFormat('HH:mm');
    final timestamp = timeFormat.format(message.createdAt.toLocal());

    // Check if message contains an image
    final isImage = message.body.startsWith('[IMAGE]');
    final imageUrl = isImage ? message.body.substring(7) : null;

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
                  padding: isImage
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                  decoration: BoxDecoration(
                    gradient: isMine && !isImage
                        ? AppColors.gradientPrimary
                        : null,
                    color: isMine || isImage ? null : AppColors.glassTintLight,
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
                    border: isMine && !isImage
                        ? null
                        : Border.all(color: AppColors.glassBorderSoft),
                  ),
                  child: isImage && imageUrl != null
                      ? ClipRRect(
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
                          child: GestureDetector(
                            onTap: () => _showImageFullScreen(imageUrl),
                            child: Image.network(
                              imageUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: 200,
                                      height: 200,
                                      color: AppColors.glassTintLight,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                AppColors.primaryBright,
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 200,
                                  height: 200,
                                  color: AppColors.glassTintLight,
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: AppColors.textMuted,
                                      size: 48,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Text(
                          message.body,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: isMine
                                ? Colors.black
                                : AppColors.textPrimary,
                          ),
                        ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  timestamp,
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

  void _showImageFullScreen(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    final sendMessageState = ref.watch(sendMessageProvider);
    final isSending = sendMessageState.isLoading;

    return Container(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).padding.bottom + AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: AppColors.glassBorderSoft, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Image picker button
          IconButton(
            icon: const Icon(
              Icons.image_outlined,
              color: AppColors.primary,
              size: 24,
            ),
            onPressed: isSending ? null : _handleImagePick,
            tooltip: 'Resim gönder',
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.glassTintLight,
                borderRadius: AppRadii.brLg,
                border: Border.all(color: AppColors.glassBorderSoft),
              ),
              child: TextField(
                controller: _messageController,
                enabled: !isSending,
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
                onSubmitted: (_) => _handleSendMessage(),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          GestureDetector(
            onTap: isSending ? null : _handleSendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isSending ? null : AppColors.gradientPrimary,
                color: isSending ? AppColors.glassTintLight : null,
                shape: BoxShape.circle,
              ),
              child: isSending
                  ? const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBright,
                        ),
                      ),
                    )
                  : const Icon(Icons.send, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Clear input immediately for better UX
    _messageController.clear();

    // Send message
    await ref.read(sendMessageProvider.notifier).send(widget.chatId, text);

    // Scroll to bottom after sending
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _handleImagePick() async {
    // Show bottom sheet with options
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: AppColors.glassBorderSoft),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text(
                'Kamera',
                style: GoogleFonts.inter(color: AppColors.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickAndSendImage(isCamera: true);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primary,
              ),
              title: Text(
                'Galeri',
                style: GoogleFonts.inter(color: AppColors.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickAndSendImage(isCamera: false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAndSendImage({required bool isCamera}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      // Show loading
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Resim gönderiliyor...', style: GoogleFonts.inter()),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Upload image to Supabase Storage
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) return;

      final fileName = 'chat_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'chat_images/$userId/$fileName';

      await SupabaseService.instance.storage
          .from('chat-images')
          .upload(path, File(pickedFile.path));

      final imageUrl = SupabaseService.instance.storage
          .from('chat-images')
          .getPublicUrl(path);

      // Send message with image URL
      await ref
          .read(sendMessageProvider.notifier)
          .send(widget.chatId, '[IMAGE]$imageUrl');

      // Scroll to bottom
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Resim gönderildi', style: GoogleFonts.inter()),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Resim gönderilemedi: ${e.toString()}',
              style: GoogleFonts.inter(),
            ),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: AppColors.glassBorderSoft),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: AppColors.danger,
              ),
              title: Text(
                'Sohbeti Temizle',
                style: GoogleFonts.inter(color: AppColors.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                _showClearChatDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppColors.danger),
              title: Text(
                'Kullanıcıyı Engelle',
                style: GoogleFonts.inter(color: AppColors.textPrimary),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Engelleme özelliği yakında eklenecek',
                      style: GoogleFonts.inter(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundDark,
        title: Text(
          'Sohbeti Temizle',
          style: GoogleFonts.inter(color: AppColors.textPrimary),
        ),
        content: Text(
          'Tüm mesajlar silinecek. Bu işlem geri alınamaz.',
          style: GoogleFonts.inter(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'İptal',
              style: GoogleFonts.inter(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Sohbet temizleme özelliği yakında eklenecek',
                    style: GoogleFonts.inter(),
                  ),
                ),
              );
            },
            child: Text(
              'Temizle',
              style: GoogleFonts.inter(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}
