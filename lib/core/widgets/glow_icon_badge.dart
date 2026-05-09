import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_radii.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

/// Glow Icon Badge
/// - Yuvarlak rozet, gradient fill, glowPrimary shadow
/// - Skill seviye, fiyat, status etiketleri için
class GlowIconBadge extends StatelessWidget {
  const GlowIconBadge({
    super.key,
    required this.label,
    this.icon,
    this.gradient = AppGradients.primaryCta,
    this.textColor = Colors.black,
  });

  final String label;
  final IconData? icon;
  final Gradient gradient;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: icon != null ? AppSpacing.md : AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: AppRadii.brPill,
        boxShadow: AppShadows.glowPrimary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: textColor,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Status badge variants
class StatusBadge extends StatelessWidget {
  const StatusBadge.success({
    super.key,
    required this.label,
    this.icon,
  })  : color = AppColors.success,
        textColor = Colors.white;

  const StatusBadge.warning({
    super.key,
    required this.label,
    this.icon,
  })  : color = AppColors.warning,
        textColor = Colors.black;

  const StatusBadge.danger({
    super.key,
    required this.label,
    this.icon,
  })  : color = AppColors.danger,
        textColor = Colors.white;

  const StatusBadge.info({
    super.key,
    required this.label,
    this.icon,
  })  : color = AppColors.info,
        textColor = Colors.white;

  final String label;
  final IconData? icon;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: icon != null ? AppSpacing.md : AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadii.brPill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: textColor,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
