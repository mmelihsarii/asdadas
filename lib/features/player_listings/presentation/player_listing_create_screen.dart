import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/core/widgets/location_picker.dart';
import 'package:sahada_dev/data/models/enums.dart';
import 'package:sahada_dev/data/repositories/player_listings_repository.dart';

class PlayerListingCreateScreen extends ConsumerStatefulWidget {
  const PlayerListingCreateScreen({super.key});

  @override
  ConsumerState<PlayerListingCreateScreen> createState() =>
      _PlayerListingCreateScreenState();
}

class _PlayerListingCreateScreenState
    extends ConsumerState<PlayerListingCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  String _description = '';
  String _location = '';
  double _lat = 41.0082; // Default Istanbul
  double _lng = 28.9784; // Default Istanbul
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _position = 'Forvet';
  String _skillLevel = 'Orta';

  final List<String> _positions = [
    'Kaleci',
    'Defans',
    'Orta Saha',
    'Forvet',
    'Kanat',
  ];
  final List<String> _skillLevels = ['Başlangıç', 'Orta', 'İyi', 'Profesyonel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: const Text('Oyuncu İlanı Oluştur'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      12.8,
                    ), // 20% reduction from AppSpacing.lg (16px)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSection('TEMEL BİLGİLER', [
                          _buildTextField(
                            label: 'Açıklama',
                            hint: 'Aranan oyuncu hakkında detaylı bilgi...',
                            icon: Icons.description_outlined,
                            maxLines: 4,
                            onChanged: (value) => _description = value,
                          ),
                        ]),
                        const SizedBox(
                          height: 12.8,
                        ), // 20% reduction from AppSpacing.lg (16px)
                        _buildSection('KONUM', [
                          _buildTextField(
                            label: 'Saha Adı / Konum',
                            hint: 'Örn: Beşiktaş Sahası',
                            icon: Icons.location_on_outlined,
                            onChanged: (value) => _location = value,
                          ),
                          const SizedBox(height: 9.6),
                          GestureDetector(
                            onTap: _showLocationPicker,
                            child: Container(
                              padding: const EdgeInsets.all(12.8),
                              decoration: BoxDecoration(
                                color: AppColors.glassTintLight,
                                borderRadius: AppRadii.brMd,
                                border: Border.all(
                                  color: AppColors.glassBorderSoft,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.map_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 9.6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Haritadan Konum Seç',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 3.2),
                                        Text(
                                          '${_lat.toStringAsFixed(4)}, ${_lng.toStringAsFixed(4)}',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            color: AppColors.textMuted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColors.textTertiary,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 12.8,
                        ), // 20% reduction from AppSpacing.lg (16px)
                        _buildSection('TARİH & SAAT', [
                          Row(
                            children: [
                              Expanded(child: _buildDatePicker()),
                              const SizedBox(
                                width: 9.6,
                              ), // 20% reduction from AppSpacing.md (12px)
                              Expanded(child: _buildTimePicker()),
                            ],
                          ),
                        ]),
                        const SizedBox(
                          height: 12.8,
                        ), // 20% reduction from AppSpacing.lg (16px)
                        _buildSection('OYUNCU DETAYLARI', [
                          _buildDropdown(
                            label: 'Pozisyon',
                            value: _position,
                            items: _positions,
                            icon: Icons.sports_soccer,
                            onChanged: (value) =>
                                setState(() => _position = value!),
                          ),
                          const SizedBox(
                            height: 9.6,
                          ), // 20% reduction from AppSpacing.md (12px)
                          _buildDropdown(
                            label: 'Aranan Seviye',
                            value: _skillLevel,
                            items: _skillLevels,
                            icon: Icons.bar_chart,
                            onChanged: (value) =>
                                setState(() => _skillLevel = value!),
                          ),
                        ]),
                        const SizedBox(
                          height: 16.0,
                        ), // 20% reduction from AppSpacing.xl (20px)
                        GradientButton(
                          onPressed: _handleSubmit,
                          label: 'İlanı Yayınla',
                        ),
                        const SizedBox(
                          height: 12.8,
                        ), // 20% reduction from AppSpacing.lg (16px)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return SolidCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 8.8, // 20% reduction from 11px
              fontWeight: FontWeight.bold,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 9.6,
          ), // 20% reduction from AppSpacing.md (12px)
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9.6, // 20% reduction from 12px
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 3.2), // 20% reduction from AppSpacing.xs (4px)
        Container(
          decoration: BoxDecoration(
            color: AppColors.glassTintLight,
            borderRadius: AppRadii.brMd,
            border: Border.all(color: AppColors.glassBorderSoft),
          ),
          child: TextField(
            onChanged: onChanged,
            maxLines: maxLines,
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 11.2, // 20% reduction from 14px
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 11.2, // 20% reduction from 14px
              ),
              prefixIcon: Icon(
                icon,
                color: AppColors.textTertiary,
                size: 16,
              ), // 20% reduction from 20px
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(
                9.6,
              ), // 20% reduction from AppSpacing.md (12px)
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9.6, // 20% reduction from 12px
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 3.2), // 20% reduction from AppSpacing.xs (4px)
        Container(
          decoration: BoxDecoration(
            color: AppColors.glassTintLight,
            borderRadius: AppRadii.brMd,
            border: Border.all(color: AppColors.glassBorderSoft),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: value,
            items: items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textTertiary,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: AppColors.textTertiary,
                size: 16,
              ), // 20% reduction from 20px
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(
                9.6,
              ), // 20% reduction from AppSpacing.md (12px)
            ),
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 11.2, // 20% reduction from 14px
            ),
            dropdownColor: AppColors.backgroundDark,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primaryBright,
                  surface: AppColors.backgroundDark,
                ),
              ),
              child: child!,
            );
          },
        );
        if (date != null) {
          setState(() => _selectedDate = date);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(
          9.6,
        ), // 20% reduction from AppSpacing.md (12px)
        decoration: BoxDecoration(
          color: AppColors.glassTintLight,
          borderRadius: AppRadii.brMd,
          border: Border.all(color: AppColors.glassBorderSoft),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.textTertiary,
              size: 16, // 20% reduction from 20px
            ),
            const SizedBox(
              width: 6.4,
            ), // 20% reduction from AppSpacing.sm (8px)
            Text(
              _selectedDate != null
                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                  : 'Tarih Seç',
              style: GoogleFonts.inter(
                fontSize: 11.2, // 20% reduction from 14px
                color: _selectedDate != null
                    ? AppColors.textPrimary
                    : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.primaryBright,
                  surface: AppColors.backgroundDark,
                ),
              ),
              child: child!,
            );
          },
        );
        if (time != null) {
          setState(() => _selectedTime = time);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(
          9.6,
        ), // 20% reduction from AppSpacing.md (12px)
        decoration: BoxDecoration(
          color: AppColors.glassTintLight,
          borderRadius: AppRadii.brMd,
          border: Border.all(color: AppColors.glassBorderSoft),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.access_time_outlined,
              color: AppColors.textTertiary,
              size: 16, // 20% reduction from 20px
            ),
            const SizedBox(
              width: 6.4,
            ), // 20% reduction from AppSpacing.sm (8px)
            Text(
              _selectedTime != null
                  ? '${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                  : 'Saat Seç',
              style: GoogleFonts.inter(
                fontSize: 11.2, // 20% reduction from 14px
                color: _selectedTime != null
                    ? AppColors.textPrimary
                    : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Validation
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen tarih ve saat seçin')),
        );
        return;
      }

      if (_location.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen konum bilgisi girin')),
        );
        return;
      }

      // Combine date and time for start
      final availableStart = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      // End time is 3 hours after start (default)
      final availableEnd = availableStart.add(const Duration(hours: 3));

      // Map skill level to enum
      SkillLevel skillLevel;
      switch (_skillLevel) {
        case 'Başlangıç':
          skillLevel = SkillLevel.beginner;
          break;
        case 'Orta':
          skillLevel = SkillLevel.intermediate;
          break;
        case 'İyi':
        case 'Profesyonel':
          skillLevel = SkillLevel.advanced;
          break;
        default:
          skillLevel = SkillLevel.intermediate;
      }

      // Map position to enum
      PositionType positionType;
      switch (_position) {
        case 'Kaleci':
          positionType = PositionType.goalkeeper;
          break;
        case 'Defans':
          positionType = PositionType.defender;
          break;
        case 'Orta Saha':
          positionType = PositionType.midfielder;
          break;
        case 'Forvet':
          positionType = PositionType.forward;
          break;
        case 'Kanat':
          positionType =
              PositionType.forward; // Map to forward since winger doesn't exist
          break;
        default:
          positionType = PositionType.forward;
      }

      try {
        // Show loading
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('İlan oluşturuluyor...')),
          );
        }

        // Create player listing
        await ref.read(playerListingsRepositoryProvider).create({
          'notes': _description.isNotEmpty ? _description : null,
          'center_lat': _lat,
          'center_lng': _lng,
          'radius_km': 10, // Default 10km radius
          'available_start': availableStart.toIso8601String(),
          'available_end': availableEnd.toIso8601String(),
          'positions': [positionType.toString().split('.').last],
          'skill_level': skillLevel.toString().split('.').last,
          'preferred_formats': ['fiveVsFive'], // Default format
          'ask_price': 0, // Free by default
        });

        if (mounted) {
          // Invalidate explore listings to refresh
          ref.invalidate(playerListingsRepositoryProvider);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('İlan başarıyla oluşturuldu!'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hata: ${e.toString()}'),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }

  void _showLocationPicker() {
    showDialog(
      context: context,
      builder: (context) => LocationPicker(
        initialLocation: LatLng(_lat, _lng),
        onLocationSelected: (location) {
          setState(() {
            _lat = location.latitude;
            _lng = location.longitude;
          });
        },
      ),
    );
  }
}
