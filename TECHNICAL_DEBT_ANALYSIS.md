# 🔍 TEKNİK BORÇ ANALİZİ - SAHADA PROJESİ

**Tarih:** 13 Mayıs 2026  
**Analiz Tipi:** Kapsamlı Kod Kalitesi ve Teknik Borç Değerlendirmesi  
**Skor:** **6.5/10** ⚠️

---

## 📊 GENEL DURUM

### Skor Dağılımı
| Kategori | Skor | Ağırlık | Katkı |
|----------|------|---------|-------|
| **Kod Kalitesi** | 7/10 | 25% | 1.75 |
| **Performans** | 6/10 | 20% | 1.20 |
| **Backend Uyumu** | 4/10 | 30% | 1.20 |
| **Güvenlik** | 8/10 | 15% | 1.20 |
| **Bakım Kolaylığı** | 7/10 | 10% | 0.70 |
| **TOPLAM** | **6.5/10** | 100% | **6.05** |

### Durum Özeti
- ✅ **İyi Yanlar:** Temiz mimari, Riverpod kullanımı, type-safety
- ⚠️ **Orta Sorunlar:** Performans optimizasyonları, kod tekrarı
- 🔴 **Kritik Sorunlar:** Database schema uyumsuzluğu, memory leaks

---

## 🔴 KRİTİK SORUNLAR (P0 - Hemen Düzeltilmeli)

### 1. DATABASE SCHEMA UYUMSUZLUĞU ⚠️⚠️⚠️
**Etki:** 🔴 **PRODUCTION BLOCKER**  
**Dosyalar:** 
- `supabase/migrations/20260505000001_initial_setup.sql`
- Tüm repository ve model dosyaları

**Sorun:**
Database'de **ESKİ tablo isimleri** var, kod **YENİ tablo isimleri** kullanıyor:

| Database (ESKİ) | Kod (YENİ) | Durum |
|-----------------|------------|-------|
| `match_posts` | `match_listings` | ❌ Uyumsuz |
| `player_ads` | `player_listings` | ❌ Uyumsuz |
| `applications` | `participations` | ❌ Uyumsuz |
| `player_profiles` | `user_profiles` | ❌ Uyumsuz |
| `users` | `users` | ✅ Uyumlu |

**Kolon Uyumsuzlukları:**

**match_posts vs match_listings:**
```sql
-- Database (ESKİ)
match_posts (
  organizer_id, title, city, district, location_name, 
  lat, lng, match_time, needed_players, status
)

-- Kod (YENİ)
match_listings (
  organizer_id, title, pitch_name, lat, lng, starts_at,
  format, needed_count, skill_level, price_type, base_price,
  negotiation_enabled, cancel_window_hours, late_tolerance_min,
  payment_method, min_quality_score, cancellation_level, status
)
```

**Eksik Kolonlar:**
- `format` (MatchFormat enum)
- `skill_level` (SkillLevel enum)
- `price_type`, `base_price`
- `negotiation_enabled`
- `cancel_window_hours`, `late_tolerance_min`
- `payment_method`, `min_quality_score`, `cancellation_level`
- `needed_positions` (array)

**Çözüm Seçenekleri:**

**Seçenek A: Database'i Güncelle (ÖNERİLEN)**
```sql
-- Yeni migration oluştur: 20260513000002_update_schema.sql
ALTER TABLE match_posts RENAME TO match_listings;
ALTER TABLE player_ads RENAME TO player_listings;
ALTER TABLE applications RENAME TO participations;
-- Kolonları ekle/güncelle
ALTER TABLE match_listings ADD COLUMN format TEXT;
ALTER TABLE match_listings ADD COLUMN skill_level TEXT;
-- ... diğer kolonlar
```

**Seçenek B: Kodu Güncelle**
- Tüm model ve repository dosyalarını eski schema'ya uyarla
- ❌ ÖNERİLMEZ - Yeni özellikler kaybolur

