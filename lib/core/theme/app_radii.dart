import 'package:flutter/material.dart';

/// Border radius token'ları. Ekranlarda hardcode radius YASAK.
class AppRadii {
  AppRadii._(); // Private constructor - static only

  // ═══════════════════════════════════════════════════
  // RADIUS VALUES
  // ═══════════════════════════════════════════════════
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double pill = 999;

  // ═══════════════════════════════════════════════════
  // BORDER RADIUS CONSTANTS (const kullanımı için)
  // ═══════════════════════════════════════════════════
  static const BorderRadius brXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius brSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius brMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius brLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius brXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius brXxl = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius brPill = BorderRadius.all(Radius.circular(pill));
}
