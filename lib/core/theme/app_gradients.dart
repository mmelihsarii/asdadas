import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Tüm gradient tanımları. Ekranlarda inline gradient YASAK.
/// Hepsi const, performans için optimize edilmiş.
class AppGradients {
  AppGradients._(); // Private constructor - static only

  // ═══════════════════════════════════════════════════
  // PRIMARY CTA GRADIENT (Butonlar için)
  // ═══════════════════════════════════════════════════
  static const LinearGradient primaryCta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryBright, AppColors.primary],
  );

  // ═══════════════════════════════════════════════════
  // BRAND TEXT GRADIENT (Hero başlıklar için)
  // ═══════════════════════════════════════════════════
  static const LinearGradient brandText = LinearGradient(
    colors: [AppColors.primaryBright, AppColors.primary, AppColors.accentTeal],
    stops: [0.0, 0.55, 1.0],
  );

  // ═══════════════════════════════════════════════════
  // AVATAR RING (Profil fotoğrafı çerçevesi)
  // ═══════════════════════════════════════════════════
  static const SweepGradient avatarRing = SweepGradient(
    colors: [
      AppColors.primaryBright,
      AppColors.primary,
      AppColors.accentCyan,
      AppColors.primaryBright,
    ],
  );

  // ═══════════════════════════════════════════════════
  // GLASS EDGE ACCENT (Kart üst kenarı ince vurgu)
  // ═══════════════════════════════════════════════════
  static const LinearGradient glassEdgeAccent = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0x00FFFFFF), Color(0x33A3E635), Color(0x00FFFFFF)],
    stops: [0.0, 0.5, 1.0],
  );

  // ═══════════════════════════════════════════════════
  // SCENE BACKDROP (Sayfa arkaplan katmanı 0)
  // ═══════════════════════════════════════════════════
  static const LinearGradient sceneBackdrop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF020408),
      Color(0xFF050912),
      Color(0xFF070D18),
      Color(0xFF03060A),
    ],
    stops: [0.0, 0.4, 0.7, 1.0],
  );

  // ═══════════════════════════════════════════════════
  // AMBIENT BLOB COLORS (RadialGradient için renk listeleri)
  // Widget'ta pozisyon ve boyut belirlenir
  // ═══════════════════════════════════════════════════
  static const List<Color> ambientBlobGreen = [
    Color(0x1F22C55E), // rgba(34, 197, 94, 0.12) - %60 azaltıldı
    Color(0x0A10B981), // rgba(16, 185, 129, 0.04) - %60 azaltıldı
    Color(0x00000000), // transparent
  ];

  static const List<Color> ambientBlobCyan = [
    Color(0x1606B6D4), // rgba(6, 182, 212, 0.09) - %60 azaltıldı
    Color(0x0822D3EE), // rgba(34, 211, 238, 0.03) - %60 azaltıldı
    Color(0x00000000), // transparent
  ];

  static const List<Color> ambientBlobLime = [
    Color(0x14A3E635), // rgba(163, 230, 53, 0.08) - %60 azaltıldı
    Color(0x0784CC16), // rgba(132, 204, 22, 0.03) - %60 azaltıldı
    Color(0x00000000), // transparent
  ];

  // ═══════════════════════════════════════════════════
  // VIGNETTE (Ekran kenarlarını karartma)
  // ═══════════════════════════════════════════════════
  static const RadialGradient vignette = RadialGradient(
    radius: 1.2,
    colors: [
      Color(0x00000000), // transparent center
      Color(0x80080D18), // rgba(8, 13, 24, 0.50)
    ],
    stops: [0.45, 1.0],
  );
}