---

### 2. ENUM DUPLIKASYONU
**Etki:** 🔴 **Type Confusion, JSON Serialization Hatası**  
**Dosyalar:**
- `lib/data/models/enums.dart` (lines 7-38)
- `lib/features/profile/application/profile_setup_state.dart` (lines 6-8)

**Sorun:**
`SkillLevel` ve `PositionType` enums **2 yerde tanımlı**:

```dart
// ❌ YANLIŞ - enums.dart
enum SkillLevel {
  @JsonValue('BEGINNER') beginner,
  @JsonValue('INTERMEDIATE') intermediate,
  @JsonValue('ADVANCED') advanced,
}

// ❌ YANLIŞ - profile_setup_state.dart
enum SkillLevel { beginner, intermediate, advanced }
```

**Çözüm:**
```dart
// profile_setup_state.dart
import '../../../data/models/enums.dart'; // ✅ Import et

// Enum tanımlarını kaldır
```

---

### 3. MEMORY LEAK - TextEditingController
**Etki:** 🔴 **Memory Leak, Performance Degradation**  
**Dosya:** `lib/features/match_listings/presentation/match_listing_create_screen.dart:298`

**Sorun:**
```dart
Widget _buildTextField(...) {
  return TextField(
    controller: initialValue != null
        ? TextEditingController(text: initialValue)  // ❌ LEAK!
        : null,
  );
}
```

Her render'da yeni controller oluşturuluyor, dispose edilmiyor.

**Çözüm:**
```dart
class _MatchListingCreateScreenState extends ConsumerState<...> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  // ... diğer controllers
  
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
```

---

## ⚠️ YÜKSEK ÖNCELİKLİ SORUNLAR (P1)

### 4. TAMAMLANMAMIŞ ÖZELLİKLER (15+ TODO)

**Chat Feature:**
- `chat_screen.dart:45` - Realtime typing indicator
- `messages_list_screen.dart:104` - Last message display
- `messages_list_screen.dart:109` - Chat navigation

**Profile Feature:**
- `profile_screen.dart:341` - Privacy settings
- `profile_screen.dart:349` - Help & Support
- `profile_screen.dart:357` - About dialog

**Explore Feature:**
- `explore_screen.dart:707-711` - Detail navigation
- `explore_screen.dart:769-781` - Create navigation

**Match Listings:**
- `match_listing_create_screen.dart:577` - Position selection
- `my_matches_screen.dart:164` - Match detail navigation

**Router:**
- `app_router.dart:162` - User name fetch

**Çözüm:** Her TODO için issue aç, sprint'e ekle

---

### 5. PERFORMANS SORUNLARI

#### A. Eksik Const Constructors
**Etki:** Gereksiz widget rebuilds

**Dosyalar:**
- `profile_edit_screen.dart:332` - BoxDecoration
- `location_picker.dart:36` - LatLng
- `messages_list_screen.dart:114` - SizedBox
- `notifications_screen.dart:143` - Icon

**Çözüm:**
```dart
// ❌ Önce
BoxDecoration(color: Colors.red)

// ✅ Sonra
const BoxDecoration(color: Colors.red)
```

#### B. Büyük Build Metodları (God Widgets)
**Etki:** Yavaş rendering, zor bakım

| Dosya | Satır | Sorun |
|-------|-------|-------|
| `explore_screen.dart` | 800+ | Map + List + Filters + Modals |
| `chat_screen.dart` | 600+ | Messages + Images + Typing + Options |
| `match_listing_create_screen.dart` | 650+ | Form + Validation + Location |

**Çözüm:** Widget extraction
```dart
// ❌ Önce - 800 satır build()
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        // 200 satır map kodu
        // 200 satır list kodu
        // 200 satır filter kodu
        // 200 satır modal kodu
      ],
    ),
  );
}

// ✅ Sonra - Ayrı widget'lar
class ExploreScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ExploreMapWidget(),
          const ExploreListWidget(),
          const ExploreFiltersWidget(),
        ],
      ),
    );
  }
}
```

