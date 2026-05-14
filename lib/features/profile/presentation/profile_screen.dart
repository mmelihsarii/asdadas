import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/services/auth_service.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/glass_tokens.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/features/profile/application/current_user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final statsAsync = ref.watch(currentUserStatsProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: userAsync.when(
            data: (user) {
              if (user == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_off,
                        size: 64,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Kullanıcı bulunamadı',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.8),
                      child: Column(
                        children: [
                          _buildHeader(context),
                          const SizedBox(height: 16),
                          _buildProfileCard(user),
                          const SizedBox(height: 12.8),
                          statsAsync.when(
                            data: (stats) => _buildStatsCard(stats),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (_, __) => _buildStatsCard({}),
                          ),
                          const SizedBox(height: 12.8),
                          _buildSettingsCard(context),
                          const SizedBox(height: 12.8),
                          _buildLogoutButton(context, ref),
                        ],
                      ),
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
                    'Hata: $error',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
            context.push('/profile/edit');
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

  Widget _buildProfileCard(user) {
    final name = user.name ?? 'Kullanıcı';
    final email = user.email ?? '';
    final role = user.role ?? 'player';
    final city = user.city ?? '';
    final district = user.district ?? '';

    return GlassCard(
      intensity: GlassIntensity.regular,
      child: Column(
        children: [
          // Avatar
          GradientAvatarRing(
            imageUrl: user.avatarUrl,
            size: 80,
            initials: name.isNotEmpty ? name[0].toUpperCase() : 'U',
          ),
          const SizedBox(height: 9.6),

          // Name
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 19.2,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3.2),

          // Role badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9.6, vertical: 3.2),
            decoration: const BoxDecoration(
              gradient: AppColors.gradientPrimary,
              borderRadius: AppRadii.brSm,
            ),
            child: Text(
              role == 'organizer' ? 'Organizatör' : 'Oyuncu',
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
          _buildInfoRow(Icons.email_outlined, 'E-posta', email),
          const SizedBox(height: 9.6),
          _buildInfoRow(Icons.location_city_outlined, 'Şehir', city),
          const SizedBox(height: 9.6),
          _buildInfoRow(Icons.location_on_outlined, 'İlçe', district),
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

  Widget _buildStatsCard(Map<String, dynamic> stats) {
    final totalMatches = stats['total_matches'] ?? 0;
    final wonMatches = stats['won_matches'] ?? 0;
    final rating = stats['rating_avg']?.toStringAsFixed(1) ?? '0.0';

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
                child: _buildStatItem(
                  'Toplam Maç',
                  totalMatches.toString(),
                  Icons.sports_soccer,
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.glassBorderSoft),
              Expanded(
                child: _buildStatItem(
                  'Kazanılan',
                  wonMatches.toString(),
                  Icons.emoji_events,
                ),
              ),
              Container(width: 1, height: 40, color: AppColors.glassBorderSoft),
              Expanded(child: _buildStatItem('Puan', rating, Icons.star)),
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
              context.push('/notifications');
            },
          ),
          const SizedBox(height: 6.4),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Gizlilik',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Gizlilik ayarları yakında eklenecek'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(height: 6.4),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Yardım & Destek',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Yardım & Destek yakında eklenecek'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          const SizedBox(height: 6.4),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'Hakkında',
            onTap: () {
              _showAboutDialog(context);
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
        decoration: const BoxDecoration(
          color: AppColors.glassTintLight,
          borderRadius: AppRadii.brMd,
          border: Border(
            top: BorderSide(color: AppColors.glassBorderSoft),
            bottom: BorderSide(color: AppColors.glassBorderSoft),
            left: BorderSide(color: AppColors.glassBorderSoft),
            right: BorderSide(color: AppColors.glassBorderSoft),
          ),
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

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return GradientOutlinedButton(
      onPressed: () {
        _showLogoutDialog(context, ref);
      },
      label: 'Çıkış Yap',
      icon: Icons.logout,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
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
                      compact: true,
                    ),
                  ),
                  const SizedBox(width: 9.6),
                  Expanded(
                    child: GradientButton(
                      onPressed: () async {
                        // Logout from Supabase
                        await ref.read(authServiceProvider).signOut();

                        if (context.mounted) {
                          Navigator.pop(context);
                          context.go('/login');
                        }
                      },
                      label: 'Çıkış Yap',
                      compact: true,
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

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12.8),
                decoration: const BoxDecoration(
                  gradient: AppColors.gradientPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sports_soccer,
                  size: 32,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12.8),
              Text(
                'Sahada',
                style: GoogleFonts.inter(
                  fontSize: 19.2,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 3.2),
              Text(
                'Versiyon 1.0.0',
                style: GoogleFonts.inter(
                  fontSize: 11.2,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Futbol tutkunlarını bir araya getiren sosyal platform',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11.2,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12.8),
                decoration: const BoxDecoration(
                  color: AppColors.glassTintLight,
                  borderRadius: AppRadii.brMd,
                  border: Border(
                    top: BorderSide(color: AppColors.glassBorderSoft),
                    bottom: BorderSide(color: AppColors.glassBorderSoft),
                    left: BorderSide(color: AppColors.glassBorderSoft),
                    right: BorderSide(color: AppColors.glassBorderSoft),
                  ),
                ),
                child: Column(
                  children: [
                    _buildAboutRow(Icons.code, 'Geliştirici', 'Sahada Team'),
                    const SizedBox(height: 9.6),
                    _buildAboutRow(Icons.email, 'İletişim', 'info@sahada.app'),
                    const SizedBox(height: 9.6),
                    _buildAboutRow(Icons.language, 'Web', 'www.sahada.app'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GradientButton(
                onPressed: () => Navigator.pop(context),
                label: 'Kapat',
                compact: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textTertiary),
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
                ),
              ),
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
}
