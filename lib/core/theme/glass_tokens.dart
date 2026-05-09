import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Glass yoğunluk seviyeleri
enum GlassIntensity { subtle, regular, strong }

/// Glass efekti için tüm token'lar.
/// BackdropFilter parametrelerini buradan al.
class GlassTokens {
  GlassTokens._(); // Private constructor - static only

  // ═══════════════════════════════════════════════════
  // BLUR SIGMA (Yoğunluğa göre)
  // ═══════════════════════════════════════════════════
  static double blurSigma(GlassIntensity intensity) {
    return switch (intensity) {
      GlassIntensity.subtle => 2.55, // 3.0 * 0.85 = 2.55 (%15 daha azaltıldı)
      GlassIntensity.regular => 4.25, // 5.0 * 0.85 = 4.25 (%15 daha azaltıldı)
      GlassIntensity.strong => 6.8, // 8.0 * 0.85 = 6.8 (%15 daha azaltıldı)
    };
  }

  // ═══════════════════════════════════════════════════
  // TINT COLOR (Yoğunluğa göre)
  // ═══════════════════════════════════════════════════
  static Color tint(GlassIntensity intensity) {
    return switch (intensity) {
      GlassIntensity.subtle => AppColors.glassTintLight,
      GlassIntensity.regular => AppColors.glassTintMedium,
      GlassIntensity.strong => AppColors.glassTintStrong,
    };
  }

  // ═══════════════════════════════════════════════════
  // BORDER COLOR (Yoğunluğa göre)
  // ═══════════════════════════════════════════════════
  static Color border(GlassIntensity intensity) {
    return switch (intensity) {
      GlassIntensity.subtle => AppColors.glassBorderSoft,
      GlassIntensity.regular => AppColors.glassBorderMedium,
      GlassIntensity.strong => AppColors.glassBorderMedium,
    };
  }

  // ═══════════════════════════════════════════════════
  // PERFORMANCE CHECK
  // Düşük güçlü cihazda blur'u kapatma eşiği
  // ═══════════════════════════════════════════════════
  static bool shouldUseRealBlur(BuildContext context) {
    final mq = MediaQuery.of(context);
    // disableAnimations true ise blur'u da kapat (erişilebilirlik)
    return !mq.disableAnimations;
  }
}