#### C. N+1 Query Problemi (Potansiyel)
**Dosya:** `match_listings_repository.dart:147`

```dart
// ⚠️ Potansiyel N+1
Future<List<MatchListing>> searchNearby(...) async {
  var response = await _supabase.rpc('nearby_matches', ...);
  var matches = (response as List).map(...).toList();
  
  // Client-side filtering - YAVAS!
  if (format != null) {
    matches = matches.where((m) => m.format == format).toList();
  }
  if (skillLevel != null) {
    matches = matches.where((m) => m.skillLevel == skillLevel).toList();
  }
}
```

**Çözüm:** Server-side filtering
```dart
// ✅ Database'de filtrele
var response = await _supabase.rpc('nearby_matches', params: {
  'p_lat': lat,
  'p_lng': lng,
  'p_radius_km': radiusKm,
  'p_format': format?.name,
  'p_skill_level': skillLevel?.name,
});
```

---

### 6. BACKEND ENTEGRASYON SORUNLARI

#### A. RLS Policy Uyumsuzluğu
**Sorun:** Policies eski tablo isimlerini kullanıyor

```sql
-- ❌ Database'de
CREATE POLICY "Match posts are viewable" ON match_posts ...

-- ✅ Olması gereken
CREATE POLICY "Match listings are viewable" ON match_listings ...
```

#### B. Eksik Database Functions
**Kod referans veriyor ama function yok:**

```dart
// match_listings_repository.dart:147
await _supabase.rpc('nearby_matches', ...);  // ❌ Function yok?

// users_repository.dart:82
await _supabase.rpc('get_user_stats', ...);  // ❌ Function yok?
```

**Çözüm:** Functions oluştur veya query'leri düzelt

#### C. Eksik Storage Bucket
**Kod kullanıyor ama migration yok:**

```dart
// chat_screen.dart:520
await SupabaseService.instance.storage
    .from('chat-images')  // ❌ Bucket oluşturulmamış
    .upload(path, File(pickedFile.path));
```

**Çözüm:** Migration ekle veya manuel oluştur

---

## 📊 ORTA ÖNCELİKLİ SORUNLAR (P2)

### 7. KOD KOKULARI (Code Smells)

#### A. Magic Numbers
**Dosyalar:** Birçok yerde

```dart
// ❌ explore_screen.dart:122
bottom: 90  // Ne anlama geliyor?

// ❌ Birçok yerde
fontSize: 11.2  // 20% reduction - neden?
fontSize: 14.4
width: 6.4
```

**Çözüm:** Constants kullan
```dart
// constants.dart
class AppDimensions {
  static const double bottomSheetOffset = 90.0;
  static const double fontSizeReduced = 11.2;
  static const double fontSizeNormal = 14.0;
}
```

#### B. Uzun Metodlar
**Dosyalar:**
- `explore_screen.dart:_buildListingCard()` - 100+ satır
- `chat_screen.dart:_handleImagePick()` - 80+ satır
- `match_listing_create_screen.dart:_handleSubmit()` - 100+ satır

**Çözüm:** Extract method
```dart
// ❌ Önce - 100 satır
void _handleSubmit() {
  // 20 satır validation
  // 30 satır data preparation
  // 30 satır API call
  // 20 satır error handling
}

// ✅ Sonra
void _handleSubmit() {
  if (!_validateForm()) return;
  final data = _prepareData();
  await _submitToApi(data);
}

bool _validateForm() { ... }
Map<String, dynamic> _prepareData() { ... }
Future<void> _submitToApi(Map<String, dynamic> data) { ... }
```

#### C. Inconsistent Patterns
**Sorunlar:**
- Bazı ekranlar `GlassCard`, bazıları `SolidCard`
- Türkçe/İngilizce karışık yorumlar
- Bazı yerler SnackBar, bazıları Dialog

