import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_radii.dart';
import '../theme/glass_tokens.dart';

/// Tek doğru cam yüzey widget'ı.
/// Ekranlarda BackdropFilter'ı doğrudan kullanma — bunu kullan.
///
/// PERFORMANS:
/// - Sabit, küçük yüzeyler için (kart, sheet, navbar). Liste itemlarında KULLANMA;
///   onun yerine GlassSurface (aşağıda) kullan — o blur yapmaz.
/// - Aynı viewport'ta toplam GlassContainer + GlassSheet adedi 3'ü geçmesin.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.intensity = GlassIntensity.regular,
    this.borderRadius = AppRadii.brLg,
    this.padding,
    this.tintOverride,
    this.borderColorOverride,
    this.showEdgeAccent = false,
  });

  final Widget child;
  final GlassIntensity intensity;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? tintOverride;
  final Color? borderColorOverride;
  final bool showEdgeAccent; // üstte ince gradient çizgi

  @override
  Widget build(BuildContext context) {
    final useBlur = GlassTokens.shouldUseRealBlur(context);
    final sigma = GlassTokens.blurSigma(intensity);
    final tint = tintOverride ?? GlassTokens.tint(intensity);
    final border = borderColorOverride ?? GlassTokens.border(intensity);

    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            if (useBlur)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                  child: const SizedBox.shrink(),
                ),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: tint,
                borderRadius: borderRadius,
                border: Border.all(color: border, width: 1),
              ),
              child: Padding(
                padding:
                    padding ??
                    const EdgeInsets.all(12.8), // 20% reduction from 16px
                child: child,
              ),
            ),
            if (showEdgeAccent)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 1.2,
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
