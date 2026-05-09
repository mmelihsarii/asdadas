import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';
import 'gradient_button.dart';

/// Error state widget
/// - Merkezi GlassContainer + hata ikonu + başlık + açıklama + retry butonu
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.title = 'Bir Hata Oluştu',
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          16,
        ), // 20% reduction from AppSpacing.xl (20px)
        child: GlassContainer(
          padding: const EdgeInsets.all(
            25.6,
          ), // 20% reduction from AppSpacing.xxxl (32px)
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 51.2, // 20% reduction from 64px
                color: AppColors.danger,
              ),
              const SizedBox(
                height: 16,
              ), // 20% reduction from AppSpacing.xl (20px)
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16, // 20% reduction from 20px
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 9.6,
              ), // 20% reduction from AppSpacing.md (12px)
              Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 20% reduction from 14px
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(
                  height: 16,
                ), // 20% reduction from AppSpacing.xl (20px)
                GradientButton(
                  onPressed: onRetry,
                  label: 'Tekrar Dene',
                  icon: Icons.refresh,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
