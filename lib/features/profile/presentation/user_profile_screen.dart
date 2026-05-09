import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/glass_tokens.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real user data from provider
    final mockUser = {
      'id': userId,
      'firstName': 'Mehmet',
      'lastName': 'Demir',
      'position': 'Orta Saha',
      'skillLevel': 'İyi',
      'preferredFoot': 'Sağ',
      'bio': 'Futbol tutkunu, hafta sonları düzenli olarak maç yapıyorum.',
      'avatarUrl': null,
      'rating': 4.8,
      'matchesPlayed': 24,
      'matchesOrganized': 12,
    };

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: const Text('Profil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(
                    12.8,
                  ), // 20% reduction from AppSpacing.lg (16px)
                  child: Column(
                    children: [
                      _buildProfileHeader(mockUser),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from AppSpacing.lg (16px)
                      _buildStatsCard(mockUser),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from AppSpacing.lg (16px)
                      _buildInfoCard(mockUser),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from AppSpacing.lg (16px)
                      _buildBioCard(mockUser),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from AppSpacing.lg (16px)
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> user) {
    return Column(
      children: [
        GradientAvatarRing(
          imageUrl: user['avatarUrl'],
          size: 96, // 20% reduction from 120
          initials: '${user['firstName'][0]}${user['lastName'][0]}',
        ),
        const SizedBox(height: 9.6), // 20% reduction from AppSpacing.md (12px)
        Text(
          '${user['firstName']} ${user['lastName']}',
          style: GoogleFonts.inter(
            fontSize: 19.2, // 20% reduction from 24px
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 3.2), // 20% reduction from AppSpacing.xs (4px)
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9.6, // 20% reduction from AppSpacing.md (12px)
            vertical: 3.2, // 20% reduction from AppSpacing.xs (4px)
          ),
          decoration: const BoxDecoration(
            gradient: AppColors.gradientPrimary,
            borderRadius: AppRadii.brSm,
          ),
          child: Text(
            user['position'],
            style: GoogleFonts.inter(
              fontSize: 9.6, // 20% reduction from 12px
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 6.4), // 20% reduction from AppSpacing.sm (8px)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 16,
              color: AppColors.primaryBright,
            ), // 20% reduction from 20px
            const SizedBox(
              width: 3.2,
            ), // 20% reduction from AppSpacing.xs (4px)
            Text(
              '${user['rating']}',
              style: GoogleFonts.inter(
                fontSize: 14.4, // 20% reduction from 18px
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCard(Map<String, dynamic> user) {
    return GlassCard(
      intensity:
          GlassIntensity.regular, // Primary content - keep regular intensity
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              'Oynanan Maç',
              '${user['matchesPlayed']}',
              Icons.sports_soccer,
            ),
          ),
          Container(
            width: 1,
            height: 32,
            color: AppColors.glassBorderSoft,
          ), // 20% reduction from 40px
          Expanded(
            child: _buildStatItem(
              'Organize Edilen',
              '${user['matchesOrganized']}',
              Icons.event,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primaryBright,
          size: 19.2,
        ), // 20% reduction from 24px
        const SizedBox(height: 3.2), // 20% reduction from AppSpacing.xs (4px)
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16, // 20% reduction from 20px
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 1.6), // 20% reduction from AppSpacing.xxs (2px)
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 8.8,
            color: AppColors.textTertiary,
          ), // 20% reduction from 11px
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoCard(Map<String, dynamic> user) {
    return GlassCard(
      intensity:
          GlassIntensity.subtle, // Secondary content - use subtle intensity
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BİLGİLER',
            style: GoogleFonts.inter(
              fontSize: 8.8, // 20% reduction from 11px
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 9.6,
          ), // 20% reduction from AppSpacing.md (12px)
          _buildInfoRow(Icons.sports_outlined, 'Seviye', user['skillLevel']),
          const SizedBox(
            height: 9.6,
          ), // 20% reduction from AppSpacing.md (12px)
          _buildInfoRow(
            Icons.sports_soccer_outlined,
            'Tercih Edilen Ayak',
            user['preferredFoot'],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(
            6.4,
          ), // 20% reduction from AppSpacing.sm (8px)
          decoration: const BoxDecoration(
            color: AppColors.glassTintLight,
            borderRadius: AppRadii.brSm,
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.textTertiary,
          ), // 20% reduction from 20px
        ),
        const SizedBox(width: 9.6), // 20% reduction from AppSpacing.md (12px)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 8.8, // 20% reduction from 11px
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 1.6,
              ), // 20% reduction from AppSpacing.xxs (2px)
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 20% reduction from 14px
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBioCard(Map<String, dynamic> user) {
    if (user['bio'] == null || (user['bio'] as String).isEmpty) {
      return const SizedBox.shrink();
    }

    return SolidCard(
      // Tertiary content - use SolidCard
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HAKKINDA',
            style: GoogleFonts.inter(
              fontSize: 8.8, // 20% reduction from 11px
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 9.6,
          ), // 20% reduction from AppSpacing.md (12px)
          Text(
            user['bio'],
            style: GoogleFonts.inter(
              fontSize: 11.2, // 20% reduction from 14px
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        GradientButton(
          onPressed: () {
            // TODO: Navigate to chat
          },
          label: 'Mesaj Gönder',
          icon: Icons.chat_bubble_outline,
        ),
        const SizedBox(height: 9.6), // 20% reduction from AppSpacing.md (12px)
        GradientOutlinedButton(
          onPressed: () {
            // TODO: Report user
          },
          label: 'Şikayet Et',
          icon: Icons.flag_outlined,
        ),
      ],
    );
  }
}
