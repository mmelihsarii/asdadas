import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/glass_tokens.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/features/match_listings/application/match_detail_provider.dart';
import 'package:sahada_dev/data/repositories/participations_repository.dart';

class MatchListingDetailScreen extends ConsumerWidget {
  final String matchId;

  const MatchListingDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchAsync = ref.watch(matchDetailProvider(matchId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: const Text('Maç Detayı'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: matchAsync.when(
            data: (match) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(match),
                          const SizedBox(height: 12.8),
                          _buildInfoCard(match),
                          const SizedBox(height: 12.8),
                          _buildActionButton(context, ref, match),
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
                    'Maç detayı yüklenemedi',
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

  Widget _buildHeader(match) {
    final title = match.title ?? 'Maç';
    final status = match.status ?? 'OPEN';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 22.4,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 9.6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9.6, vertical: 3.2),
          decoration: const BoxDecoration(
            gradient: AppColors.gradientPrimary,
            borderRadius: AppRadii.brSm,
          ),
          child: Text(
            status,
            style: GoogleFonts.inter(
              fontSize: 9.6,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(match) {
    final city = match.city ?? '';
    final district = match.district ?? '';
    final locationName = match.locationName ?? '';

    return GlassCard(
      intensity: GlassIntensity.regular,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            Icons.location_on_outlined,
            'Konum',
            '$city, $district',
          ),
          const SizedBox(height: 9.6),
          _buildInfoRow(Icons.place_outlined, 'Saha', locationName),
          const SizedBox(height: 9.6),
          _buildInfoRow(
            Icons.people_outline,
            'Aranan Oyuncu',
            '${match.neededPlayers ?? 0}',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
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

  Widget _buildActionButton(BuildContext context, WidgetRef ref, match) {
    return GradientButton(
      onPressed: () async {
        try {
          await ref
              .read(participationsRepositoryProvider)
              .create(matchId: match.id, agreedAmount: 0);

          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Maça katıldınız!')));
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Hata: $e')));
          }
        }
      },
      label: 'Maça Katıl',
    );
  }
}
