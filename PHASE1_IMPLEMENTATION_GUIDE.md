# 🔥 PHASE 1 IMPLEMENTATION GUIDE

**Tarih:** 13 Mayıs 2026  
**Durum:** 🟡 IN PROGRESS

---

## ✅ TAMAMLANAN İŞLER

### 1. Backend Migration Dosyası Oluşturuldu
**Dosya:** `supabase/migrations/20260513000003_phase1_critical_fixes.sql`

**İçerik:**
- ✅ `participations` tablosuna `agreed_amount` kolonu eklendi
- ✅ `offers` tablosu model'e uyarlandı (kolon isimleri değişti)
- ✅ `chats` tablosuna `match_id` kolonu eklendi
- ✅ `users` tablosuna eksik kolonlar eklendi (11 kolon)
- ✅ `nearby_players` RPC fonksiyonu oluşturuldu
- ✅ `applications` tablosu kaldırıldı
- ✅ `invitations` ve `ratings` tabloları kaldırıldı
- ✅ RLS politikaları güncellendi
- ✅ Trigger'lar eklendi
- ✅ Offer expiration mekanizması eklendi
- ✅ Indexler güncellendi
- ✅ Validation constraint'ler eklendi

### 2. Repository Error Handling (Kısmen Tamamlandı)
**Dosya:** `lib/data/repositories/match_listings_repository.dart`

**Yapılan:**
- ✅ Import'lar eklendi (ErrorHandler, AppException)
- ✅ `create()` method'una try-catch eklendi
- ✅ Tüm method'lara try-catch eklendi (13 method)

---

## 🔄 DEVAM EDEN İŞLER

### 3. Kalan Repository Dosyalarına Error Handling Ekle

#### A. player_listings_repository.dart (9 method)
```dart
// Eklenecek import'lar:
import '../../core/errors/error_handler.dart';
import '../../core/errors/app_exception.dart';

// Her method'a try-catch ekle:
try {
  // mevcut kod
} catch (e, stackTrace) {
  throw ErrorHandler.handleError(e, stackTrace);
}
```

#### B. users_repository.dart (6 method)
- `getCurrentUser()`
- `getUserById()`
- `updateProfile()`
- `getUserProfile()`
- `upsertUserProfile()`
- `getUserStats()`

#### C. offers_repository.dart (9 method)
- `create()`
- `getMyOffers()`
- `getOne()`
- `counter()`
- `accept()`
- `reject()`
- `updateStatus()`
- `getOffersForMatch()`
- `getOffersForPlayer()`

#### D. participations_repository.dart (4 method)
- `getMyParticipations()`
- `leave()`
- `getParticipationsForMatch()`
- `isParticipating()`

#### E. notifications_repository.dart (6 method)
- `getMyNotifications()`
- `getMyNotificationsStream()`
- `markAsRead()`
- `markAllAsRead()`
- `delete()`
- `getUnreadCount()`

#### F. reviews_repository.dart (4 method)
- `create()`
- `getUserReviews()`
- `getMatchReviews()`
- `hasReviewed()`

#### G. reports_repository.dart (4 method)
- `create()`
- `getMyReports()`
- `getAllReports()`
- `updateStatus()`

#### H. auth_repository.dart
- Tüm method'lara error handling ekle

---

## 📋 YAPILACAK İŞLER

### 4. applications_repository.dart'ı Kaldır
**Dosya:** `lib/data/repositories/applications_repository.dart`

**Aksiyon:**
```bash
# Dosyayı sil
rm lib/data/repositories/applications_repository.dart
rm lib/data/repositories/applications_repository.g.dart

# Kullanıldığı yerleri bul ve participations_repository ile değiştir
grep -r "applicationsRepository" lib/
grep -r "ApplicationsRepository" lib/
```

### 5. Model Dosyalarını Güncelle

#### A. participation_model.dart
**Mevcut:**
```dart
@JsonKey(name: 'agreed_amount') required int agreedAmount,
```

**Durum:** ✅ Backend'e kolon eklendi, model doğru

#### B. offer_model.dart
**Mevcut:**
```dart
@JsonKey(name: 'from_user_id') required String fromUserId,
@JsonKey(name: 'to_user_id') required String toUserId,
@JsonKey(name: 'match_listing_id') String? matchListingId,
@JsonKey(name: 'player_listing_id') String? playerListingId,
```

**Durum:** ✅ Backend güncellendi, model doğru

#### C. chat_model.dart
**Mevcut:**
```dart
@JsonKey(name: 'match_id') String? matchId,
```

**Durum:** ✅ Backend'e kolon eklendi, model doğru

#### D. user_model.dart
**Mevcut:**
```dart
required String phone,
String? email,
@JsonKey(name: 'phone_verified_at') DateTime? phoneVerifiedAt,
// ... 11 alan daha
```

**Durum:** ✅ Backend'e kolonlar eklendi, model doğru

### 6. Freezed Dosyalarını Yeniden Oluştur
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Beklenen Sonuç:**
- ✅ JsonKey uyarıları kaybolacak
- ✅ .freezed.dart dosyaları güncellenecek
- ✅ .g.dart dosyaları güncellenecek

### 7. Migration'ı Çalıştır

#### Supabase CLI ile:
```bash
# Migration'ı çalıştır
supabase db push

# Veya manuel olarak:
# 1. Supabase Dashboard > SQL Editor
# 2. 20260513000003_phase1_critical_fixes.sql dosyasını aç
# 3. Run
```

