import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/glass_tokens.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Get user data from provider
    final mockUser = {
      'firstName': 'Ahmet',
      'lastName': 'Yılmaz',
      'phone': '+90 555 123 4567',
      'email': 'ahmet@example.com',
      'position': 'Orta Saha',
      'skillLevel': 'Orta',
      'preferredFoot': 'Sağ',
      'avatarUrl': null,
    };

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.8),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 16),
                      _buildProfileCard(mockUser),
                      const SizedBox(height: 12.8),
                      _buildStatsCard(),
                      const SizedBox(height: 12.8),
                      _buildSettingsCard(context),
                      const SizedBox(height: 12.8),
                      _buildLogoutButton(context),
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

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Profilim',
          style: GoogleFonts.inter(
            fontSize: 22.4,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to edit profile
          },
          child: Container(
            padding: const EdgeInsets.all(6.4),
            decoration: const BoxDecoration(
              gradient: AppColors.gradientPrimary,
              borderRadius: AppRadii.brMd,
            ),
            child: const Icon(Icons.edit, color: Colors.black, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> user) {
    return GlassCard(
      intensity: GlassIntensity.regular,
      child: Column(
        children: [
          // Avatar
          GradientAvatarRing(
            imageUrl: user['avatarUrl'],
            size: 80,
            initials: '${user['firstName'][0]}${user['lastName'][0]}',
          ),
          const SizedBox(height: 9.6),

          // Name
          Text(
            '${user['firstName']} ${user['lastName']}',
            style: GoogleFonts.inter(
              fontSize: 19.2,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3.2),

          // Position badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9.6, vertical: 3.2),
            decoration: const BoxDecoration(
              gradient: AppColors.gradientPrimary,
              borderRadius: AppRadii.brSm,
            ),
            child: Text(
              user['position'],
              style: GoogleFonts.inter(
                fontSize: 9.6,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 12.8),

          // Divider
          Container(height: 1, color: AppColors.glassBorderSoft),
          const SizedBox(height: 12.8),

          // Info rows
          _buildInfoRow(Icons.phone_outlined, 'Telefon', user['phone']),
          const SizedBox(height: 9.6),
          _buildInfoRow(Icons.email_outlined, 'E-posta', user['email']),
          const SizedBox(height: 9.6),
          _buildInfoRow(Icons.sports_outlined, 'Seviye', user['skillLevel']),
          const SizedBox(height: 9.6),
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
          padding: const EdgeInsets.all(6.4),
          decoration: const BoxDecoration(
            color: AppColors.glassTintLight,
            borderRadius: AppRadii.brSm,
          ),
          child: Icon(icon, size: 16, color: AppColors.textTertiary),
        ),
        const SizedBox(width: 9.6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 8.8,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 1.6),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 11.2,
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

  Widget _buildStatsCard() {
    return GlassCard(
      intensity: GlassIntensity.subtle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'İSTATİSTİKLER',
            style: GoogleFonts.inter(
              fontSize: 8.8,
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12.8),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Toplam Maç', '24', Icons.sports_soccer),
              ),
              Container(width: 1, height: 40, color: AppColors.glassBorderSoft),
              Expanded(
                child: _buildStatItem('Kazanılan', '18', Icons.emoji_events),
              ),
              Container(width: 1, height: 40, color: AppColors.glassBorderSoft),
              Expanded(child: _buildStatItem('Puan', '4.8', Icons.star)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryBright, size: 19.2),
        const SizedBox(height: 3.2),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 1.6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 8.8,
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    return SolidCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AYARLAR',
            style: GoogleFonts.inter(
              fontSize: 8.8,
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 9.6),
          _buildSettingItem(
            icon: Icons.notifications_outlined,
            title: 'Bildirimler',
            onTap: () {
              // TODO: Navigate to notifications settings
            },
          ),
          const SizedBox(height: 6.4),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Gizlilik',
            onTap: () {
              // TODO: Navigate to privacy settings
            },
          ),
          const SizedBox(height: 6.4),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Yardım & Destek',
            onTap: () {
              // TODO: Navigate to help
            },
          ),
          const SizedBox(height: 6.4),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'Hakkında',
            onTap: () {
              // TODO: Show about dialog
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9.6),
        decoration: BoxDecoration(
          color: AppColors.glassTintLight,
          borderRadius: AppRadii.brMd,
          border: Border.all(color: AppColors.glassBorderSoft),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.textTertiary),
            const SizedBox(width: 9.6),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11.2,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return GradientOutlinedButton(
      onPressed: () {
        _showLogoutDialog(context);
      },
      label: 'Çıkış Yap',
      icon: Icons.logout,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, size: 38.4, color: AppColors.danger),
              const SizedBox(height: 12.8),
              Text(
                'Çıkış Yap',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6.4),
              Text(
                'Hesabınızdan çıkış yapmak istediğinize emin misiniz?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11.2,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GradientOutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      label: 'İptal',
                    ),
                  ),
                  const SizedBox(width: 9.6),
                  Expanded(
                    child: GradientButton(
                      onPressed: () {
                        // TODO: Implement logout
                        Navigator.pop(context);
                      },
                      label: 'Çıkış Yap',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
