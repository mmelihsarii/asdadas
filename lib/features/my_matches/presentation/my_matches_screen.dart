import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/widgets/empty_state.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/data/models/enums.dart';
import 'package:sahada_dev/data/models/participation_model.dart';
import 'package:sahada_dev/features/my_matches/application/my_matches_provider.dart';

enum MatchFilter { all, active, completed }

class MyMatchesScreen extends ConsumerStatefulWidget {
  const MyMatchesScreen({super.key});

  @override
  ConsumerState<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends ConsumerState<MyMatchesScreen> {
  MatchFilter _filter = MatchFilter.all;

  @override
  Widget build(BuildContext context) {
    final participationsAsync = ref.watch(myParticipationsProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: participationsAsync.when(
            data: (participations) {
              // Filter based on status
              final filteredParticipations = participations.where((p) {
                if (_filter == MatchFilter.all) return true;
                if (_filter == MatchFilter.active) {
                  return p.status == ParticipationStatus.accepted;
                }
                return p.status != ParticipationStatus.accepted;
              }).toList();

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12.8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maçlarım',
                            style: GoogleFonts.inter(
                              fontSize: 22.4,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12.8),
                          _buildFilterTabs(),
                        ],
                      ),
                    ),
                  ),
                  filteredParticipations.isEmpty
                      ? const SliverFillRemaining(
                          child: EmptyState(
                            icon: Icons.sports_soccer_outlined,
                            title: 'Henüz Maç Yok',
                            description: 'Katıldığınız maçlar burada görünecek',
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.8),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 9.6),
                                child: _buildMatchCard(
                                  filteredParticipations[index],
                                ),
                              );
                            }, childCount: filteredParticipations.length),
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
                    'Maçlar yüklenemedi',
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

  Widget _buildFilterTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadii.brSm,
        border: Border.all(color: AppColors.glassBorderSoft, width: 1),
      ),
      padding: const EdgeInsets.all(3.2),
      child: Row(
        children: [
          Expanded(child: _buildFilterTab('Tümü', MatchFilter.all)),
          Expanded(child: _buildFilterTab('Aktif', MatchFilter.active)),
          Expanded(child: _buildFilterTab('Tamamlanan', MatchFilter.completed)),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, MatchFilter filter) {
    final isActive = _filter == filter;
    return GestureDetector(
      onTap: () => setState(() => _filter = filter),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.4),
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.gradientPrimary : null,
          borderRadius: AppRadii.brSm,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 9.6,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard(Participation participation) {
    final status = participation.status;

    return GestureDetector(
      onTap: () {
        // Navigate to match detail
        context.push('/matches/${participation.matchId}');
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
                    'Maç ID: ${participation.matchId}',
                    style: GoogleFonts.inter(
                      fontSize: 12.8,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.4,
                    vertical: 3.2,
                  ),
                  decoration: BoxDecoration(
                    gradient: status == ParticipationStatus.accepted
                        ? AppColors.gradientPrimary
                        : AppColors.gradientAccent,
                    borderRadius: AppRadii.brSm,
                  ),
                  child: Text(
                    status.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9.6),
            Row(
              children: [
                const Icon(
                  Icons.sports_soccer,
                  size: 11.2,
                  color: AppColors.primaryBright,
                ),
                const SizedBox(width: 3.2),
                Text(
                  'Katılım ID: ${participation.id}',
                  style: GoogleFonts.inter(
                    fontSize: 9.6,
                    color: AppColors.textTertiary,
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
