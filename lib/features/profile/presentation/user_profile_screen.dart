import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/glass_tokens.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/features/profile/application/user_profile_provider.dart';

class UserProfileScreen extends ConsumerWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider(userId));

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
          child: userAsync.when(
            data: (user) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.8),
                      child: Column(
                        children: [
                          GlassCard(
                            intensity: GlassIntensity.regular,
                            child: Column(
                              children: [
                                GradientAvatarRing(
                                  imageUrl: user.avatarUrl,
                                  size: 80,
                                  initials: user.displayName?.isNotEmpty == true
                                      ? user.displayName![0].toUpperCase()
                                      : 'U',
                                ),
                                const SizedBox(height: 9.6),
                                Text(
                                  user.displayName ?? 'Kullanıcı',
                                  style: GoogleFonts.inter(
                                    fontSize: 19.2,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 3.2),
                                Text(
                                  user.phone ??
                                      user.email ??
                                      'Telefon bilgisi yok',
                                  style: GoogleFonts.inter(
                                    fontSize: 11.2,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                if (user.email != null) ...[
                                  const SizedBox(height: 12.8),
                                  Text(
                                    user.email!,
                                    style: GoogleFonts.inter(
                                      fontSize: 11.2,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
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
                    'Profil yüklenemedi',
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
}
