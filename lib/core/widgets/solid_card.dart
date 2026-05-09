import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radii.dart';

/// Solid Card — Lightweight card for list items
/// - Solid background (AppColors.surface)
/// - Subtle border (AppColors.glassBorderSoft)
/// - Reduced default padding (12.8px = 20% reduction from 16px)
/// - Optional onTap for interactivity
/// - No BackdropFilter (performance-optimized)
///
/// USAGE:
/// - List items (messages, matches, offers)
/// - Secondary content cards
/// - Form sections
///
/// PERFORMANCE:
/// - No BackdropFilter, very lightweight
/// - Safe to use in scrollable lists
class SolidCard extends StatelessWidget {
  const SolidCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.borderRadius = AppRadii.brMd,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: borderRadius,
        border: Border.all(color: AppColors.glassBorderSoft, width: 1),
      ),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.all(12.8), // 20% reduction from 16px
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, borderRadius: borderRadius, child: content);
    }

    return content;
  }
}
