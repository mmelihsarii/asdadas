import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/empty_state.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/features/messages/application/my_chats_provider.dart';
import 'package:sahada_dev/features/messages/application/last_message_provider.dart';

class MessagesListScreen extends ConsumerWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsAsync = ref.watch(myChatsProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: chatsAsync.when(
            data: (chats) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        'Mesajlar',
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  chats.isEmpty
                      ? const SliverFillRemaining(
                          child: EmptyState(
                            icon: Icons.chat_bubble_outline,
                            title: 'Henüz Mesaj Yok',
                            description:
                                'Diğer oyuncularla mesajlaşmaya başladığınızda konuşmalar burada görünecek',
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.md,
                                ),
                                child: _buildConversationCard(
                                  context,
                                  ref,
                                  chats[index],
                                ),
                              );
                            }, childCount: chats.length),
                          ),
                        ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.danger,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Mesajlar yüklenemedi',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConversationCard(BuildContext context, WidgetRef ref, chat) {
    // Chat model'den gerekli bilgileri al
    final chatId = chat.id;
    final lastMessageAsync = ref.watch(lastMessageProvider(chatId));
    final timestamp = chat.createdAt?.toString().substring(11, 16) ?? '';

    return SolidCard(
      onTap: () {
        // Navigate to chat detail screen
        context.push('/chat/$chatId');
      },
      child: Row(
        children: [
          const GradientAvatarRing(imageUrl: null, size: 48, initials: 'C'),
          const SizedBox(width: 9.6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chat $chatId',
                      style: GoogleFonts.inter(
                        fontSize: 12.8,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      timestamp,
                      style: GoogleFonts.inter(
                        fontSize: 8.8,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                lastMessageAsync.when(
                  data: (message) => Text(
                    message?.body ?? 'Henüz mesaj yok',
                    style: GoogleFonts.inter(
                      fontSize: 11.2,
                      color: AppColors.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  loading: () => Text(
                    'Yükleniyor...',
                    style: GoogleFonts.inter(
                      fontSize: 11.2,
                      color: AppColors.textMuted,
                    ),
                  ),
                  error: (_, __) => Text(
                    'Mesaj yüklenemedi',
                    style: GoogleFonts.inter(
                      fontSize: 11.2,
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
