# SAHADA Flutter — Geliştirici AI Görev Talimatı

Bu dosya, projeyi tamamlayacak yapay zekâya verilecek **tek seferlik, kapsamlı görev tanımıdır.** Talimatları sırayla, her fazı tamamlayıp doğrulayarak ilerle. Hiçbir fazı atlama.

---

## 0. Genel Bağlam

**Proje:** SAHADA — futbol/halı saha oyuncu ve maç eşleştirme platformu. Türkçe arayüz.
**Hedef:** Referans olarak verilen Next.js web uygulamasının **birebir Flutter mobil karşılığını** üretmek. Backend olarak NestJS+Prisma DEĞİL, **Supabase (Postgres + PostGIS + Auth + Storage + Realtime)** kullanılacak.

**Yollar (mutlak):**
- Bizim projemiz (üzerinde çalışacağın): `/Users/alperensari/Desktop/sahada/sahada_dev/`
- Referans web projesi (sadece OKU, kopyalama):
  - Web UI: `/Users/alperensari/Desktop/referans/apps/web/src/`
  - Veri modeli (Prisma): `/Users/alperensari/Desktop/referans/apps/api/prisma/schema.prisma`
  - Backend mantığı (NestJS servisleri): `/Users/alperensari/Desktop/referans/apps/api/src/`

**Mevcut durum (zaten var):**
- `lib/main.dart` (placeholder)
- `lib/core/config/env_config.dart` — `.env` yükleyici
- `lib/core/services/supabase_service.dart` — singleton Supabase client
- `lib/core/services/auth_service.dart` — email/password tabanlı auth wrapper
- `lib/core/services/storage_service.dart` — avatars bucket helper
- `pubspec.yaml`: yalnızca `supabase_flutter`, `flutter_dotenv`, `cupertino_icons`
- `supabase/migrations/20260505000001_initial_setup.sql` — sadece extension'lar (uuid-ossp, postgis, updated_at trigger)

**Eksik:** Veri modeli, RLS politikaları, repository katmanı, state management, routing, TÜM ekranlar.

---

## 1. Mimari Kararlar (Bunları Sorgusuz Uygula)

