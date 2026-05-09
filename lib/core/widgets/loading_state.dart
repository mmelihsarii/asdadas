import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

/// Loading state widget
/// - Merkezi GlassContainer + spinner + opsiyonel mesaj
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassContainer(
        padding: const EdgeInsets.all(
          25.6,
        ), // 20% reduction from AppSpacing.xxxl (32px)
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            if (message != null) ...[
              const SizedBox(
                height: 16,
              ), // 20% reduction from AppSpacing.xl (20px)
              Text(
                message!,
                style: GoogleFonts.inter(
                  fontSize: 11.2, // 20% reduction from 14px
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
