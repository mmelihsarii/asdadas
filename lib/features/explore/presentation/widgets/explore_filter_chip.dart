import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sahada_dev/core/theme/app_colors.dart';
import 'package:sahada_dev/core/theme/app_radii.dart';

/// Filter chip widget for explore screen filters
class ExploreFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ExploreFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6.4),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.gradientPrimary : null,
          color: isSelected ? null : AppColors.glassTintLight,
          borderRadius: AppRadii.brMd,
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.glassBorderSoft,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.2,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.black : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
