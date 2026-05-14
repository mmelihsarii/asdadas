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
import 'package:sahada_dev/data/repositories/match_listings_repository.dart';

class MatchListingCreateScreen extends ConsumerStatefulWidget {
  const MatchListingCreateScreen({super.key});

  @override
  ConsumerState<MatchListingCreateScreen> createState() =>
      _MatchListingCreateScreenState();
}

class _MatchListingCreateScreenState
    extends ConsumerState<MatchListingCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers - properly managed
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late final TextEditingController _durationController;
  late final TextEditingController _priceController;
  late final TextEditingController _playersNeededController;

  double _lat = 41.0082; // Default Istanbul
  double _lng = 28.9784; // Default Istanbul
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _skillLevel = 'Orta';
  String _fieldType = 'Halı Saha';
  List<PositionType> _selectedPositions = [];

  final List<String> _skillLevels = ['Başlangıç', 'Orta', 'İyi', 'Profesyonel'];
  final List<String> _fieldTypes = ['Halı Saha', 'Çim Saha', 'Parke'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
    _durationController = TextEditingController(text: '90');
    _priceController = TextEditingController();
    _playersNeededController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _playersNeededController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: const Text('Maç İlanı Oluştur'),
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
                            label: 'Maç Başlığı',
                            hint: 'Örn: 5v5 Halı Saha Maçı',
                            icon: Icons.sports_soccer,
                            controller: _titleController,
                          ),
                          const SizedBox(
                            height: 9.6,
                          ), // 20% reduction from AppSpacing.md (12px)
                          _buildTextField(
                            label: 'Açıklama',
                            hint: 'Maç hakkında detaylı bilgi...',
                            icon: Icons.description_outlined,
                            maxLines: 4,
                            controller: _descriptionController,
                          ),
                        ]),
                        const SizedBox(
                          height: 12.8,
                        ), // 20% reduction from AppSpacing.lg (16px)
                        _buildSection('KONUM', [
                          _buildTextField(
                            label: 'Saha Adı / Konum',
                            hint: 'Örn: Kadıköy Spor Kompleksi',
                            icon: Icons.location_on_outlined,
                            controller: _locationController,
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
                          const SizedBox(
                            height: 9.6,
                          ), // 20% reduction from AppSpacing.md (12px)
                          _buildTextField(
                            label: 'Süre (dakika)',
                            hint: '90',
                            icon: Icons.timer_outlined,
                            keyboardType: TextInputType.number,
                            controller: _durationController,
                          ),
                        ]),
                        const SizedBox(
                          height: 12.8,
                        ), // 20% reduction from AppSpacing.lg (16px)
                        _buildSection('MAÇ DETAYLARI', [
                          _buildDropdown(
                            label: 'Saha Tipi',
                            value: _fieldType,
                            items: _fieldTypes,
                            icon: Icons.grass_outlined,
                            onChanged: (value) =>
                                setState(() => _fieldType = value!),
                          ),
                          const SizedBox(
                            height: 9.6,
                          ), // 20% reduction from AppSpacing.md (12px)
                          _buildDropdown(
                            label: 'Seviye',
                            value: _skillLevel,
                            items: _skillLevels,
                            icon: Icons.bar_chart,
                            onChanged: (value) =>
                                setState(() => _skillLevel = value!),
                          ),
                          const SizedBox(
                            height: 9.6,
                          ), // 20% reduction from AppSpacing.md (12px)
                          _buildTextField(
                            label: 'Aranan Oyuncu Sayısı',
                            hint: '5',
                            icon: Icons.people_outline,
                            keyboardType: TextInputType.number,
                            controller: _playersNeededController,
                          ),
                          const SizedBox(height: 9.6),
                          _buildPositionSelector(),
                        ]),
                        const SizedBox(
                          height: 12.8,
                        ), // 20% reduction from AppSpacing.lg (16px)
                        _buildSection('ÜCRET', [
                          _buildTextField(
                            label: 'Toplam Ücret (₺)',
                            hint: '150',
                            icon: Icons.payments_outlined,
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                          ),
                        ]),
                        const SizedBox(
                          height: 16,
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

  Widget _buildPositionSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aranan Pozisyonlar (Opsiyonel)',
          style: GoogleFonts.inter(
            fontSize: 9.6,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6.4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PositionType.values.map((position) {
            final isSelected = _selectedPositions.contains(position);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedPositions.remove(position);
                  } else {
                    _selectedPositions.add(position);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.gradientPrimary : null,
                  color: isSelected ? null : AppColors.glassTintLight,
                  borderRadius: AppRadii.brMd,
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : AppColors.glassBorderSoft,
                  ),
                ),
                child: Text(
                  position.displayName,
                  style: GoogleFonts.inter(
                    fontSize: 11.2,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.black : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 4),
        Text(
          'Seçilen: ${_selectedPositions.isEmpty ? "Tümü" : _selectedPositions.map((p) => p.displayName).join(", ")}',
          style: GoogleFonts.inter(fontSize: 8.8, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType? keyboardType,
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
            controller: controller,
            keyboardType: keyboardType,
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

      final title = _titleController.text.trim();
      final location = _locationController.text.trim();
      final playersNeeded = _playersNeededController.text.trim();

      if (title.isEmpty || location.isEmpty || playersNeeded.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen tüm zorunlu alanları doldurun')),
        );
        return;
      }

      // Combine date and time
      final startsAt = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

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

      // Map field type to match format (simplified)
      MatchFormat format;
      final count = int.tryParse(playersNeeded) ?? 5;
      if (count <= 5) {
        format = MatchFormat.fiveVsFive;
      } else if (count <= 6) {
        format = MatchFormat.sixVsSix;
      } else {
        format = MatchFormat.sevenVsSeven;
      }

      try {
        // Show loading
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('İlan oluşturuluyor...')),
          );
        }

        final description = _descriptionController.text.trim();
        final price = _priceController.text.trim();

        // Create match listing
        await ref.read(matchListingsRepositoryProvider).create({
          'title': title,
          'description': description.isNotEmpty ? description : null,
          'pitch_name': location,
          'lat': _lat,
          'lng': _lng,
          'starts_at': startsAt.toIso8601String(),
          'format': format.toString().split('.').last,
          'needed_count': count,
          'needed_positions': _selectedPositions
              .map((p) => p.name.toUpperCase())
              .toList(),
          'skill_level': skillLevel.toString().split('.').last,
          'price_type': price.isNotEmpty ? 'fixed' : 'free',
          'base_price': int.tryParse(price) ?? 0,
          'negotiation_enabled': false,
          'payment_method': 'cash',
        });

        if (mounted) {
          // Invalidate explore listings to refresh
          ref.invalidate(matchListingsRepositoryProvider);

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
