import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Shadow ve glow token'ları. Ekranlarda inline BoxShadow YASAK.
class AppShadows {
  AppShadows._(); // Private constructor - static only

  // ═══════════════════════════════════════════════════
  // GLASS SHADOWS (Cam yüzeyler için)
  // ═══════════════════════════════════════════════════
  static const List<BoxShadow> glassSoft = [
    BoxShadow(
      color: Color(0x40000000), // rgba(0, 0, 0, 0.25)
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> glassElevated = [
    BoxShadow(
      color: Color(0x66000000), // rgba(0, 0, 0, 0.4)
      blurRadius: 40,
      offset: Offset(0, 16),
    ),
    BoxShadow(
      color: Color(0x14FFFFFF), // top hairline highlight
      blurRadius: 1,
      offset: Offset(0, 1),
    ),
  ];

  // ═══════════════════════════════════════════════════
  // GLOW EFFECTS (Buton, rozet için)
  // ═══════════════════════════════════════════════════
  static const List<BoxShadow> glowPrimary = [
    BoxShadow(
      color: AppColors.glowPrimary,
      blurRadius: 19.2,
      spreadRadius: -2.4,
    ), // 32 * 0.6 = 19.2, -4 * 0.6 = -2.4 (%40 azaltıldı)
  ];

  static const List<BoxShadow> glowLime = [
    BoxShadow(
      color: AppColors.glowLime,
      blurRadius: 9.45, // 15.75 * 0.6 = 9.45 (%40 azaltıldı)
      spreadRadius: -2.025, // -3.375 * 0.6 = -2.025 (%40 azaltıldı)
    ),
  ];

  static const List<BoxShadow> glowCyan = [
    BoxShadow(
      color: AppColors.glowCyan,
      blurRadius: 14.4,
      spreadRadius: -2.4,
    ), // 24 * 0.6 = 14.4, -4 * 0.6 = -2.4 (%40 azaltıldı)
  ];
}
