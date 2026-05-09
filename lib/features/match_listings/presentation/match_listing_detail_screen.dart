import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/glass_tokens.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_avatar_ring.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';

class MatchListingDetailScreen extends StatelessWidget {
  final String matchId;

  const MatchListingDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real data from provider
    final mockMatch = {
      'id': matchId,
      'title': '5v5 Halı Saha Maçı',
      'description':
          'Kadıköy\'de düzenlenecek halı saha maçımıza katılmak isteyen oyuncular arıyoruz. Seviye orta-iyi arası.',
      'location': 'Kadıköy Spor Kompleksi',
      'address': 'Caferağa Mah. Moda Cad. No:123 Kadıköy/İstanbul',
      'date': '15 Mayıs 2026',
      'time': '19:00',
      'duration': '90 dakika',
      'price': '₺150',
      'pricePerPerson': '₺30',
      'playersNeeded': 3,
      'totalPlayers': 10,
      'skillLevel': 'Orta-İyi',
      'fieldType': 'Halı Saha',
      'organizer': {
        'name': 'Mehmet Demir',
        'rating': 4.8,
        'matchesOrganized': 24,
        'avatarUrl': null,
      },
      'joinedPlayers': [
        {'name': 'Ali Yılmaz', 'position': 'Forvet', 'avatarUrl': null},
        {'name': 'Veli Kaya', 'position': 'Defans', 'avatarUrl': null},
        {'name': 'Ahmet Can', 'position': 'Kaleci', 'avatarUrl': null},
      ],
    };

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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(
                    12.8,
                  ), // 20% reduction from 16 (AppSpacing.lg)
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(mockMatch),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from 16 (AppSpacing.lg)
                      _buildInfoCard(mockMatch),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from 16 (AppSpacing.lg)
                      _buildOrganizerCard(
                        mockMatch['organizer'] as Map<String, dynamic>,
                      ),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from 16 (AppSpacing.lg)
                      _buildJoinedPlayersCard(mockMatch),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from 16 (AppSpacing.lg)
                      _buildDescriptionCard(mockMatch),
                      const SizedBox(
                        height: 12.8,
                      ), // 20% reduction from 16 (AppSpacing.lg)
                      _buildLocationCard(mockMatch),
                      const SizedBox(height: 80), // 20% reduction from 100
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, mockMatch),
    );
  }

  Widget _buildHeader(Map<String, dynamic> match) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          match['title'],
          style: GoogleFonts.inter(
            fontSize: 22.4, // 20% reduction from 28
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.6, // 20% reduction from 12 (AppSpacing.md)
                vertical: 3.2, // 20% reduction from 4 (AppSpacing.xs)
              ),
              decoration: const BoxDecoration(
                gradient: AppColors.gradientPrimary,
                borderRadius: AppRadii.brSm,
              ),
              child: Text(
                '${match['playersNeeded']} Oyuncu Aranıyor',
                style: GoogleFonts.inter(
                  fontSize: 9.6, // 20% reduction from 12
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 6.4), // 20% reduction from 8 (AppSpacing.sm)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.6, // 20% reduction from 12 (AppSpacing.md)
                vertical: 3.2, // 20% reduction from 4 (AppSpacing.xs)
              ),
              decoration: BoxDecoration(
                color: AppColors.glassTintLight,
                borderRadius: AppRadii.brSm,
                border: Border.all(color: AppColors.glassBorderSoft),
              ),
              child: Text(
                match['skillLevel'],
                style: GoogleFonts.inter(
                  fontSize: 9.6, // 20% reduction from 12
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(Map<String, dynamic> match) {
    return GlassCard(
      intensity: GlassIntensity.regular, // Primary content
      child: Column(
        children: [
          _buildInfoRow(Icons.calendar_today_outlined, 'Tarih', match['date']),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          _buildInfoRow(
            Icons.access_time_outlined,
            'Saat',
            '${match['time']} (${match['duration']})',
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          _buildInfoRow(
            Icons.sports_soccer_outlined,
            'Saha Tipi',
            match['fieldType'],
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          _buildInfoRow(
            Icons.payments_outlined,
            'Ücret',
            '${match['price']} (Kişi başı ${match['pricePerPerson']})',
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
          ), // 20% reduction from 8 (AppSpacing.sm)
          decoration: const BoxDecoration(
            color: AppColors.glassTintLight,
            borderRadius: AppRadii.brSm,
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.textTertiary,
          ), // 20% reduction from 20
        ),
        const SizedBox(width: 9.6), // 20% reduction from 12 (AppSpacing.md)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 8.8, // 20% reduction from 11
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 1.6,
              ), // 20% reduction from 2 (AppSpacing.xxs)
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 20% reduction from 14
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

  Widget _buildOrganizerCard(Map<String, dynamic> organizer) {
    return GlassCard(
      intensity: GlassIntensity.subtle, // Secondary content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORGANİZATÖR',
            style: GoogleFonts.inter(
              fontSize: 8.8, // 20% reduction from 11
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          Row(
            children: [
              GradientAvatarRing(
                imageUrl: organizer['avatarUrl'],
                size: 48, // 20% reduction from 60
                initials: organizer['name'][0],
              ),
              const SizedBox(
                width: 9.6,
              ), // 20% reduction from 12 (AppSpacing.md)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      organizer['name'],
                      style: GoogleFonts.inter(
                        fontSize: 12.8, // 20% reduction from 16
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 3.2,
                    ), // 20% reduction from 4 (AppSpacing.xs)
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12.8, // 20% reduction from 16
                          color: AppColors.primaryBright,
                        ),
                        const SizedBox(
                          width: 1.6,
                        ), // 20% reduction from 2 (AppSpacing.xxs)
                        Text(
                          '${organizer['rating']}',
                          style: GoogleFonts.inter(
                            fontSize: 11.2, // 20% reduction from 14
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 6.4,
                        ), // 20% reduction from 8 (AppSpacing.sm)
                        Text(
                          '${organizer['matchesOrganized']} maç',
                          style: GoogleFonts.inter(
                            fontSize: 9.6, // 20% reduction from 12
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to organizer profile
                },
                child: Container(
                  padding: const EdgeInsets.all(
                    6.4,
                  ), // 20% reduction from 8 (AppSpacing.sm)
                  decoration: const BoxDecoration(
                    gradient: AppColors.gradientPrimary,
                    borderRadius: AppRadii.brSm,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 16, // 20% reduction from 20
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJoinedPlayersCard(Map<String, dynamic> match) {
    final players = match['joinedPlayers'] as List;
    final totalPlayers = match['totalPlayers'] as int;
    final joinedCount = players.length;

    return GlassCard(
      intensity: GlassIntensity.subtle, // Secondary content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'KATILAN OYUNCULAR',
                style: GoogleFonts.inter(
                  fontSize: 8.8, // 20% reduction from 11
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMuted,
                  letterSpacing: 2,
                ),
              ),
              Text(
                '$joinedCount/$totalPlayers',
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 20% reduction from 14
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBright,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          ...players.map(
            (player) => Padding(
              padding: const EdgeInsets.only(
                bottom: 6.4,
              ), // 20% reduction from 8 (AppSpacing.sm)
              child: _buildPlayerRow(player),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(Map<String, dynamic> player) {
    return Row(
      children: [
        GradientAvatarRing(
          imageUrl: player['avatarUrl'],
          size: 32, // 20% reduction from 40
          initials: player['name'][0],
        ),
        const SizedBox(width: 9.6), // 20% reduction from 12 (AppSpacing.md)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player['name'],
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 20% reduction from 14
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                player['position'],
                style: GoogleFonts.inter(
                  fontSize: 9.6, // 20% reduction from 12
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionCard(Map<String, dynamic> match) {
    return SolidCard(
      // Tertiary content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AÇIKLAMA',
            style: GoogleFonts.inter(
              fontSize: 8.8, // 20% reduction from 11
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          Text(
            match['description'],
            style: GoogleFonts.inter(
              fontSize: 11.2, // 20% reduction from 14
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(Map<String, dynamic> match) {
    return SolidCard(
      // Tertiary content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KONUM',
            style: GoogleFonts.inter(
              fontSize: 8.8, // 20% reduction from 11
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.primaryBright,
                size: 16, // 20% reduction from 20
              ),
              const SizedBox(
                width: 6.4,
              ), // 20% reduction from 8 (AppSpacing.sm)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match['location'],
                      style: GoogleFonts.inter(
                        fontSize: 11.2, // 20% reduction from 14
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 1.6,
                    ), // 20% reduction from 2 (AppSpacing.xxs)
                    Text(
                      match['address'],
                      style: GoogleFonts.inter(
                        fontSize: 9.6, // 20% reduction from 12
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9.6), // 20% reduction from 12 (AppSpacing.md)
          GradientOutlinedButton(
            onPressed: () {
              // TODO: Open in maps
            },
            label: 'Haritada Göster',
            icon: Icons.map_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, Map<String, dynamic> match) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.8, // 20% reduction from 16 (AppSpacing.lg)
        right: 12.8, // 20% reduction from 16 (AppSpacing.lg)
        top: 9.6, // 20% reduction from 12 (AppSpacing.md)
        bottom:
            MediaQuery.of(context).padding.bottom +
            9.6, // 20% reduction from 12 (AppSpacing.md)
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(0.95),
        border: const Border(
          top: BorderSide(color: AppColors.glassBorderSoft, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kişi Başı',
                  style: GoogleFonts.inter(
                    fontSize: 8.8, // 20% reduction from 11
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  match['pricePerPerson'],
                  style: GoogleFonts.inter(
                    fontSize: 19.2, // 20% reduction from 24
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: GradientButton(
              onPressed: () {
                _showJoinDialog(context);
              },
              label: 'Katıl',
            ),
          ),
        ],
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          intensity: GlassIntensity.regular, // Overlay - Tier 1
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.sports_soccer,
                size: 38.4, // 20% reduction from 48
                color: AppColors.primaryBright,
              ),
              const SizedBox(
                height: 12.8,
              ), // 20% reduction from 16 (AppSpacing.lg)
              Text(
                'Maça Katıl',
                style: GoogleFonts.inter(
                  fontSize: 16, // 20% reduction from 20
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: 6.4,
              ), // 20% reduction from 8 (AppSpacing.sm)
              Text(
                'Bu maça katılmak istediğinize emin misiniz?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 20% reduction from 14
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(
                height: 16,
              ), // 20% reduction from 20 (AppSpacing.xl)
              Row(
                children: [
                  Expanded(
                    child: GradientOutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      label: 'İptal',
                    ),
                  ),
                  const SizedBox(
                    width: 9.6,
                  ), // 20% reduction from 12 (AppSpacing.md)
                  Expanded(
                    child: GradientButton(
                      onPressed: () {
                        // TODO: Implement join match
                        Navigator.pop(context);
                      },
                      label: 'Katıl',
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
