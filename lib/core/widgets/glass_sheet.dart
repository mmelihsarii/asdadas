import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radii.dart';
import '../theme/app_spacing.dart';
import 'glass_container.dart';
import '../theme/glass_tokens.dart';

/// Glass Bottom Sheet wrapper
/// - showModalBottomSheet üzerine sarmalayıcı
/// - Üstte 4×40 grab handle (gradient)
/// - Arkaplan GlassContainer(intensity: strong), üst köşeler radius xxl
class GlassSheet extends StatelessWidget {
  const GlassSheet({
    super.key,
    required this.child,
    this.showHandle = true,
  });

  final Widget child;
  final bool showHandle;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      intensity: GlassIntensity.strong,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppRadii.xxl),
      ),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle) ...[
            const SizedBox(height: AppSpacing.md),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textMuted,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to show glass bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool showHandle = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.backgroundDeep.withValues(alpha: 0.8),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      builder: (context) => GlassSheet(
        showHandle: showHandle,
        child: child,
      ),
    );
  }
}