**Çözüm:** Style guide oluştur

---

### 8. TEKNİK BORÇ

#### A. Deprecated API Usage
**Tüm `.g.dart` dosyalarında:**
```dart
// ⚠️ Riverpod 3.0 deprecation warnings
@ProviderFor(...)
Ref ref  // Deprecated, use WidgetRef
```

**Çözüm:** Riverpod 3.0'a migrate et

#### B. Dead Code
**Dosyalar:**
- `profile_edit_screen.dart:367` - Unreachable code
- `test/` klasöründeki kullanılmayan test dosyaları
- `lib/core/utils/supabase_test.dart` - Debug kodu

**Çözüm:** Sil veya refactor et

#### C. Eksik Error Handling
**Birçok yerde:**
```dart
// ❌ Hata yakalanmıyor
final response = await _supabase.from('table').select();
return response;  // Hata olursa?
```

**Çözüm:** Try-catch ekle
```dart
// ✅ Hata yakalanıyor
try {
  final response = await _supabase.from('table').select();
  return response;
} on PostgrestException catch (e) {
  throw RepositoryException('Failed to fetch: ${e.message}');
} catch (e) {
  throw RepositoryException('Unexpected error: $e');
}
```

---

## 🏗️ MİMARİ ANALİZ

### İyi Yanlar ✅
- ✅ Temiz feature-based klasör yapısı
- ✅ Presentation/Application ayrımı
- ✅ Riverpod ile state management
- ✅ Freezed ile immutable models
- ✅ No circular dependencies

