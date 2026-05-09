import 'package:flutter/material.dart';

/// Tüm renk token'ları. Ekranlarda Color(0xFF...) literal'i YASAK.
/// Sadece bu dosyada ve app_gradients.dart'ta literal renk tanımlanabilir.
class AppColors {
  AppColors._(); // Private constructor - static only

  // ═══════════════════════════════════════════════════
  // BASE BACKGROUNDS
  // ═══════════════════════════════════════════════════
  static const Color backgroundDeep = Color(0xFF020408);
  static const Color backgroundBase = Color(0xFF050912);
  static const Color backgroundElevated = Color(0xFF0A1018);
  static const Color surface = Color(0xFF0F1419);
  static const Color surfaceElevated = Color(0xFF161D27);

  // ═══════════════════════════════════════════════════
  // BRAND COLORS
  // ═══════════════════════════════════════════════════
  static const Color primary = Color(0xFF22C55E);
  static const Color primaryBright = Color(0xFFA3E635);
  static const Color primaryDeep = Color(0xFF15803D);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentTeal = Color(0xFF14B8A6);

  // ═══════════════════════════════════════════════════
  // TEXT HIERARCHY
  // ═══════════════════════════════════════════════════
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB7BDC7);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF4B5563);

  // ═══════════════════════════════════════════════════
  // STATUS COLORS
  // ═══════════════════════════════════════════════════
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ═══════════════════════════════════════════════════
  // GLASS TINTS (BackdropFilter ÜZERİNDE kullanılır)
  // ═══════════════════════════════════════════════════
  static const Color glassTintLight = Color(
    0x06FFFFFF,
  ); // alpha 2.1% (3% * 0.7, %30 daha azaltıldı)
  static const Color glassTintMedium = Color(
    0x08FFFFFF,
  ); // alpha 3.3% (4.7% * 0.7, %30 daha azaltıldı)
  static const Color glassTintStrong = Color(
    0x0BFFFFFF,
  ); // alpha 4.4% (6.3% * 0.7, %30 daha azaltıldı)
  static const Color glassTintPrimary = Color(
    0x0A22C55E,
  ); // primary 4.1% (5.9% * 0.7, %30 daha azaltıldı)

  // ═══════════════════════════════════════════════════
  // GLASS BORDERS
  // ═══════════════════════════════════════════════════
  static const Color glassBorderSoft = Color(
    0x08FFFFFF,
  ); // alpha 3.3% (4.7% * 0.7, %30 daha azaltıldı)
  static const Color glassBorderMedium = Color(
    0x0EFFFFFF,
  ); // alpha 5.5% (7.8% * 0.7, %30 daha azaltıldı)
  static const Color glassBorderPrimary = Color(
    0x1DA3E635,
  ); // alpha 11.2% (16% * 0.7, %30 daha azaltıldı)

  // ═══════════════════════════════════════════════════
  // SHADOWS / GLOWS
  // ═══════════════════════════════════════════════════
  static const Color glowPrimary = Color(
    0x2E22C55E,
  ); // alpha 18% (30% * 0.6, %40 azaltıldı)
  static const Color glowLime = Color(
    0x23A3E635,
  ); // alpha 13.5% (22.5% * 0.6, %40 azaltıldı)
  static const Color glowCyan = Color(
    0x2306B6D4,
  ); // alpha 13.5% (22.5% * 0.6, %40 azaltıldı)

  // ═══════════════════════════════════════════════════
  // GRADIENTS (for convenience)
  // ═══════════════════════════════════════════════════
  static const LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBright, primary],
  );

  static const LinearGradient gradientAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentCyan, accentTeal],
  );

  // ═══════════════════════════════════════════════════
  // ALIASES (for backward compatibility)
  // ═══════════════════════════════════════════════════
  static const Color backgroundDark = backgroundBase;
}
