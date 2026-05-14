import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';

class LocationPicker extends StatefulWidget {
  final LatLng? initialLocation;
  final Function(LatLng) onLocationSelected;

  const LocationPicker({
    super.key,
    this.initialLocation,
    required this.onLocationSelected,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late MapController _mapController;
  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    // Default to Istanbul center if no initial location
    _selectedLocation = widget.initialLocation ?? LatLng(41.0082, 28.9784);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSpacing.lg),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Konum Seç',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),

            // Map
            SizedBox(
              height: 400,
              child: ClipRRect(
                borderRadius: AppRadii.brMd,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _selectedLocation,
                    initialZoom: 13,
                    onTap: (tapPosition, point) {
                      setState(() {
                        _selectedLocation = point;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.sahada.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _selectedLocation,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Info and Button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text(
                    'Haritaya dokunarak konum seçin',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${_selectedLocation.latitude.toStringAsFixed(4)}, ${_selectedLocation.longitude.toStringAsFixed(4)}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  GradientButton(
                    onPressed: () {
                      widget.onLocationSelected(_selectedLocation);
                      Navigator.pop(context);
                    },
                    label: 'Konumu Seç',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