### İyileştirme Alanları ⚠️
- ❌ Domain layer yok (business logic repository'de)
- ❌ Use case pattern yok (UI direkt repository çağırıyor)
- ❌ Error handling abstraction yok
- ❌ Logging/monitoring yok

**Önerilen Mimari:**
```
lib/
├── core/
│   ├── error/           # Custom exceptions
│   ├── logging/         # Logging service
│   └── monitoring/      # Analytics, crash reporting
├── domain/
│   ├── entities/        # Business models
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business logic
├── data/
│   ├── models/          # Data models (DTO)
│   ├── repositories/    # Repository implementations
│   └── datasources/     # API, local storage
└── features/
    └── [feature]/
        ├── domain/      # Feature-specific entities/usecases
        ├── data/        # Feature-specific repositories
        └── presentation/
```

---

## 🗑️ KULLANILMAYAN DOSYALAR

### Test Dosyaları (Potansiyel Silinebilir)
- `test/accessibility_compliance_test.dart`
- `test/button_hierarchy_bug_condition_test.dart`
- `test/bug_condition_exploration_test.dart`
- `test/button_preservation_property_test.dart`
- `test/preservation_property_test.dart`
- `test/visual_regression_test.dart`

**Aksiyon:** Kullanılıyorsa tut, değilse sil

### Utility Dosyaları
- `lib/core/utils/supabase_test.dart` - Debug/test kodu

**Aksiyon:** Production'dan kaldır

---

## 📈 ÖNCELİK MATRİSİ

### P0 (Kritik - Hemen)
1. ✅ Database schema uyumsuzluğu - **BLOCKER**
2. ✅ Enum duplikasyonu - Type safety
3. ✅ Memory leak - TextEditingController

### P1 (Yüksek - Bu Sprint)
4. ⚠️ TODO'ları tamamla (15+ adet)
5. ⚠️ Const constructors ekle
6. ⚠️ God widgets'ları böl
7. ⚠️ Backend functions oluştur

### P2 (Orta - Gelecek Sprint)
8. 📊 Magic numbers'ı constants'a çevir
9. 📊 Uzun metodları böl
10. 📊 Error handling standardize et
11. 📊 Dead code temizle

### P3 (Düşük - Backlog)
12. 📝 Domain layer ekle
13. 📝 Use case pattern implement et
14. 📝 Logging/monitoring ekle
15. 📝 Documentation yaz

---

## 🎯 DÜZELTME PLANI

### Hafta 1 (P0 - Kritik)
**Gün 1-2:**
- [ ] Database migration oluştur (schema update)
- [ ] Enum duplikasyonunu kaldır
- [ ] Memory leak'i düzelt

**Gün 3-5:**
- [ ] Migration'ı test et
- [ ] Tüm repository'leri test et
- [ ] Integration testleri çalıştır

### Hafta 2-3 (P1 - Yüksek)
**Hafta 2:**
- [ ] TODO'ları tamamla (navigation, typing indicator)
- [ ] Const constructors ekle
- [ ] Backend functions oluştur

**Hafta 3:**
- [ ] God widgets'ları böl (explore, chat, create)
- [ ] Performance profiling yap
- [ ] Optimizasyonları uygula

### Ay 1-2 (P2 - Orta)
**Ay 1:**
- [ ] Magic numbers'ı constants'a çevir
- [ ] Uzun metodları refactor et
- [ ] Error handling standardize et

**Ay 2:**
- [ ] Dead code temizle
- [ ] Code review yap
- [ ] Documentation güncelle

### Ay 3+ (P3 - Düşük)
- [ ] Domain layer ekle
- [ ] Use case pattern implement et
- [ ] Logging/monitoring ekle
- [ ] Comprehensive documentation

---

## 📊 SKOR DETAYI

### Kod Kalitesi: 7/10
- ✅ Temiz mimari (+2)
- ✅ Type-safe kod (+2)
- ✅ Freezed/Riverpod kullanımı (+2)
- ⚠️ God widgets (-1)
- ⚠️ Uzun metodlar (-1)
- ❌ Enum duplikasyonu (-1)

### Performans: 6/10
- ✅ Riverpod ile efficient state management (+2)
- ✅ Lazy loading (+1)
- ⚠️ Eksik const constructors (-2)
- ⚠️ God widgets (-1)
- ❌ Memory leak (-1)
- ⚠️ Client-side filtering (-1)

### Backend Uyumu: 4/10
- ❌ Schema uyumsuzluğu (-4)
- ❌ Eksik functions (-1)
- ❌ Eksik storage bucket (-1)
- ✅ RLS policies var (+2)
- ✅ Auth integration (+2)

### Güvenlik: 8/10
- ✅ RLS policies (+3)
- ✅ Auth required (+2)
- ✅ Input validation (+2)
- ⚠️ Error messages verbose (-1)

### Bakım Kolaylığı: 7/10
- ✅ Feature-based structure (+2)
- ✅ Consistent naming (+2)
- ✅ Type-safe (+1)
- ⚠️ Eksik documentation (-1)
- ⚠️ TODO'lar (-1)
- ⚠️ Dead code (-1)

---

## 🎯 SONUÇ

### Genel Skor: **6.5/10** ⚠️

**Yorum:**
Proje **orta-iyi** seviyede. Temiz mimari ve modern teknolojiler kullanılmış ama **kritik database uyumsuzluğu** production'ı engelliyor. P0 sorunlar çözülürse **8/10** seviyesine çıkabilir.

### Öneriler:
1. **Hemen:** Database schema'yı düzelt (BLOCKER)
2. **Bu Sprint:** Memory leak ve TODO'ları çöz
3. **Gelecek Sprint:** Performance optimizasyonları
4. **Uzun Vade:** Domain layer ve use cases ekle

### Deployment Durumu:
- 🔴 **Production:** HAZIR DEĞİL (schema uyumsuzluğu)
- 🟡 **Staging:** Hazır (test için)
- 🟢 **Development:** Hazır

---

**Hazırlayan:** Kiro AI Assistant  
**Tarih:** 13 Mayıs 2026  
**Versiyon:** 1.0.0  
**Durum:** Kapsamlı Analiz Tamamlandı