#### Backup Al (ÖNEMLİ!):
```bash
# Supabase Dashboard > Database > Backups
# "Create Backup" butonuna tıkla
```

### 8. Test Et

#### A. Backend Testleri:
```sql
-- participations tablosunu test et
SELECT * FROM participations LIMIT 1;
-- agreed_amount kolonu var mı?

-- offers tablosunu test et
SELECT * FROM offers LIMIT 1;
-- from_user_id, to_user_id, match_listing_id kolonları var mı?

-- chats tablosunu test et
SELECT * FROM chats LIMIT 1;
-- match_id kolonu var mı?

-- users tablosunu test et
SELECT * FROM users LIMIT 1;
-- phone, phone_verified_at, birth_year, vb. kolonlar var mı?

-- RPC fonksiyonunu test et
SELECT * FROM nearby_players(41.0082, 28.9784, 10);
-- Sonuç dönüyor mu?

-- Kaldırılan tabloları kontrol et
SELECT * FROM applications; -- HATA vermeli
SELECT * FROM invitations; -- HATA vermeli
SELECT * FROM ratings; -- HATA vermeli
```

#### B. Flutter Testleri:
```bash
# Build runner çalıştır
flutter pub run build_runner build --delete-conflicting-outputs

# Uygulamayı çalıştır
flutter run

# Test et:
# 1. Maç oluştur (match_listings_repository)
# 2. Yakındaki maçları ara (nearby_matches RPC)
# 3. Teklif gönder (offers_repository)
# 4. Maça katıl (participations_repository)
# 5. Profil güncelle (users_repository)
```

---

## 🐛 OLASI SORUNLAR VE ÇÖZÜMLER

### Sorun 1: Migration Hatası
**Hata:** `column "agreed_amount" already exists`

**Çözüm:**
```sql
-- Migration'da zaten IF NOT EXISTS var, sorun olmamalı
-- Ama olursa:
ALTER TABLE participations DROP COLUMN IF EXISTS agreed_amount;
-- Sonra migration'ı tekrar çalıştır
```

### Sorun 2: Mevcut Data Uyumsuzluğu
**Hata:** `null value in column "phone" violates not-null constraint`

**Çözüm:**
```sql
-- Migration'da zaten handle ediliyor:
UPDATE users SET phone = email WHERE phone IS NULL;
```

### Sorun 3: Freezed Build Hatası
**Hata:** `The annotation 'JsonKey.new' can only be used on fields or getters`

**Çözüm:**
```bash
# Önce clean yap
flutter clean
flutter pub get

# Sonra build runner çalıştır
flutter pub run build_runner build --delete-conflicting-outputs
```

### Sorun 4: RPC Fonksiyonu Bulunamadı
**Hata:** `function nearby_players does not exist`

**Çözüm:**
```sql
-- Migration'ı kontrol et, fonksiyon oluşturulmuş mu?
SELECT proname FROM pg_proc WHERE proname = 'nearby_players';

-- Yoksa manuel oluştur:
-- (migration dosyasındaki CREATE FUNCTION kısmını çalıştır)
```

---

## 📊 İLERLEME DURUMU

### Tamamlanan: 2/8 (%25)
- [x] 1. Backend Migration Dosyası Oluşturuldu
- [x] 2. match_listings_repository.dart Error Handling Eklendi
- [ ] 3. Kalan 7 Repository'ye Error Handling Ekle
- [ ] 4. applications_repository.dart'ı Kaldır
- [ ] 5. Model Dosyalarını Kontrol Et
- [ ] 6. Freezed Dosyalarını Yeniden Oluştur
- [ ] 7. Migration'ı Çalıştır
- [ ] 8. Test Et

---

## 🎯 SONRAKI ADIMLAR

### Hemen Yapılacaklar:
1. **Kalan repository dosyalarına error handling ekle** (30 dakika)
2. **applications_repository.dart'ı kaldır** (5 dakika)
3. **Freezed dosyalarını yeniden oluştur** (2 dakika)
4. **Migration'ı çalıştır** (5 dakika)
5. **Test et** (15 dakika)

**Toplam Süre:** ~1 saat

### Sonra Yapılacaklar (PHASE 2):
- God widget'ları refactor et
- Performans iyileştirmeleri yap
- Test coverage artır

---

## 📝 NOTLAR

### Önemli Değişiklikler:
1. **offers tablosu:** Kolon isimleri değişti
   - `match_id` → `match_listing_id`
   - `player_id` → `from_user_id`
   - `organizer_id` → `to_user_id`

2. **applications tablosu:** Kaldırıldı
   - Artık `participations` kullanılıyor

3. **invitations ve ratings:** Kaldırıldı
   - Kullanılmıyordu

4. **users tablosu:** 11 yeni kolon eklendi
   - `phone` artık required

### Breaking Changes:
- ⚠️ Mevcut offer'lar çalışmayabilir (kolon isimleri değişti)
- ⚠️ applications_repository kullanan kod çalışmayacak
- ⚠️ users.phone NULL olamaz artık

### Migration Sonrası Yapılacaklar:
1. Mevcut offer'ları kontrol et
2. applications kullanan kodu bul ve düzelt
3. users.phone NULL olanları düzelt

---

**Hazırlayan:** Kiro AI Assistant  
**Tarih:** 13 Mayıs 2026  
**Durum:** 🟡 IN PROGRESS (2/8 tamamlandı)

