import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';
import 'package:sahada_dev/core/theme/app_spacing.dart';
import 'package:sahada_dev/core/widgets/glass_card.dart';
import 'package:sahada_dev/core/widgets/gradient_background.dart';
import 'package:sahada_dev/core/widgets/gradient_button.dart';
import 'package:sahada_dev/data/models/enums.dart';
import 'package:sahada_dev/features/profile/application/profile_setup_notifier.dart';
import 'package:sahada_dev/features/profile/application/profile_setup_state.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileSetupNotifierProvider);
    final notifier = ref.read(profileSetupNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profilini Oluştur',
          style: GoogleFonts.inter(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Upload
                _buildAvatarSection(state, notifier),
                const SizedBox(height: AppSpacing.xl),

                // Display Name
                _buildDisplayNameField(state, notifier),
                const SizedBox(height: AppSpacing.lg),

                // Birth Date
                _buildBirthDateField(context, state, notifier),
                const SizedBox(height: AppSpacing.lg),

                // Skill Level
                _buildSkillLevelSection(state, notifier),
                const SizedBox(height: AppSpacing.lg),

                // Positions
                _buildPositionsSection(state, notifier),
                const SizedBox(height: AppSpacing.lg),

                // Home Location
                _buildHomeLocationSection(state, notifier),
                const SizedBox(height: AppSpacing.lg),

                // KVKK Checkbox
                _buildKvkkCheckbox(state, notifier),
                const SizedBox(height: AppSpacing.lg),

                // Error Message
                if (state.error != null) ...[
                  _buildErrorMessage(state.error!),
                  const SizedBox(height: AppSpacing.lg),
                ],

                // Submit Button
                _buildSubmitButton(context, state, notifier),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: notifier.pickAvatar,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: Border.all(
                  color: AppColors.glassBorderMedium,
                  width: 2,
                ),
                image: state.avatarFile != null
                    ? DecorationImage(
                        image: FileImage(state.avatarFile!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: state.avatarFile == null
                  ? const Icon(
                      Icons.add_a_photo,
                      size: 40,
                      color: AppColors.textTertiary,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Profil Fotoğrafı Ekle',
            style: GoogleFonts.inter(
              fontSize: 11.2, // 14 * 0.8 = 11.2
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayNameField(
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(12.8), // AppSpacing.lg (16) * 0.8 = 12.8
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kullanıcı Adı *',
            style: GoogleFonts.inter(
              fontSize: 11.2, // 14 * 0.8 = 11.2
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6.4), // AppSpacing.sm (8) * 0.8 = 6.4
          TextField(
            onChanged: notifier.setDisplayName,
            style: GoogleFonts.inter(
              fontSize: 12.8, // 16 * 0.8 = 12.8
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Kullanıcı adını girin',
              hintStyle: GoogleFonts.inter(color: AppColors.textMuted),
              filled: false,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBirthDateField(
    BuildContext context,
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final displayText = state.birthDate != null
        ? dateFormat.format(state.birthDate!)
        : 'gg/aa/yyyy';

    return GlassCard(
      padding: const EdgeInsets.all(12.8), // AppSpacing.lg (16) * 0.8 = 12.8
      onTap: () => _showDatePicker(context, state, notifier),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Doğum Tarihi *',
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 14 * 0.8 = 11.2
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 3.2), // AppSpacing.xs (4) * 0.8 = 3.2
              Text(
                displayText,
                style: GoogleFonts.inter(
                  fontSize: 12.8, // 16 * 0.8 = 12.8
                  color: state.birthDate != null
                      ? AppColors.textPrimary
                      : AppColors.textMuted,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.calendar_today_outlined,
            size: 16, // 20 * 0.8 = 16
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillLevelSection(
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seviye *',
          style: GoogleFonts.inter(
            fontSize: 11.2, // 14 * 0.8 = 11.2
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 9.6), // AppSpacing.md (12) * 0.8 = 9.6
        Row(
          children: [
            Expanded(
              child: _buildSkillLevelChip(
                'Başlangıç',
                SkillLevel.beginner,
                state.skillLevel == SkillLevel.beginner,
                () => notifier.setSkillLevel(SkillLevel.beginner),
              ),
            ),
            const SizedBox(width: 6.4), // AppSpacing.sm (8) * 0.8 = 6.4
            Expanded(
              child: _buildSkillLevelChip(
                'Orta',
                SkillLevel.intermediate,
                state.skillLevel == SkillLevel.intermediate,
                () => notifier.setSkillLevel(SkillLevel.intermediate),
              ),
            ),
            const SizedBox(width: 6.4), // AppSpacing.sm (8) * 0.8 = 6.4
            Expanded(
              child: _buildSkillLevelChip(
                'İleri',
                SkillLevel.advanced,
                state.skillLevel == SkillLevel.advanced,
                () => notifier.setSkillLevel(SkillLevel.advanced),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillLevelChip(
    String label,
    SkillLevel level,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 9.6,
        ), // AppSpacing.md (12) * 0.8 = 9.6
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.glassTintLight,
          borderRadius: AppRadii.brMd,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.glassBorderSoft,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 11.2, // 14 * 0.8 = 11.2
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildPositionsSection(
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    final positions = [
      ('Kaleci', PositionType.goalkeeper),
      ('Defans', PositionType.defender),
      ('Orta Saha', PositionType.midfielder),
      ('Forvet', PositionType.forward),
      ('Hepsi', PositionType.any),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mevkiler * (Birden fazla seçebilirsiniz)',
          style: GoogleFonts.inter(
            fontSize: 11.2, // 14 * 0.8 = 11.2
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 9.6), // AppSpacing.md (12) * 0.8 = 9.6
        Wrap(
          spacing: 6.4, // AppSpacing.sm (8) * 0.8 = 6.4
          runSpacing: 6.4, // AppSpacing.sm (8) * 0.8 = 6.4
          children: positions.map((pos) {
            final isSelected = state.selectedPositions.contains(pos.$2);
            return GestureDetector(
              onTap: () => notifier.togglePosition(pos.$2),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.8, // AppSpacing.lg (16) * 0.8 = 12.8
                  vertical: 6.4, // AppSpacing.sm (8) * 0.8 = 6.4
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.glassTintLight,
                  borderRadius: AppRadii.brPill,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.glassBorderSoft,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  pos.$1,
                  style: GoogleFonts.inter(
                    fontSize: 11.2, // 14 * 0.8 = 11.2
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHomeLocationSection(
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    // Default to Istanbul center
    final center = LatLng(state.homeLat ?? 41.0082, state.homeLng ?? 28.9784);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ev Konumu * (Haritada işaretleyin)',
          style: GoogleFonts.inter(
            fontSize: 11.2, // 14 * 0.8 = 11.2
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 9.6), // AppSpacing.md (12) * 0.8 = 9.6
        GlassCard(
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 250,
            child: ClipRRect(
              borderRadius: AppRadii.brMd,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 13,
                  onTap: (tapPosition, point) {
                    notifier.setHomeLocation(point.latitude, point.longitude);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.sahada.app',
                  ),
                  if (state.homeLat != null && state.homeLng != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(state.homeLat!, state.homeLng!),
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
        ),
        if (state.homeLat != null && state.homeLng != null)
          Padding(
            padding: const EdgeInsets.only(
              top: 6.4,
            ), // AppSpacing.sm (8) * 0.8 = 6.4
            child: Text(
              'Seçilen konum: ${state.homeLat!.toStringAsFixed(4)}, ${state.homeLng!.toStringAsFixed(4)}',
              style: GoogleFonts.inter(
                fontSize: 9.6, // 12 * 0.8 = 9.6
                color: AppColors.textTertiary,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildKvkkCheckbox(
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    return GlassCard(
      padding: const EdgeInsets.all(12.8), // AppSpacing.lg (16) * 0.8 = 12.8
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: state.kvkkAccepted,
            onChanged: (value) => notifier.setKvkkAccepted(value ?? false),
            activeColor: AppColors.primary,
            checkColor: Colors.white,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => notifier.setKvkkAccepted(!state.kvkkAccepted),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 9.6,
                ), // AppSpacing.md (12) * 0.8 = 9.6
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 11.2, // 14 * 0.8 = 11.2
                      color: AppColors.textSecondary,
                    ),
                    children: const [
                      TextSpan(text: 'KVKK metnini okudum ve kabul ediyorum '),
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(
    BuildContext context,
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) async {
    final now = DateTime.now();
    final initialDate =
        state.birthDate ?? DateTime(now.year - 25, now.month, now.day);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFa3e635),
              onPrimary: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      notifier.setBirthDate(picked);
    }
  }

  Widget _buildErrorMessage(String error) {
    return Container(
      padding: const EdgeInsets.all(9.6), // 12 * 0.8 = 9.6
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(9.6), // 12 * 0.8 = 9.6
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red.shade600,
            size: 16,
          ), // 20 * 0.8 = 16
          const SizedBox(width: 6.4), // 8 * 0.8 = 6.4
          Expanded(
            child: Text(
              error,
              style: GoogleFonts.inter(
                fontSize: 11.2, // 14 * 0.8 = 11.2
                color: Colors.red.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    ProfileSetupState state,
    ProfileSetupNotifier notifier,
  ) {
    return GradientButton(
      onPressed: state.isLoading
          ? null
          : () async {
              final success = await notifier.submit();
              if (success && context.mounted) {
                context.go('/explore');
              }
            },
      label: 'Devam Et',
      isLoading: state.isLoading,
    );
  }
}
