import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/widgets/empty_state.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';

enum MatchFilter { upcoming, past, organized }

class MyMatchesScreen extends StatefulWidget {
  const MyMatchesScreen({super.key});

  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  MatchFilter _filter = MatchFilter.upcoming;

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real matches from provider
    final mockMatches = [
      {
        'id': '1',
        'title': '5v5 Halı Saha Maçı',
        'location': 'Kadıköy Spor Kompleksi',
        'date': '15 Mayıs, 19:00',
        'status': 'upcoming',
        'isOrganizer': true,
        'players': 8,
        'totalPlayers': 10,
      },
      {
        'id': '2',
        'title': '7v7 Turnuva Maçı',
        'location': 'Sarıyer Spor Tesisi',
        'date': '17 Mayıs, 18:00',
        'status': 'upcoming',
        'isOrganizer': false,
        'players': 12,
        'totalPlayers': 14,
      },
    ];

    final filteredMatches = mockMatches.where((match) {
      if (_filter == MatchFilter.upcoming) {
        return match['status'] == 'upcoming';
      } else if (_filter == MatchFilter.past) {
        return match['status'] == 'past';
      } else {
        return match['isOrganizer'] == true;
      }
    }).toList();

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(
                    12.8,
                  ), // 20% reduction from 16px (AppSpacing.lg)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Maçlarım',
                        style: GoogleFonts.inter(
                          fontSize: 22.4, // 20% reduction from 28px
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from 16px (AppSpacing.lg)
                      _buildFilterTabs(),
                    ],
                  ),
                ),
              ),
              filteredMatches.isEmpty
                  ? const SliverFillRemaining(
                      child: EmptyState(
                        icon: Icons.sports_soccer_outlined,
                        title: 'Henüz Maç Yok',
                        description:
                            'Katıldığınız ve organize ettiğiniz maçlar burada görünecek',
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            12.8, // 20% reduction from 16px (AppSpacing.lg)
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom:
                                  9.6, // 20% reduction from 12px (AppSpacing.md)
                            ),
                            child: _buildMatchCard(filteredMatches[index]),
                          );
                        }, childCount: filteredMatches.length),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.brSm,
        border: Border.all(color: AppColors.glassBorderSoft, width: 1),
      ),
      padding: const EdgeInsets.all(
        3.2,
      ), // 20% reduction from 4px (AppSpacing.xs)
      child: Row(
        children: [
          Expanded(child: _buildFilterTab('Yaklaşan', MatchFilter.upcoming)),
          Expanded(child: _buildFilterTab('Geçmiş', MatchFilter.past)),
          Expanded(child: _buildFilterTab('Organize', MatchFilter.organized)),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, MatchFilter filter) {
    final isActive = _filter == filter;
    return GestureDetector(
      onTap: () => setState(() => _filter = filter),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6.4,
        ), // 20% reduction from 8px (AppSpacing.sm)
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.gradientPrimary : null,
          borderRadius: AppRadii.brSm,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 9.6, // 20% reduction from 12px
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to match detail
      },
      child: SolidCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    match['title'],
                    style: GoogleFonts.inter(
                      fontSize: 12.8, // 20% reduction from 16px
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (match['isOrganizer'] == true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.4, // 20% reduction from 8px (AppSpacing.sm)
                      vertical: 3.2, // 20% reduction from 4px (AppSpacing.xs)
                    ),
                    decoration: const BoxDecoration(
                      gradient: AppColors.gradientPrimary,
                      borderRadius: AppRadii.brSm,
                    ),
                    child: Text(
                      'ORGANİZATÖR',
                      style: GoogleFonts.inter(
                        fontSize: 8, // 20% reduction from 10px
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 9.6,
            ), // 20% reduction from 12px (AppSpacing.md)
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 11.2, // 20% reduction from 14px
                  color: AppColors.textTertiary,
                ),
                const SizedBox(
                  width: 3.2,
                ), // 20% reduction from 4px (AppSpacing.xs)
                Expanded(
                  child: Text(
                    match['location'],
                    style: GoogleFonts.inter(
                      fontSize: 9.6, // 20% reduction from 12px
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3.2,
            ), // 20% reduction from 4px (AppSpacing.xs)
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 11.2, // 20% reduction from 14px
                  color: AppColors.textTertiary,
                ),
                const SizedBox(
                  width: 3.2,
                ), // 20% reduction from 4px (AppSpacing.xs)
                Text(
                  match['date'],
                  style: GoogleFonts.inter(
                    fontSize: 9.6, // 20% reduction from 12px
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 9.6,
            ), // 20% reduction from 12px (AppSpacing.md)
            Row(
              children: [
                const Icon(
                  Icons.people,
                  size: 11.2, // 20% reduction from 14px
                  color: AppColors.primaryBright,
                ),
                const SizedBox(
                  width: 3.2,
                ), // 20% reduction from 4px (AppSpacing.xs)
                Text(
                  '${match['players']}/${match['totalPlayers']} Oyuncu',
                  style: GoogleFonts.inter(
                    fontSize: 9.6, // 20% reduction from 12px
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBright,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
