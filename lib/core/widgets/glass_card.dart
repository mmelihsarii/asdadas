import 'package:flutter/material.dart';
import '../theme/app_radii.dart';
import '../theme/glass_tokens.dart';
import 'glass_surface.dart';

/// Glass Card — Liste Item Arkaplanı
/// - GlassSurface (blur YOK) + showEdgeAccent: true
/// - Tap için InkWell ile BorderRadius clip
/// - Supports intensity parameter for three-tier hierarchy
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.showEdgeAccent = true,
    this.borderRadius = AppRadii.brMd,
    this.intensity = GlassIntensity.regular,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool showEdgeAccent;
  final BorderRadius borderRadius;
  final GlassIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final content = GlassSurface(
      borderRadius: borderRadius,
      padding: padding ?? const EdgeInsets.all(12.8), // 20% reduction from 16px
      showEdgeAccent: showEdgeAccent,
      intensity: intensity,
      child: child,
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, borderRadius: borderRadius, child: content);
    }

    return content;
  }
}