| Konu | Karar |
|---|---|
| State management | **Riverpod** (`flutter_riverpod` + `riverpod_annotation` + `riverpod_generator`) |
| Routing | **go_router** |
| HTTP/Backend | Supabase SDK (REST yok — tablolara doğrudan erişim + RLS) |
| Form | `reactive_forms` veya basit `Form` widget'ı + `TextFormField` (tercih senin, ama tutarlı ol) |
| Harita | `flutter_map` + OpenStreetMap (Leaflet'in mobil karşılığı) |
| Tarih/saat | `intl` paketi, locale `tr_TR` |
| Avatar/resim | `image_picker` + Supabase Storage (mevcut `StorageService`) |
| Realtime sohbet | Supabase Realtime channel'ları |
| Tema | Karanlık tema, premium görünüm. Birincil renk lime/yeşil gradyan: `#a3e635 → #22c55e`. Arkaplan: derin lacivert `#020408 / #050912`. Yazı tipi: **Inter** (Google Fonts via `google_fonts` paketi) |
| Kod stili | `flutter_lints` aktif. `analysis_options.yaml`'a `prefer_const_constructors`, `avoid_print` ekle |
| Dil | Tüm UI metinleri **Türkçe**. Hata mesajları kullanıcıya Türkçe gösterilecek |

**Klasör yapısı (zorunlu):**
```
lib/
├── main.dart
├── app.dart                      # MaterialApp.router + tema
├── core/
│   ├── config/env_config.dart
│   ├── services/                 # supabase_service, auth_service, storage_service
│   ├── theme/app_theme.dart      # ThemeData, renkler, gradyanlar
│   ├── router/app_router.dart    # go_router yapılandırması
│   ├── utils/                    # date_utils, distance_utils, validators
│   └── widgets/                  # ortak butonlar, kartlar, glass container
├── features/
│   ├── auth/                     # login, otp_verify, register
│   ├── profile/                  # profile_view, profile_setup, profile_edit
│   ├── explore/                  # harita ekranı, filtreler
│   ├── match_listings/           # liste, detay, oluştur
│   ├── player_listings/          # liste, detay, oluştur
│   ├── offers/                   # gelen/giden teklifler
│   ├── my_matches/               # katıldığım maçlar
│   ├── messages/                 # sohbet listesi + sohbet
│   └── reviews/                  # değerlendirme oluştur/listele
└── data/
    ├── models/                   # User, MatchListing, PlayerListing, Offer, vs. (freezed)
    └── repositories/             # her tablo için bir repository
```

Her `feature/` altında: `presentation/` (ekran + widget), `application/` (riverpod provider/notifier), `domain/` (model — gerekirse), `data/` (repository çağrılarının orchestration'ı).

---

## 2. FAZ 1 — Veritabanı Şeması (Supabase Migrations)

`supabase/migrations/` altına **yeni bir dosya** ekle: `20260505000002_core_schema.sql`. İçinde aşağıdaki tabloları kur. Tüm referansını **Prisma şeması**ndan al: `/Users/alperensari/Desktop/referans/apps/api/prisma/schema.prisma`

### 2.1 Enum'lar (Prisma'daki ile birebir aynı isimler ve değerler)
- `skill_level` (BEGINNER, INTERMEDIATE, ADVANCED)
- `match_format` (FIVE_VS_FIVE, SIX_VS_SIX, SEVEN_VS_SEVEN)
- `position_type` (GOALKEEPER, DEFENDER, MIDFIELDER, FORWARD, ANY)
- `price_type` (FREE, PAID)
- `listing_status` (OPEN, FILLED, COMPLETED, CANCELED)
- `offer_status` (SENT, COUNTERED, ACCEPTED, REJECTED, EXPIRED)
- `participation_status` (ACCEPTED, LEFT, KICKED)
- `report_status` (PENDING, REVIEWED, RESOLVED)
- `payment_method` (CASH, IBAN)
- `cancellation_level` (FLEXIBLE, MEDIUM, STRICT)

### 2.2 Tablolar (Prisma model adlarını snake_case'e çevir)

`users` — Supabase `auth.users` ile **iki yönlü** çalışacak. `users` tablomuz `auth.users(id)` referansıyla bağlanmalı (PK ortak). Şemada Prisma'daki `User` modelinin alanlarını kullan: `phone`, `email`, `display_name`, `avatar_url`, `birth_year`, `home_lat`, `home_lng`, `is_admin`, `is_banned`, `kvkk_accepted_at`, `created_at`, `updated_at`. Auth kayıt olduğunda `users` row'u otomatik üretilsin: bir `auth.users` AFTER INSERT trigger'ı yaz.

Diğer tablolar (Prisma'daki ile aynı alan ve ilişkiler):
- `user_profiles` (skill_level, positions[], bio, matches_played_count, rating_avg, rating_count, no_show_count)
- `match_listings` (lat/lng yerine `geog geography(Point,4326)` da ekle — PostGIS sorguları için)
- `player_listings` (center_lat/lng + `geog`)
- `offers`
- `participations`
- `chats`
- `chat_members`
- `messages`
- `reviews`
- `reports`

`refresh_tokens`, `otp_codes`, `email_otp_codes` tablolarını **kurma** — Supabase Auth bunu kendi yapıyor.

Her tabloda:
- `id uuid default gen_random_uuid() primary key`
- `created_at timestamptz default now()`
- `updated_at timestamptz default now()` + `update_updated_at_column()` trigger'ı
- Prisma'daki `@@index` direktiflerini Postgres `CREATE INDEX` olarak eşleştir
- `match_listings`/`player_listings`'te `geog` üzerine **GIST** indeksi

### 2.3 RLS Politikaları
**Her tabloda RLS açık olmalı.** Politikalar:
- `users`: herkes okuyabilir; sadece sahibi UPDATE edebilir.
- `user_profiles`: herkes okur; sahibi yazar.
- `match_listings`/`player_listings`: herkes okur; `organizer_id`/`player_id` = `auth.uid()` olan UPDATE/DELETE yapabilir; INSERT auth zorunlu.
- `offers`: sadece `from_user_id` veya `to_user_id` = `auth.uid()` olan SELECT/UPDATE yapabilir.
- `participations`: herkes ilgili maç için SELECT; sadece kendi katılımını LEAVE edebilir; organizatör KICK için UPDATE edebilir.
- `chats`/`chat_members`/`messages`: yalnızca üyesi olan kullanıcı SELECT/INSERT.
- `reviews`: herkes SELECT; sadece `reviewer_id` = `auth.uid()` INSERT.
- `reports`: sadece kendi raporlarını okur; INSERT auth zorunlu.

### 2.4 Storage Bucket'ları
- `avatars` (public read, kendi userId klasörüne yaz) — zaten kısmen kuruldu, politikayı SQL'e yaz.

### 2.5 RPC (Postgres Functions)
- `nearby_matches(p_lat float, p_lng float, p_radius_km int)` → PostGIS `ST_DWithin` ile yakın `match_listings` döner.
- `nearby_players(p_lat float, p_lng float, p_radius_km int)` → aynı mantık.
- `get_user_stats(p_user_id uuid)` → matches_played_count, rating_avg, rating_count, vs. döner.

**Doğrulama:** Bu fazı bitirdiğinde `supabase db push` ile migration'ı uygulayabileceğin durumda olsun. Hata varsa düzelt.

---

## 3. FAZ 2 — `pubspec.yaml` Bağımlılıkları

Aşağıdakileri ekle (en güncel uyumlu sürümlerle):
```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  go_router: ^14.0.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0
  google_fonts: ^6.2.1
  flutter_map: ^7.0.0
  latlong2: ^0.9.1
  geolocator: ^12.0.0
  image_picker: ^1.1.2
  intl: ^0.19.0
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0

dev_dependencies:
  build_runner: ^2.4.11
  riverpod_generator: ^2.4.0
  freezed: ^2.5.7
  json_serializable: ^6.8.0
```

Sonra `flutter pub get` çalıştırılabilir olduğundan emin ol.

---

## 4. FAZ 3 — Veri Modeli (`lib/data/models/`)

Her tablo için bir `freezed` model üret. Örnek: `user_model.dart`, `match_listing_model.dart`, vs. Modellerde:
- `fromJson` / `toJson`
- Enum alanları için `JsonKey` ile string ↔ enum dönüştürücü
- DateTime alanları ISO 8601

Sonra `flutter pub run build_runner build --delete-conflicting-outputs` çalıştırılabilir olmalı.

---

## 5. FAZ 4 — Repository Katmanı (`lib/data/repositories/`)

Her ana entity için bir repository: `users_repository.dart`, `match_listings_repository.dart`, `player_listings_repository.dart`, `offers_repository.dart`, `participations_repository.dart`, `chats_repository.dart`, `reviews_repository.dart`, `reports_repository.dart`.

Her repository:
- Riverpod provider olarak expose et (`@riverpod` annotation).
- Supabase client'ı `SupabaseService.instance` üzerinden al.
- CRUD + sorgu metotları. Endpoint listesi için **kesinlikle referansa bak**: `/Users/alperensari/Desktop/referans/apps/web/src/lib/api.ts` — bu dosyadaki her metod, bizim için bir repository fonksiyonuna karşılık geliyor. Ama backend yerine **Supabase tabloları + RPC'ler** kullan.

Eşleştirme örnekleri:
| Web API çağrısı | Bizdeki repo metodu |
|---|---|
| `authApi.requestOtp(phone)` | `authService.signInWithOtp(phone)` (Supabase phone OTP) |
| `usersApi.getMe()` | `usersRepository.getCurrentUser()` |
| `matchListingsApi.create(data)` | `matchListingsRepository.create(data)` |
| `searchApi.searchMatches(params)` | `matchListingsRepository.search(...)` (RPC `nearby_matches` + filtreler) |
| `offersApi.accept(id)` | `offersRepository.accept(id)` (status='ACCEPTED' + participation INSERT, transaction) |
| `chatsApi.sendMessage(chatId, body)` | `chatsRepository.sendMessage(...)` |

---

## 6. FAZ 5 — Routing ve App Shell

### 6.1 `lib/core/router/app_router.dart`
`go_router` yapılandırması. Auth guard'ı: `redirect` callback'i ile `authService.isAuthenticated`'a bakıp giriş yapmamış kullanıcıyı `/login`'e at.

Route'lar:
| Path | Ekran |
|---|---|
| `/` | Landing (splash + giriş yapmamışsa CTA, yapmışsa `/explore`'a yönlendir) |
| `/login` | Login (OTP) |
| `/profile/setup` | İlk kez giriş yapanlar için profil kurulum |
| `/explore` | Ana keşfet (harita + liste) |
| `/match-listings/new` | Maç ilanı oluştur |
| `/match-listings/:id` | Maç detay |
| `/player-listings/new` | Oyuncu ilanı oluştur |
| `/offers` | Tekliflerim (sent/received tab) |
| `/my-matches` | Maçlarım |
| `/messages` | Sohbetlerim |
| `/messages/:id` | Sohbet detay |
| `/profile` | Kendi profilim |
| `/users/:id` | Başka kullanıcı profili |

### 6.2 `lib/app.dart`
`ConsumerWidget` olarak `MaterialApp.router` kur. Tema ve router'ı bağla.

### 6.3 Bottom Navigation
Giriş yapılmış route'larda alt tab bar: **Keşfet • Maçlarım • Teklifler • Sohbet • Profil**. `ShellRoute` kullan.

---

## 7. FAZ 6 — Ekranlar

Her ekran için referans web sayfasının yolunu belirttim. **O dosyayı oku, hangi alanlar/etkileşimler var anla, sonra Flutter widget'ı olarak tekrar üret.** Birebir HTML kopyası değil; bu MOBİL bir uygulama — ergonomi mobile uygun olsun (büyük dokunma alanları, BottomSheet'ler, Pull-to-refresh).

### 7.1 Login + OTP
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/login/page.tsx` (589 satır — tüm akışı oradan oku)
- Telefon ile OTP. Supabase `auth.signInWithOtp({ phone })` kullan.
- KVKK onay kutusu (zorunlu).
- İsim + opsiyonel email alanları (yeni kayıtlar için).
- OTP doğrulama ekranı: 6 haneli kod, geri sayım.

### 7.2 Profile Setup
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/profile/setup/page.tsx`
- Avatar yükle (image_picker + StorageService).
- Doğum yılı, mevki seçimi (multi), seviye, ev konumu (harita ile pin).
- KVKK ve devam et → `/explore`.

### 7.3 Explore (ANA EKRAN)
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/explore/page.tsx` (735 satır)
- Üstte segment toggle: **Maçlar / Oyuncular**.
- `flutter_map` ile harita; pinler maç/oyuncu listesini gösterir.
- Alt yarıda DraggableScrollableSheet: filtrelenmiş ilan listesi.
- Filtreler: tarih, format (5v5/6v6/7v7), seviye, fiyat aralığı, mesafe.
- Kullanıcı konumunu `geolocator` ile al; izin yoksa İstanbul merkezi default.
- API yoksa mock — biz Supabase kullanıyoruz, mock'a gerek yok ama boş state'i nazikçe göster.

### 7.4 Match Listing Detay
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/match-listings/[id]/page.tsx`
- Maç bilgileri kartı, organizatör profili, harita (saha pini), katılımcı listesi.
- "Teklif Yap" butonu → `BottomSheet`'te miktar + mesaj.
- Organizatörse: "Teklifleri Gör", "Maçı Tamamla", "İptal".

### 7.5 Match Listing Oluştur
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/match-listings/new/page.tsx` (641 satır)
- Form: başlık, açıklama, saha adı, harita pin (lat/lng), tarih/saat picker, format, gerekli oyuncu, mevki, seviye, fiyat tipi/tutarı, pazarlık aç/kapa, iptal politikası.
- Validation: tüm zorunlu alanlar + `starts_at > now`.

### 7.6 Player Listing Oluştur
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/player-listings/new/page.tsx`
- Form: notlar, merkez konum + yarıçap, müsait aralık (start/end), mevkiler, seviye, format tercihleri, talep edilen ücret.

### 7.7 Profil
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/profile/page.tsx` (652 satır)
- Avatar, isim, bio, seviye rozet, mevkiler.
- İstatistikler: oynadığı maç, ortalama puan, no-show sayısı.
- Son değerlendirmeler.
- Düzenle butonu (kendi profili ise).

### 7.8 Tekliflerim
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/offers/page.tsx`
- TabBar: Gelen / Giden.
- Her teklif kartı: gönderen, miktar, durum, tarih.
- Aksiyonlar (gelen): Kabul, Karşı teklif, Reddet.

### 7.9 Maçlarım
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/my-matches/page.tsx`
- Hosted (organizatör) ve Joined (katılımcı) tab'leri.
- Geçmiş maçlar için "Değerlendir" butonu.

### 7.10 Sohbet
**Referanslar:**
- Liste: `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/messages/page.tsx`
- Detay: `/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/messages/[id]/page.tsx`
- Supabase Realtime ile mesaj abone olma.
- Klavye açıldığında scroll'u koruyan ListView.

### 7.11 Landing (Giriş Öncesi)
**Referans:** `/Users/alperensari/Desktop/referans/apps/web/src/app/page.tsx` (1149 satır — sadece anlamak için)
- Mobilde kısa tut: marka logosu, kısa tagline, "Giriş Yap" CTA.

---

## 8. FAZ 7 — Tema, Ortak Widget'lar, Polish

### 8.1 `lib/core/theme/app_theme.dart`
- Karanlık `ThemeData`. Birincil renk `Color(0xFF22C55E)`. Surface `Color(0xFF050912)`.
- `Inter` fontu Google Fonts üzerinden.
- Buton stilleri (gradient destekli `ElevatedButton`).

### 8.2 Ortak widget'lar (`lib/core/widgets/`)
- `GlassContainer` — yarı saydam, blur, ince border. Web'deki cam efekti.
- `PrimaryGradientButton` — lime→yeşil gradient.
- `SkillBadge`, `PositionChip`, `PriceTag` — küçük tekrar eden parçalar.
- `EmptyState`, `LoadingState`, `ErrorState`.
- `UserAvatar` (web'deki `UserAvatar.tsx` karşılığı: `cached_network_image` + initials fallback).

### 8.3 Validation utilities (`lib/core/utils/validators.dart`)
- Telefon (Türkiye formatı), email, gerekli alan, sayısal aralık.

---

## 9. Yapma / Yapma Kuralları

**YAPMA:**
- ❌ NestJS controller'larını taklit etme — bizim Supabase'imiz var. Doğrudan `supabase.from(...)` kullan.
- ❌ Refresh token, JWT yönetimi yazma — Supabase SDK halleder.
- ❌ Mock data sistemi kurma — boş state'i UI'da nazikçe göster.
- ❌ Web'in 1149 satırlık landing'ini birebir kopyalama — mobile sade tut.
- ❌ `print` kullanma — `debugPrint` kullan.
- ❌ Yorum satırı patlatma — kod kendi kendini açıklasın.

**YAP:**
- ✅ Her faz sonunda `flutter analyze` temiz olmalı.
- ✅ Her ekrana en az **boş state, loading state, error state** ekle.
- ✅ Tüm string'ler Türkçe.
- ✅ Form validation mesajları kullanıcı dostu.
- ✅ Migration SQL'i deterministik (idempotent değil — ama hata durumunda revert edilebilir) yaz.
- ✅ Önemli iş kuralları için Postgres'te trigger/function tercih et (örn. teklif kabul edildiğinde participation oluşturma).

---

## 10. Çalışma Sırası ve Doğrulama Noktaları

1. **Faz 1** (DB şeması) → bitir, dur. Migration dosyasını göster.
2. **Faz 2** (pubspec) → `flutter pub get` çalıştır, çıktıyı göster.
3. **Faz 3** (modeller) → `build_runner` çalıştır, çıktıyı göster.
4. **Faz 4** (repository) → `flutter analyze` temiz olmalı.
5. **Faz 5** (router + app shell) → uygulama açılıp `/login`'e düşmeli.
6. **Faz 6** (ekranlar) → her ekranı bitirince `flutter analyze` ve manuel kontrol notu yaz.
7. **Faz 7** (polish) → son rötuş.

Her faz sonunda **kısa bir ilerleme raporu** ver:
- Hangi dosyalar eklendi/değişti
- Bilinen eksikler
- Bir sonraki adım

---

## 11. Önemli Not

Referans projedeki **`(app)/layout.tsx`** dosyasını (`/Users/alperensari/Desktop/referans/apps/web/src/app/(app)/layout.tsx`) mutlaka oku — orada üst-bar/menü/notification dropdown gibi shell bileşenleri var. Mobilde bunlar bottom nav + AppBar action'larına dönüşür.

Referansta `src/lib/auth-context.tsx` dosyası global auth state'i tutuyor — biz bunun yerine `currentUserProvider` (Riverpod) kullanacağız. Auth state değişikliklerini `Supabase.instance.client.auth.onAuthStateChange` stream'inden dinleyip provider'ı invalide et.

---

## 12. Başla

Faz 1'den başla. Önce `supabase/migrations/20260505000002_core_schema.sql` dosyasını yaz. Hazır olunca durup raporla.
