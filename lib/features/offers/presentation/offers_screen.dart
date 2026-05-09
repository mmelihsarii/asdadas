import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/widgets/empty_state.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real offers from provider
    final mockOffers = [
      {
        'id': '1',
        'type': 'match_invite',
        'title': '5v5 Halı Saha Maçı',
        'from': 'Mehmet Demir',
        'date': '15 Mayıs, 19:00',
        'location': 'Kadıköy Spor Kompleksi',
        'status': 'pending',
        'avatarUrl': null,
      },
      {
        'id': '2',
        'type': 'player_request',
        'title': 'Forvet Pozisyonu',
        'from': 'Ali Yılmaz',
        'date': '16 Mayıs, 20:00',
        'location': 'Beşiktaş Sahası',
        'status': 'pending',
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
                  padding: const EdgeInsets.all(
                    12.8,
                  ), // 20% reduction from 16px
                  child: Text(
                    'Teklifler',
                    style: GoogleFonts.inter(
                      fontSize: 22.4, // 20% reduction from 28px
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              mockOffers.isEmpty
                  ? const SliverFillRemaining(
                      child: EmptyState(
                        icon: Icons.inbox_outlined,
                        title: 'Henüz Teklif Yok',
                        description:
                            'Size gelen maç davetleri ve oyuncu talepleri burada görünecek',
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.8, // 20% reduction from 16px
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 9.6, // 20% reduction from 12px
                            ),
                            child: _buildOfferCard(context, mockOffers[index]),
                          );
                        }, childCount: mockOffers.length),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, Map<String, dynamic> offer) {
    final isMatchInvite = offer['type'] == 'match_invite';

    return SolidCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GradientAvatarRing(
                imageUrl: offer['avatarUrl'],
                size: 40, // 20% reduction from 50px
                initials: offer['from'][0],
              ),
              const SizedBox(width: 9.6), // 20% reduction from 12px
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer['from'],
                      style: GoogleFonts.inter(
                        fontSize: 11.2, // 20% reduction from 14px
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 1.6), // 20% reduction from 2px (xxs)
                    Text(
                      isMatchInvite ? 'Maç Daveti' : 'Oyuncu Talebi',
                      style: GoogleFonts.inter(
                        fontSize: 9.6, // 20% reduction from 12px
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.4, // 20% reduction from 8px (sm)
                  vertical: 3.2, // 20% reduction from 4px (xs)
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
                  size: 12.8, // 20% reduction from 16px
                ),
              ),
            ],
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12px (md)
          Container(height: 1, color: AppColors.glassBorderSoft),
          const SizedBox(height: 9.6), // 20% reduction from 12px (md)
          Text(
            offer['title'],
            style: GoogleFonts.inter(
              fontSize: 12.8, // 20% reduction from 16px
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6.4), // 20% reduction from 8px (sm)
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 11.2, // 20% reduction from 14px
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 3.2), // 20% reduction from 4px (xs)
              Expanded(
                child: Text(
                  offer['location'],
                  style: GoogleFonts.inter(
                    fontSize: 9.6, // 20% reduction from 12px
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3.2), // 20% reduction from 4px (xs)
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 11.2, // 20% reduction from 14px
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 3.2), // 20% reduction from 4px (xs)
              Text(
                offer['date'],
                style: GoogleFonts.inter(
                  fontSize: 9.6, // 20% reduction from 12px
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.8), // 20% reduction from 16px (lg)
          Row(
            children: [
              Expanded(
                child: GradientOutlinedButton(
                  onPressed: () {
                    // TODO: Reject offer
                  },
                  label: 'Reddet',
                ),
              ),
              const SizedBox(width: 9.6), // 20% reduction from 12px (md)
              Expanded(
                child: GradientButton(
                  onPressed: () {
                    // TODO: Accept offer
                  },
                  label: 'Kabul Et',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
