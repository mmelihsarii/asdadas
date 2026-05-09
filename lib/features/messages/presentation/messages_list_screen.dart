import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/empty_state.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';

class MessagesListScreen extends StatelessWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real conversations from provider
    final mockConversations = [
      {
        'id': '1',
        'name': 'Mehmet Demir',
        'lastMessage': 'Maç için hazır mısın?',
        'timestamp': '10:30',
        'unreadCount': 2,
        'avatarUrl': null,
      },
      {
        'id': '2',
        'name': 'Ali Yılmaz',
        'lastMessage': 'Saha rezervasyonu yaptım',
        'timestamp': 'Dün',
        'unreadCount': 0,
        'avatarUrl': null,
      },
      {
        'id': '3',
        'name': 'Veli Kaya',
        'lastMessage': 'Teşekkürler!',
        'timestamp': '2 gün önce',
        'unreadCount': 0,
        'avatarUrl': null,
      },
    ];

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: CustomScrollView(
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
              mockConversations.isEmpty
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
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.md,
                            ),
                            child: _buildConversationCard(
                              context,
                              mockConversations[index],
                            ),
                          );
                        }, childCount: mockConversations.length),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversationCard(
    BuildContext context,
    Map<String, dynamic> conversation,
  ) {
    final hasUnread = (conversation['unreadCount'] as int) > 0;

    return SolidCard(
      onTap: () {
        // TODO: Navigate to chat screen
      },
      child: Row(
        children: [
          Stack(
            children: [
              GradientAvatarRing(
                imageUrl: conversation['avatarUrl'],
                size: 48,
                initials: conversation['name'][0],
              ),
              if (hasUnread)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: AppColors.gradientPrimary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.backgroundDark,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      '${conversation['unreadCount']}',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 9.6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      conversation['name'],
                      style: GoogleFonts.inter(
                        fontSize: 12.8,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      conversation['timestamp'],
                      style: GoogleFonts.inter(
                        fontSize: 8.8,
                        color: hasUnread
                            ? AppColors.primaryBright
                            : AppColors.textMuted,
                        fontWeight: hasUnread
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  conversation['lastMessage'],
                  style: GoogleFonts.inter(
                    fontSize: 11.2,
                    color: hasUnread
                        ? AppColors.textSecondary
                        : AppColors.textTertiary,
                    fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
