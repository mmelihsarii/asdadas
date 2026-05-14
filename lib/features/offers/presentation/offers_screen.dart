import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/widgets/empty_state.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';
import 'package:sahada_dev/data/repositories/offers_repository.dart';
import 'package:sahada_dev/features/offers/application/my_offers_provider.dart';

class OffersScreen extends ConsumerWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offersAsync = ref.watch(myOffersProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: offersAsync.when(
            data: (offersMap) {
              final sentOffers = offersMap['sent'] ?? [];
              final receivedOffers = offersMap['received'] ?? [];
              final allOffers = [...receivedOffers, ...sentOffers];

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.8),
                      child: Text(
                        'Teklifler',
                        style: GoogleFonts.inter(
                          fontSize: 22.4,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  allOffers.isEmpty
                      ? const SliverFillRemaining(
                          child: EmptyState(
                            icon: Icons.inbox_outlined,
                            title: 'Henüz Teklif Yok',
                            description:
                                'Size gelen maç davetleri ve oyuncu talepleri burada görünecek',
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.8),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final offer = allOffers[index];
                              final isSent = sentOffers.contains(offer);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 9.6),
                                child: _buildOfferCard(
                                  context,
                                  ref,
                                  offer,
                                  isSent,
                                ),
                              );
                            }, childCount: allOffers.length),
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
                    'Teklifler yüklenemedi',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 12,
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

  Widget _buildOfferCard(
    BuildContext context,
    WidgetRef ref,
    offer,
    bool isSent,
  ) {
    final offerType = offer.offerType ?? 'match';
    final isMatchInvite = offerType == 'match';
    final status = offer.status ?? 'pending';
    final isPending = status == 'PENDING';

    return SolidCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientAvatarRing(
                imageUrl: null,
                size: 40,
                initials: isSent ? 'S' : 'R',
              ),
              const SizedBox(width: 9.6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSent ? 'Gönderilen Teklif' : 'Gelen Teklif',
                      style: GoogleFonts.inter(
                        fontSize: 11.2,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 1.6),
                    Text(
                      isMatchInvite ? 'Maç Daveti' : 'Oyuncu Talebi',
                      style: GoogleFonts.inter(
                        fontSize: 9.6,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.4,
                  vertical: 3.2,
                ),
                decoration: BoxDecoration(
                  gradient: isMatchInvite
                      ? AppColors.gradientPrimary
                      : AppColors.gradientAccent,
                  borderRadius: AppRadii.brSm,
                ),
                child: Icon(
                  isMatchInvite ? Icons.sports_soccer : Icons.person,
                  color: Colors.black,
                  size: 12.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9.6),
          Container(height: 1, color: AppColors.glassBorderSoft),
          const SizedBox(height: 9.6),
          Text(
            'Teklif ID: ${offer.id}',
            style: GoogleFonts.inter(
              fontSize: 12.8,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6.4),
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 11.2,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 3.2),
              Expanded(
                child: Text(
                  'Durum: ${status}',
                  style: GoogleFonts.inter(
                    fontSize: 9.6,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
          if (!isSent && isPending) ...[
            const SizedBox(height: 12.8),
            Row(
              children: [
                Expanded(
                  child: GradientOutlinedButton(
                    onPressed: () async {
                      await ref
                          .read(offersRepositoryProvider)
                          .updateStatus(offer.id, 'REJECTED');
                      ref.invalidate(myOffersProvider);
                    },
                    label: 'Reddet',
                  ),
                ),
                const SizedBox(width: 9.6),
                Expanded(
                  child: GradientOutlinedButton(
                    onPressed: () async {
                      await ref
                          .read(offersRepositoryProvider)
                          .updateStatus(offer.id, 'ACCEPTED');
                      ref.invalidate(myOffersProvider);
                    },
                    label: 'Kabul Et',
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
