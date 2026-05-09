# SAHADA Flutter — Glassmorphism & Gradient Upgrade Görevi

Bu dosya **tek seferlik, tasarım odaklı bir upgrade görevidir.** Mevcut iskelet duruyor; mantıkta değişiklik YAPMAYACAKSIN. Sadece görsel katmanı premium seviyeye çekeceksin: zengin glassmorphism, çok katmanlı gradyanlar, doğru performans bütçesi, sıfır teknik borç.

> **İlk çıktıdan önce dur:** Faz 0'ı tamamla, raporla, onay bekle. Sonra sırayla devam.

---

## 0. Bağlam ve Yollar

- Proje kökü: `/Users/alperensari/Desktop/sahada/sahada_dev/`
- Mevcut tema: `lib/core/theme/app_theme.dart` (tek `primaryGradient`, hiç glass token yok)
- Boş hazır klasör: `lib/core/widgets/` (henüz dosya yok — ortak widget'lar buraya gelecek)
- Üzerinde çalışılacak ekranlar (zaten yazıldı):
  ```
  lib/features/auth/presentation/login_screen.dart
  lib/features/profile/presentation/profile_screen.dart
  lib/features/profile/presentation/profile_setup_screen.dart
  lib/features/profile/presentation/user_profile_screen.dart
  lib/features/explore/presentation/explore_screen.dart
  lib/features/match_listings/presentation/match_listing_create_screen.dart
  lib/features/match_listings/presentation/match_listing_detail_screen.dart
  lib/features/player_listings/presentation/player_listing_create_screen.dart
  lib/features/offers/presentation/offers_screen.dart
  lib/features/my_matches/presentation/my_matches_screen.dart
  lib/features/messages/presentation/messages_list_screen.dart
  lib/features/messages/presentation/chat_screen.dart
  lib/core/router/app_shell.dart  (bottom nav)
  ```
- Referans web (sadece **görsel ilham** için, gradient stop'larını oradan al):
  - `/Users/alperensari/Desktop/referans/apps/web/src/app/globals.css`
  - `/Users/alperensari/Desktop/referans/apps/web/src/app/page.tsx` (hero gradient katmanları)
  - `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/explore/page.tsx`
  - `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/profile/page.tsx`

---

## 1. Mutlak Kurallar (Tartışmasız)

### 1.1 Sıfır Teknik Borç
- **Hiçbir ekranda inline `BoxDecoration` ile glass/gradient kurma.** Her şey `lib/core/theme/` veya `lib/core/widgets/` içindeki canonical token/widget'tan gelecek.
- **Hiçbir ekranda hardcode renk yok.** `Color(0xFF...)` literal'i sadece `app_theme.dart` ve `app_gradients.dart`'ta olabilir. Ekranlarda `AppColors.x` veya `Theme.of(context).colorScheme.x`.
- **Hiçbir ekranda hardcode radius/spacing yok.** `AppRadii` ve `AppSpacing` token'larını kullan.
- **Magic number yok.** Blur sigma, opacity, stop pozisyonları → token.
- **Migrasyon stratejisi:** Önce token + widget kütüphanesi (Faz 1-2). Sonra ekran ekran refactor (Faz 3). Yarım bırakılmış ekran kalmayacak; her ekran ya tamamen migrasyon edildi ya hiç dokunulmadı (tutarsız hibrit yok).
- **Eski stiller silinecek.** `AppTheme.primaryGradient` taşındıysa eski tanımı kaldır. Geriye dönük uyum için takma ad bırakma.
- **Yorum patlatma yok.** Token'ların adı kendini açıklasın.

### 1.2 Performans Bütçesi (Pazarlık Yok)
- **Hedef: 60 fps her zaman, low-end Android dahil.** DevTools timeline'da scroll sırasında jank frame YOK.
- **`BackdropFilter` bütçesi: aynı viewport'ta en fazla 3 adet.** Bottom nav (1) + open BottomSheet (1) + opsiyonel kart (1). Liste itemlarında `BackdropFilter` YASAK.
- **`Opacity` widget'ı yasak.** Onun yerine `Color.withValues(alpha:)` veya `withOpacity` (renk üzerinde). Sebep: `Opacity` widget'ı `saveLayer` çağırır, GPU'da pahalı.
- **`ClipRRect` + `BackdropFilter` her zaman birlikte.** Yoksa blur ekran dışına taşar, ekstra raster maliyeti.
- **Her tekrarlanan glass widget `RepaintBoundary` ile sarılı olacak.** ListView item'ları için zorunlu.
- **`ShaderMask` ve `BackdropFilter` aynı widget ağacında nesting yapma.** Ya biri ya öteki.
- **Animasyon kuralı:** Ambient hareket sadece `AnimatedBuilder` + `Transform`/`Opacity` (color tween) ile. `setState` ile rebuild storm yok. 60s+ döngü, 1 animasyon controller global.
- **Blur sigma cap:** Maks 24. Genellikle 12-18.
- **Liste itemleri ASLA blur yapmaz.** Onlar yarı saydam renk + 1px border ile "frosted illüzyonu" yapar (cheap glass). Gerçek blur sadece sheet/dialog/nav bar gibi sabit yüzeylerde.
- **Image asset olarak noise overlay** (256x256 tileable PNG, < 4 KB). `flutter_dotenv` örneğinde olduğu gibi `pubspec.yaml`'a `assets/textures/noise.png` ekle. Yoksa CustomPaint ile statik üret ve `decoder` ile cache.
- **`const` her yerde.** Token'lar, widget constructor'ları, gradient'ler `const`.

### 1.3 Erişilebilirlik
- Glass yüzeyler altındaki metin için kontrast oranı ≥ 4.5:1. Açık rengi karanlık üzerine yerleştirirken alpha ≥ 0.85.
- `MediaQuery.of(context).disableAnimations` true ise ambient animasyonu pasifleştir.

---

## 2. FAZ 0 — Mevcut Durumu Oku ve Plan Çıkar

Şunları yap, hiçbir kod yazma:
1. `lib/core/theme/app_theme.dart`'ı oku.
2. Yukarıdaki 13 ekran dosyasını oku, mevcut `BoxDecoration`/`Container`/`gradient` kullanımlarını listele.
3. Şu raporu üret (markdown, kısa):
   - Token olarak çıkarılması gereken **renkler, gradyanlar, radius'lar, spacing'ler, shadow'lar** listesi.
   - Hangi ekranlarda hangi yüzeylerin "glass" olması gerektiği (örn: explore'daki filtre çubuğu, offer kartları, vs).
   - Hangi yüzeylerin "gradient" olması gerektiği (CTA butonları, avatar ringleri, başlık metni, vs).
   - **Performans riskleri:** Şu anda ekranda kaç `BackdropFilter` var, kaç `Opacity` widget var.
4. Onay iste. **Onay almadan Faz 1'e geçme.**

---

## 3. FAZ 1 — Design Token Kütüphanesi

### 3.1 `lib/core/theme/app_colors.dart` (YENİ)
Mevcut `AppTheme`'deki sabit renkleri buraya taşı + ek nüanslar ekle:
```dart
class AppColors {
  // Base
  static const Color backgroundDeep = Color(0xFF020408);
  static const Color backgroundBase = Color(0xFF050912);
  static const Color backgroundElevated = Color(0xFF0A1018);
  static const Color surface = Color(0xFF0F1419);
  static const Color surfaceElevated = Color(0xFF161D27);

  // Brand
  static const Color primary = Color(0xFF22C55E);
  static const Color primaryBright = Color(0xFFA3E635);
  static const Color primaryDeep = Color(0xFF15803D);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentTeal = Color(0xFF14B8A6);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB7BDC7);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF4B5563);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Glass tints (BackdropFilter ÜZERİNDE kullanılır)
  static const Color glassTintLight = Color(0x14FFFFFF);   // alpha 8%
  static const Color glassTintMedium = Color(0x1FFFFFFF);  // alpha 12%
  static const Color glassTintStrong = Color(0x29FFFFFF);  // alpha 16%
  static const Color glassTintPrimary = Color(0x2622C55E); // primary 15%

  // Glass borders
  static const Color glassBorderSoft = Color(0x1FFFFFFF);
  static const Color glassBorderMedium = Color(0x33FFFFFF);
  static const Color glassBorderPrimary = Color(0x66A3E635);

  // Shadows / Glows
  static const Color glowPrimary = Color(0x6622C55E);
  static const Color glowLime = Color(0x66A3E635);
  static const Color glowCyan = Color(0x4D06B6D4);
}
```

### 3.2 `lib/core/theme/app_gradients.dart` (YENİ)
```dart
class AppGradients {
  // Primary CTA: lime → green
  static const LinearGradient primaryCta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryBright, AppColors.primary],
  );

  // Hero başlık metni için
  static const LinearGradient brandText = LinearGradient(
    colors: [AppColors.primaryBright, AppColors.primary, AppColors.accentTeal],
    stops: [0.0, 0.55, 1.0],
  );

  // Avatar / önemli ring
  static const SweepGradient avatarRing = SweepGradient(
    colors: [
      AppColors.primaryBright,
      AppColors.primary,
      AppColors.accentCyan,
      AppColors.primaryBright,
    ],
  );

  // Glass yüzey üzerine ince accent (kart üst kenarı)
  static const LinearGradient glassEdgeAccent = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0x00FFFFFF), Color(0x33A3E635), Color(0x00FFFFFF)],
    stops: [0.0, 0.5, 1.0],
  );

  // Sahne arkaplanı: derin uzay (sayfa background katmanı 0)
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

  // Mesh blob'ları (RadialGradient × 3-4 stack)
  // Bu listeyi widget'ta tüketeceğiz — pozisyonu ve boyutu orada belirlenir.
  static const List<Color> ambientBlobGreen = [
    Color(0x4722C55E), Color(0x1710B981), Color(0x00000000),
  ];
  static const List<Color> ambientBlobCyan = [
    Color(0x3806B6D4), Color(0x1322D3EE), Color(0x00000000),
  ];
  static const List<Color> ambientBlobLime = [
    Color(0x33A3E635), Color(0x1284CC16), Color(0x00000000),
  ];

  // Vignette
  static const RadialGradient vignette = RadialGradient(
    radius: 1.2,
    colors: [Color(0x00000000), Color(0x80080D18)],
    stops: [0.45, 1.0],
  );
}
```

### 3.3 `lib/core/theme/app_radii.dart` (YENİ)
```dart
class AppRadii {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double pill = 999;

  static const BorderRadius brXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius brSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius brMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius brLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius brXl = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius brXxl = BorderRadius.all(Radius.circular(xxl));
}
```

### 3.4 `lib/core/theme/app_spacing.dart` (YENİ)
```dart
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;
}
```

### 3.5 `lib/core/theme/app_shadows.dart` (YENİ)
```dart
class AppShadows {
  static const List<BoxShadow> glassSoft = [
    BoxShadow(color: Color(0x40000000), blurRadius: 24, offset: Offset(0, 8)),
  ];
  static const List<BoxShadow> glassElevated = [
    BoxShadow(color: Color(0x66000000), blurRadius: 40, offset: Offset(0, 16)),
    BoxShadow(color: Color(0x14FFFFFF), blurRadius: 1, offset: Offset(0, 1)), // top hairline highlight
  ];
  static const List<BoxShadow> glowPrimary = [
    BoxShadow(color: AppColors.glowPrimary, blurRadius: 32, spreadRadius: -4),
  ];
  static const List<BoxShadow> glowLime = [
    BoxShadow(color: AppColors.glowLime, blurRadius: 28, spreadRadius: -6),
  ];
}
```

### 3.6 `lib/core/theme/glass_tokens.dart` (YENİ)
Tüm glass varyantları için tek doğru kaynak:
```dart
enum GlassIntensity { subtle, regular, strong }

class GlassTokens {
  static double blurSigma(GlassIntensity i) => switch (i) {
    GlassIntensity.subtle => 8.0,
    GlassIntensity.regular => 14.0,
    GlassIntensity.strong => 22.0,
  };

  static Color tint(GlassIntensity i) => switch (i) {
    GlassIntensity.subtle => AppColors.glassTintLight,
    GlassIntensity.regular => AppColors.glassTintMedium,
    GlassIntensity.strong => AppColors.glassTintStrong,
  };

  static Color border(GlassIntensity i) => switch (i) {
    GlassIntensity.subtle => AppColors.glassBorderSoft,
    GlassIntensity.regular => AppColors.glassBorderMedium,
    GlassIntensity.strong => AppColors.glassBorderMedium,
  };

  // Düşük güçlü cihazda blur'u kapatma eşiği (heuristic).
  static bool shouldUseRealBlur(BuildContext context) {
    final mq = MediaQuery.of(context);
    return !mq.disableAnimations;
  }
}
```

### 3.7 `app_theme.dart` Refactor
- Sabit renk tanımlarını `AppColors`'a taşı, eski tanımları sil.
- `primaryGradient` tanımını `AppGradients.primaryCta` ile DEĞİŞTİR ve eski adı kaldır.
- `cardTheme`, `inputDecorationTheme`, `bottomSheetTheme` arkaplanlarını `Colors.transparent` veya `surface@alpha` yap (aşağıdaki widget'lar zaten arkaplanı sağlayacak).
- `bottomNavigationBarTheme`'e `backgroundColor: Colors.transparent` ver — gerçek nav widget kendi cam arkaplanını çizecek.

**Doğrulama:** `flutter analyze` temiz, eski `AppTheme.primaryGreen` vb. referanslar `AppColors.primary`'ye dönüşmüş.

---

## 4. FAZ 2 — Ortak Widget Kütüphanesi

Hepsi `lib/core/widgets/` altına. Hepsi `const` constructor'lı, `RepaintBoundary` ile sarılı, dökümante edilmemiş kısa widget'lar.

### 4.1 `glass_container.dart` — Canonical Cam Yüzey
```dart
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
        child: Stack(children: [
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
              padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
              child: child,
            ),
          ),
          if (showEdgeAccent)
            Positioned(top: 0, left: 0, right: 0, height: 1.2,
              child: const DecoratedBox(
                decoration: BoxDecoration(gradient: AppGradients.glassEdgeAccent),
              ),
            ),
        ]),
      ),
    );
  }
}
```

### 4.2 `glass_surface.dart` — Cheap Glass (Liste itemları için)
Blur YOK. Yarı saydam renk + ince border + opsiyonel ince üst highlight + BoxShadow ile "frosted illüzyonu". Liste, chip, küçük rozet için kullanılacak.

### 4.3 `gradient_background.dart` — Sayfa Sahne Arkaplanı
```dart
/// Sayfaların kök arkaplanı. Tek seferlik render edilir, paint cache'lenir.
/// İçerik: sceneBackdrop (linear) + 3 ambient blob (radial) + opsiyonel noise + vignette.
/// Animasyon: 1 tane AnimationController, 30s döngü. Blob'ları çok yavaş scale + translate yapar.
/// disableAnimations true ise sabit kalır.
class GradientBackground extends StatefulWidget {
  const GradientBackground({super.key, required this.child, this.animated = true, this.showNoise = true, this.showVignette = true});
  final Widget child;
  final bool animated;
  final bool showNoise;
  final bool showVignette;
  ...
}
```
Detaylar:
- Linear `sceneBackdrop` `DecoratedBox` ile alt katman.
- Üzerine 3 `Positioned` `IgnorePointer` blob; her biri `RadialGradient` ile boyalı `Container`. Pozisyonlar: sol-üst, sağ-orta, sol-alt.
- `RepaintBoundary` ile blob layer'ı izole.
- Animasyon: `AnimatedBuilder` + `Transform.translate` ile blob'ları ±20px döngü, period 30-45s.
- Noise: `Image.asset('assets/textures/noise.png', repeat: ImageRepeat.repeat, colorBlendMode: BlendMode.overlay, color: Color(0x0AFFFFFF))` veya yoksa `CustomPaint` ile statik üret + cache.
- Vignette: `IgnorePointer` + `DecoratedBox(gradient: AppGradients.vignette)`.
- En üste `child`.

### 4.4 `gradient_button.dart` — Premium CTA
- `primaryCta` linear gradient + `glowLime` shadow (basıldığında shadow azalır).
- `AnimatedScale` ile press feedback (0.97). `InkWell` yerine `GestureDetector` + `AnimatedContainer`.
- `disabled` state'te gradient'i gri tonlarına çevir, glow kaldır.

### 4.5 `gradient_outlined_button.dart` — İkincil CTA (Glass Border)
- `GlassSurface` arkaplanı + `gradient` border (CustomPainter ile).

### 4.6 `gradient_text.dart`
- `ShaderMask` + `AppGradients.brandText`. Sadece başlıklar için.

### 4.7 `gradient_avatar_ring.dart`
- `SweepGradient` ring + iç kısımda `CircleAvatar` (cached_network_image). Yavaş dönen sweep (60s döngü, opsiyonel).

### 4.8 `glass_app_bar.dart`
- `PreferredSizeWidget`. Üst kenarda `GlassContainer(intensity: regular)` + alt 1px `glassEdgeAccent`. `extendBodyBehindAppBar: true` ile kullanılacak.

### 4.9 `glass_bottom_nav.dart`
- Tek `GlassContainer(intensity: strong)` + 5 ikon. Aktif ikonun arkasında `gradient_pill_indicator`. `Scaffold.extendBody: true`.

### 4.10 `glass_sheet.dart` — `showModalBottomSheet` üzerine sarmalayıcı
- Üstte 4×40 grab handle (gradient).
- Arkaplan `GlassContainer(intensity: strong)`, üst köşeler radius xxl.
- Backdrop için `barrierColor: Color(0xCC000000)` + opsiyonel global blur (sadece sheet açıkken).

### 4.11 `glass_card.dart` — Liste Item Arkaplanı
- `GlassSurface` (blur YOK) + `showEdgeAccent: true`.
- Tap için `InkWell` ile `BorderRadius` clip.

### 4.12 `glow_icon_badge.dart`
- Yuvarlak rozet, gradient fill, `glowPrimary` shadow. Skill seviye, fiyat, status etiketleri için.

### 4.13 `ambient_orb.dart`
- Tek bir `RadialGradient` blob (test için, debug ekranlarında kullanılabilir).

### 4.14 `loading_state.dart`, `empty_state.dart`, `error_state.dart`
- Hepsi merkezi `GlassContainer` + ikon (gradient_text ile başlık) + açıklama + opsiyonel `gradient_button`.

**Doğrulama:** Hiçbir widget'ta hardcode renk/radius/spacing yok; hepsi token'dan. `flutter analyze` temiz.

---

## 5. FAZ 3 — Ekran Migrasyonu

Sıra (basitten karmaşığa, böylece hızlı feedback):

1. `app_shell.dart` — `GlassBottomNav` + `extendBody: true` + sayfa root'una `GradientBackground`.
2. `login_screen.dart` — `GradientBackground`, başlık `GradientText`, OTP kutuları `GlassContainer`, CTA `GradientButton`.
3. `profile_screen.dart` — Avatar `GradientAvatarRing`, istatistik kartları `GlassCard` + `glassEdgeAccent`, skill rozet `GlowIconBadge`.
4. `profile_setup_screen.dart` — form alanları `GlassCard` içinde.
5. `explore_screen.dart` — üst filtre çubuğu `GlassContainer(strong)`, harita pin'leri özel `GlassMarker`, bottom sheet `GlassSheet`, liste item'ları `GlassCard`.
6. `match_listing_detail_screen.dart` — hero kart `GlassContainer(strong)` + `gradient` ring saat etrafında, CTA `GradientButton`, "teklif yap" bottom sheet'i `GlassSheet`.
7. `match_listing_create_screen.dart` & `player_listing_create_screen.dart` — adım göstergesi gradient progress, form bölümleri `GlassCard`.
8. `offers_screen.dart` — `TabBar` üstü `GlassContainer`, kartlar `GlassCard`, durum etiketleri `GlowIconBadge`.
9. `my_matches_screen.dart` — aynı patern.
10. `messages_list_screen.dart` — sohbet item'ları `GlassCard`.
11. `chat_screen.dart` — gelen baloncuk `GlassSurface`, giden baloncuk `gradient` (primaryCta), input bar `GlassContainer(strong)`.
12. `user_profile_screen.dart` — `profile_screen` ile aynı patern.

**Her ekran için kontrol listesi (her commit/checkpoint'te uygula):**
- [ ] `Container(decoration: BoxDecoration(...))` inline glass/gradient kalmadı.
- [ ] `Color(0xFF...)` literal yok.
- [ ] `Opacity(...)` widget'ı yok.
- [ ] `BackdropFilter` doğrudan çağrılmıyor (sadece `GlassContainer` üzerinden).
- [ ] Aynı viewport'ta `GlassContainer` + `GlassSheet` toplamı ≤ 3.
- [ ] Liste item'ı `GlassCard` (blur'suz), `GlassContainer` değil.
- [ ] Liste `ListView.builder` + her item `RepaintBoundary` ile sarılı.
- [ ] Tüm spacing/radius `AppSpacing`/`AppRadii`'den.
- [ ] `flutter analyze` temiz.

**Migrasyon kuralı:** Bir ekrana başladıktan sonra bitirmeden başkasına geçme. Yarım ekran commitleme.

---

## 6. FAZ 4 — Performans Doğrulaması

1. `flutter run --profile` ile Android emülatör (mümkünse fiziksel düşük seviye cihaz) ve iOS Simulator'da çalıştır.
2. DevTools → Performance Overlay aç. Şu ekranlarda 5 saniye scroll/etkileşim:
   - Explore (en yoğun: harita + bottom sheet + liste).
   - Offers (TabBar geçişi).
   - Chat (klavye aç/kapa, mesaj scroll).
3. Beklenti: tüm frame'ler ≤ 16ms (raster + UI). Jank frame oranı %0.
4. Eğer jank varsa:
   - `BackdropFilter` saysını azalt.
   - List item'larında blur kullanılıyorsa kaldır → `GlassSurface`.
   - `RepaintBoundary` ekle.
   - `const` eksik yerlere ekle.
5. **Ölçüm raporu yaz:** her ekran için ortalama frame süresi, max raster, BackdropFilter sayısı.

---

## 7. Test Stratejisi (Minimum)

- Tüm yeni widget'lar için `widget_test`:
  - `GlassContainer` render edildiğinde `BackdropFilter` exists (animations enabled iken).
  - `GradientBackground` `disableAnimations: true` ile static.
  - `GradientButton` `onPressed: null` iken disabled stilinde.
- Golden test (opsiyonel ama önerilir): bir ekran için tema değişmediğinde diff yok.

---

## 8. YASAK Listesi (Bunları YAPMA)

- ❌ Üçüncü taraf glass paketi (`glassmorphism`, `glass_kit` vb.) ekleme. Performans kontrolünü kaybediyoruz.
- ❌ `Stack` üzerinde 5'ten fazla `Positioned` overlay.
- ❌ `AnimatedContainer` her frame yeni `BoxDecoration` üretmek (gradient'i değiştirmek).
- ❌ `flutter_svg` ile karmaşık SVG arkaplan (raster hiti yüksek).
- ❌ `Glassmorphism` efekti için `ImageFilter.blur` çağrısını widget tree dışında manuel `Picture` çiziyor numarası.
- ❌ Web'in 3D efektini birebir kopyalama. Mobil için sadeleştir.
- ❌ Yeni asset eklerken pubspec'i unutma — eklediysen `flutter pub get`'i de yap.
- ❌ Refactor sırasında lojiği değiştirme. Sadece sunum katmanı.

---

## 9. Çıktı Formatı (Her Faz Sonunda)

Şu raporu üret:
```
## Faz N — Tamamlandı
### Eklenen/değişen dosyalar
- ...
### Yapılmayanlar (varsa) ve sebebi
- ...
### Ölçümler (Faz 4 ise)
- ...
### Sonraki adım
- ...
```

---

## 10. Başla

**Faz 0** ile başla. Yalnızca okuma + plan raporu. Tek satır kod yazma. Onay bekle.
