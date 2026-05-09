import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/theme/glass_tokens.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/glass_container.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/gradient_outlined_button.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';

enum ViewMode { map, list }

enum ListingType { all, matches, players }

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ViewMode _viewMode = ViewMode.map;
  ListingType _listingType = ListingType.all;
  bool _showFilters = false;

  // Map controller
  final MapController _mapController = MapController();

  // Default location (Istanbul)
  final LatLng _center = const LatLng(41.0082, 28.9784);

  // Mock data - will be replaced with real data
  final List<Map<String, dynamic>> _mockListings = [
    {
      'id': '1',
      'type': 'match',
      'title': '5v5 Halı Saha Maçı',
      'location': 'Kadıköy Spor Kompleksi',
      'date': '15 Mayıs, 19:00',
      'price': '₺150',
      'playersNeeded': 3,
      'lat': 40.9900,
      'lng': 29.0250,
    },
    {
      'id': '2',
      'type': 'player',
      'title': 'Forvet Arıyoruz',
      'location': 'Beşiktaş Sahası',
      'date': '16 Mayıs, 20:00',
      'position': 'Forvet',
      'lat': 41.0400,
      'lng': 29.0100,
    },
    {
      'id': '3',
      'type': 'match',
      'title': '7v7 Turnuva Maçı',
      'location': 'Sarıyer Spor Tesisi',
      'date': '17 Mayıs, 18:00',
      'price': '₺200',
      'playersNeeded': 5,
      'lat': 41.1500,
      'lng': 29.0500,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content (Map or List)
          _viewMode == ViewMode.map ? _buildMapView() : _buildListView(),

          // Top controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                12.8,
              ), // Task 12.6: Reduced from 16px to 12.8px (20% reduction)
              child: Column(
                children: [
                  _buildTopControls(),
                  if (_showFilters) ...[
                    const SizedBox(
                      height: 9.6,
                    ), // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
                    _buildFilters(),
                  ],
                ],
              ),
            ),
          ),

          // Floating action button
          Positioned(
            right: AppSpacing.lg,
            bottom:
                90, // Bottom bar yüksekliği + padding (genellikle 56 + 34 = 90)
            child: _buildCreateButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _center,
        initialZoom: 12.0,
        minZoom: 10.0,
        maxZoom: 18.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        // OpenStreetMap tiles
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.sahada.dev',
          maxNativeZoom: 19,
          maxZoom: 19,
          tileSize: 256,
          keepBuffer: 5,
          retinaMode: false,
          tileProvider: NetworkTileProvider(),
          tileBuilder: (context, widget, tile) {
            // Dark mode filter for tiles
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.3),
                BlendMode.darken,
              ),
              child: widget,
            );
          },
        ),

        // Markers for listings
        MarkerLayer(
          markers: _getFilteredListings().map((listing) {
            return Marker(
              point: LatLng(listing['lat'], listing['lng']),
              width: 50,
              height: 50,
              child: GestureDetector(
                onTap: () => _showListingDetail(listing),
                child: _buildMarker(listing),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMarker(Map<String, dynamic> listing) {
    final isMatch = listing['type'] == 'match';
    return Container(
      decoration: BoxDecoration(
        gradient: isMatch
            ? AppColors.gradientPrimary
            : AppColors.gradientAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (isMatch ? AppColors.primaryBright : AppColors.accentCyan)
                .withValues(alpha: 0.3), // 0.5 * 0.6 = 0.3 (%40 azaltıldı)
            blurRadius:
                7.2, // Task 12.7: Reduced from 12px to 7.2px (40% reduction)
            spreadRadius: 1.2, // 2 * 0.6 = 1.2 (%40 azaltıldı)
          ),
        ],
      ),
      child: Icon(
        isMatch ? Icons.sports_soccer : Icons.person,
        color: Colors.black,
        size: 19.2, // Task 12.6: Reduced from 24px to 19.2px (20% reduction)
      ),
    );
  }

  Widget _buildListView() {
    final listings = _getFilteredListings();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundDark,
            AppColors.backgroundDark.withValues(alpha: 0.95),
          ],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: 140,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: 100,
        ),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 9.6,
            ), // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
            child: _buildListingCard(listings[index]),
          );
        },
      ),
    );
  }

  Widget _buildTopControls() {
    return Row(
      children: [
        // View mode toggle - Task 12.1: Changed from GlassContainer to solid Container
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadii.brMd,
              border: Border.all(color: AppColors.glassBorderSoft, width: 1),
            ),
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Row(
              children: [
                Expanded(
                  child: _buildViewModeButton(
                    icon: Icons.map_outlined,
                    label: 'Harita',
                    isActive: _viewMode == ViewMode.map,
                    onTap: () => setState(() => _viewMode = ViewMode.map),
                  ),
                ),
                Expanded(
                  child: _buildViewModeButton(
                    icon: Icons.list,
                    label: 'Liste',
                    isActive: _viewMode == ViewMode.list,
                    onTap: () => setState(() => _viewMode = ViewMode.list),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 6.4,
        ), // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
        // Filter button - Task 12.2: Keep GlassContainer (small element, acceptable usage)
        GestureDetector(
          onTap: () => setState(() => _showFilters = !_showFilters),
          child: GlassContainer(
            padding: const EdgeInsets.all(
              9.6,
            ), // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
            child: Icon(
              _showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              color: _showFilters
                  ? AppColors.primaryBright
                  : AppColors.textPrimary,
              size:
                  19.2, // Task 12.6: Reduced from 24px to 19.2px (20% reduction)
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewModeButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6.4,
        ), // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.gradientPrimary : null,
          borderRadius: AppRadii.brSm,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.black : AppColors.textTertiary,
              size:
                  14.4, // Task 12.6: Reduced from 18px to 14.4px (20% reduction)
            ),
            const SizedBox(
              width: 3.2,
            ), // Task 12.6: Reduced from 4px to 3.2px (20% reduction)
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize:
                    9.6, // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.black : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    // Task 12.3: Changed to GlassCard with subtle intensity
    return GlassCard(
      intensity: GlassIntensity.subtle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'İLAN TİPİ',
            style: GoogleFonts.inter(
              fontSize:
                  8.8, // Task 12.6: Reduced from 11px to 8.8px (20% reduction)
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing:
                  1.6, // Task 12.6: Reduced from 2 to 1.6 (20% reduction)
            ),
          ),
          const SizedBox(
            height: 6.4,
          ), // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
          Row(
            children: [
              Expanded(
                child: _buildFilterChip(
                  'Tümü',
                  _listingType == ListingType.all,
                  () => setState(() => _listingType = ListingType.all),
                ),
              ),
              const SizedBox(
                width: 3.2,
              ), // Task 12.6: Reduced from 4px to 3.2px (20% reduction)
              Expanded(
                child: _buildFilterChip(
                  'Maçlar',
                  _listingType == ListingType.matches,
                  () => setState(() => _listingType = ListingType.matches),
                ),
              ),
              const SizedBox(
                width: 3.2,
              ), // Task 12.6: Reduced from 4px to 3.2px (20% reduction)
              Expanded(
                child: _buildFilterChip(
                  'Oyuncular',
                  _listingType == ListingType.players,
                  () => setState(() => _listingType = ListingType.players),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6.4, // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
          horizontal:
              9.6, // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
        ),
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.gradientPrimary : null,
          color: isActive ? null : AppColors.glassTintLight,
          borderRadius: AppRadii.brSm,
          border: Border.all(
            color: isActive ? Colors.transparent : AppColors.glassBorderSoft,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize:
                9.6, // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.black : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildListingCard(Map<String, dynamic> listing) {
    final isMatch = listing['type'] == 'match';

    // Task 12.4: Changed from GlassCard to SolidCard for list view
    return GestureDetector(
      onTap: () => _showListingDetail(listing),
      child: SolidCard(
        child: Row(
          children: [
            // Icon - Task 12.6: Reduced from 60px to 48px (20% reduction)
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: isMatch
                    ? AppColors.gradientPrimary
                    : AppColors.gradientAccent,
                borderRadius: AppRadii.brMd,
              ),
              child: Icon(
                isMatch ? Icons.sports_soccer : Icons.person,
                color: Colors.black,
                size:
                    22.4, // Task 12.6: Reduced from 28px to 22.4px (20% reduction)
              ),
            ),
            const SizedBox(
              width: 9.6,
            ), // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing['title'],
                    style: GoogleFonts.inter(
                      fontSize:
                          12.8, // Task 12.6: Reduced from 16px to 12.8px (20% reduction)
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 3.2,
                  ), // Task 12.6: Reduced from 4px to 3.2px (20% reduction)
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size:
                            11.2, // Task 12.6: Reduced from 14px to 11.2px (20% reduction)
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(
                        width: 1.6,
                      ), // Task 12.6: Reduced from 2px to 1.6px (20% reduction)
                      Expanded(
                        child: Text(
                          listing['location'],
                          style: GoogleFonts.inter(
                            fontSize:
                                9.6, // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
                            color: AppColors.textTertiary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 1.6,
                  ), // Task 12.6: Reduced from 2px to 1.6px (20% reduction)
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size:
                            11.2, // Task 12.6: Reduced from 14px to 11.2px (20% reduction)
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(
                        width: 1.6,
                      ), // Task 12.6: Reduced from 2px to 1.6px (20% reduction)
                      Text(
                        listing['date'],
                        style: GoogleFonts.inter(
                          fontSize:
                              9.6, // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Badge
            if (isMatch && listing['playersNeeded'] != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal:
                      6.4, // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
                  vertical:
                      3.2, // Task 12.6: Reduced from 4px to 3.2px (20% reduction)
                ),
                decoration: const BoxDecoration(
                  gradient: AppColors.gradientPrimary,
                  borderRadius: AppRadii.brSm,
                ),
                child: Text(
                  '${listing['playersNeeded']} kişi',
                  style: GoogleFonts.inter(
                    fontSize:
                        8.8, // Task 12.6: Reduced from 11px to 8.8px (20% reduction)
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            else if (!isMatch && listing['position'] != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal:
                      6.4, // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
                  vertical:
                      3.2, // Task 12.6: Reduced from 4px to 3.2px (20% reduction)
                ),
                decoration: const BoxDecoration(
                  gradient: AppColors.gradientAccent,
                  borderRadius: AppRadii.brSm,
                ),
                child: Text(
                  listing['position'],
                  style: GoogleFonts.inter(
                    fontSize:
                        8.8, // Task 12.6: Reduced from 11px to 8.8px (20% reduction)
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return GestureDetector(
      onTap: _showCreateOptions,
      child: Container(
        width: 48, // Task 12.6: Reduced from 60px to 48px (20% reduction)
        height: 48, // Task 12.6: Reduced from 60px to 48px (20% reduction)
        decoration: BoxDecoration(
          gradient: AppColors.gradientPrimary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBright.withValues(
                alpha: 0.3,
              ), // 0.5 * 0.6 = 0.3 (%40 azaltıldı)
              blurRadius:
                  12, // Task 12.7: Already reduced from 20px to 12px (40% reduction)
              spreadRadius: 1.2, // 2 * 0.6 = 1.2 (%40 azaltıldı)
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 22.4, // Task 12.6: Reduced from 28px to 22.4px (20% reduction)
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredListings() {
    if (_listingType == ListingType.all) {
      return _mockListings;
    } else if (_listingType == ListingType.matches) {
      return _mockListings.where((l) => l['type'] == 'match').toList();
    } else {
      return _mockListings.where((l) => l['type'] == 'player').toList();
    }
  }

  void _showListingDetail(Map<String, dynamic> listing) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        // Task 12.5: Keep GlassCard with regular intensity for modal sheets (overlays - Tier 1)
        child: GlassCard(
          intensity: GlassIntensity.regular,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                listing['title'],
                style: GoogleFonts.inter(
                  fontSize:
                      16, // Task 12.6: Reduced from 20px to 16px (20% reduction)
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(
                height: 9.6,
              ), // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
              _buildDetailRow(Icons.location_on_outlined, listing['location']),
              const SizedBox(
                height: 6.4,
              ), // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
              _buildDetailRow(Icons.access_time, listing['date']),
              if (listing['price'] != null) ...[
                const SizedBox(
                  height: 6.4,
                ), // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
                _buildDetailRow(Icons.payments_outlined, listing['price']),
              ],
              const SizedBox(height: AppSpacing.lg),
              GradientButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Navigate to detail screen
                },
                label: 'Detayları Gör',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14.4, // Task 12.6: Reduced from 18px to 14.4px (20% reduction)
          color: AppColors.textTertiary,
        ),
        const SizedBox(
          width: 6.4,
        ), // Task 12.6: Reduced from 8px to 6.4px (20% reduction)
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize:
                11.2, // Task 12.6: Reduced from 14px to 11.2px (20% reduction)
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _showCreateOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        // Task 12.5: Keep GlassCard with regular intensity for modal sheets (overlays - Tier 1)
        child: GlassCard(
          intensity: GlassIntensity.regular,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Yeni İlan Oluştur',
                style: GoogleFonts.inter(
                  fontSize:
                      14.4, // Task 12.6: Reduced from 18px to 14.4px (20% reduction)
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GradientButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Navigate to match create screen
                },
                label: 'Maç İlanı Oluştur',
              ),
              const SizedBox(
                height: 9.6,
              ), // Task 12.6: Reduced from 12px to 9.6px (20% reduction)
              GradientOutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Navigate to player create screen
                },
                label: 'Oyuncu İlanı Oluştur',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
