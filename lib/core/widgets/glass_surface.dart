import 'package:flutter/material.dart';
import '../theme/app_radii.dart';
import '../theme/app_shadows.dart';
import '../theme/glass_tokens.dart';

/// Cheap Glass (Liste itemları için)
/// Blur YOK. Yarı saydam renk + ince border + opsiyonel üst highlight + BoxShadow
/// ile "frosted illüzyonu". Liste, chip, küçük rozet için kullanılacak.
///
/// PERFORMANS:
/// - BackdropFilter kullanmaz, GPU'da çok ucuz
/// - Liste itemlarında güvenle kullanılabilir
class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.borderRadius = AppRadii.brMd,
    this.padding,
    this.showEdgeAccent = false,
    this.showShadow = true,
    this.intensity = GlassIntensity.regular,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool showEdgeAccent;
  final bool showShadow;
  final GlassIntensity intensity;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: GlassTokens.tint(intensity),
          borderRadius: borderRadius,
          border: Border.all(color: GlassTokens.border(intensity), width: 1),
          boxShadow: showShadow ? AppShadows.glassSoft : null,
        ),
        child: Stack(
          children: [
            Padding(
              padding:
                  padding ??
                  const EdgeInsets.all(9.6), // 20% reduction from 12px
              child: child,
            ),
            if (showEdgeAccent)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0x00FFFFFF),
                        Color(0x33A3E635),
                        Color(0x00FFFFFF),
                      ],
                      stops: [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
