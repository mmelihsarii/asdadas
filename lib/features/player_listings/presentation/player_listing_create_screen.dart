import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/widgets/glass_app_bar.dart';
import 'package:sahada_dev/core/widgets/solid_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';

class PlayerListingCreateScreen extends StatefulWidget {
  const PlayerListingCreateScreen({super.key});

  @override
  State<PlayerListingCreateScreen> createState() =>
      _PlayerListingCreateScreenState();
}

class _PlayerListingCreateScreenState extends State<PlayerListingCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _location = '';
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
                            label: 'İlan Başlığı',
                            hint: 'Örn: Forvet Arıyoruz',
                            icon: Icons.person_search,
                            onChanged: (value) => _title = value,
                          ),
                          const SizedBox(
                            height: 9.6,
                          ), // 20% reduction from AppSpacing.md (12px)
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

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement create player listing
      Navigator.pop(context);
    }
  }
}
