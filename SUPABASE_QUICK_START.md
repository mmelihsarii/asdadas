# 🚀 Supabase Hızlı Başlangıç

## ✅ Yapılandırma Tamamlandı!

Projeniz Supabase ile entegre edildi. İşte yapılanlar:

### 1. Environment Ayarları
```env
SUPABASE_URL=https://yyqgomrvjudzduqxdsht.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 2. Veritabanı Şeması
- ✅ 9 tablo (users, player_profiles, match_posts, vb.)
- ✅ 4 enum tipi
- ✅ Row Level Security (RLS) politikaları
- ✅ Mock data hazır

### 3. Kod Yapısı
- ✅ `SupabaseService` - Singleton servis
- ✅ `AuthService` - Authentication işlemleri
- ✅ `AuthRepository` - Auth repository pattern
- ✅ `SupabaseTest` - Bağlantı test utility'si
- ✅ Repository'ler (users, reviews, reports, vb.)

## 🎯 Şimdi Ne Yapmalısın?

### Adım 1: Migration'ı Çalıştır

**Seçenek A: Supabase CLI (Önerilen)**
```bash
cd c:\Users\ahmtm\Desktop\sahada-main\sahada-main
supabase db reset
```

**Seçenek B: Supabase Dashboard**
1. https://app.supabase.com/project/yyqgomrvjudzduqxdsht adresine git
2. SQL Editor'ü aç
3. `supabase/migrations/20260505000001_initial_setup.sql` dosyasını kopyala
4. SQL Editor'e yapıştır ve çalıştır

### Adım 2: Bağlantıyı Test Et

`lib/main.dart` dosyasında test satırını aktif et:

```dart
// Bu satırın yorumunu kaldır:
await SupabaseTest.runAllTests();
```

Sonra uygulamayı çalıştır:
```bash
flutter run
```

Console'da şu çıktıyı görmelisin:
```
🧪 SUPABASE ENTEGRASYON TESTLERİ
✅ Supabase bağlantısı başarılı!
✅ users tablosu erişilebilir
👥 Kullanıcı sayısı: 5
⚽ Maç ilanı sayısı: 4
```

### Adım 3: Auth'u Production Moduna Al

`lib/features/auth/application/login_notifier.dart` dosyasında:

**Şu anki durum (DEV MODE):**
```dart
// Mock OTP kodu: 123456
final mockOtpCode = '123456';
```

**Production için:**
```dart
// Bu satırı aktif et:
await _authService.signInWithEmailOtp(state.email.trim().toLowerCase());

// Mock kod satırlarını kaldır
```

## 📱 Kullanım Örnekleri

### Auth İşlemleri

```dart
// Email ile giriş
final authRepo = ref.read(authRepositoryProvider);
await authRepo.signInWithEmailOtp('user@example.com');

// OTP doğrulama
await authRepo.verifyEmailOtp(
  email: 'user@example.com',
  token: '123456',
);

// Çıkış
await authRepo.signOut();
```

### Database İşlemleri

```dart
// Kullanıcıları listele
final usersRepo = ref.read(usersRepositoryProvider);
final users = await usersRepo.getAllUsers();

// Maç ilanlarını getir
final matchesRepo = ref.read(matchListingsRepositoryProvider);
final matches = await matchesRepo.search(
  city: 'İstanbul',
  district: 'Kadıköy',
);

// Başvuru yap
final applicationsRepo = ref.read(applicationsRepositoryProvider);
await applicationsRepo.create({
  'post_id': matchId,
  'player_id': userId,
});
```

### Realtime Subscriptions

```dart
// Bildirimleri dinle
final _supabase = SupabaseService.instance.client;

_supabase
  .from('notifications')
  .stream(primaryKey: ['id'])
  .eq('user_id', currentUserId)
  .listen((data) {
    print('Yeni bildirim: $data');
  });
```

## 🔐 Mock Data Kullanıcıları

Test için hazır kullanıcılar:

| Email | Rol | Şehir | İlçe |
|-------|-----|-------|------|
| ahmet@example.com | organizer | İstanbul | Kadıköy |
| mehmet@example.com | organizer | İstanbul | Beşiktaş |
| ali@example.com | player | İstanbul | Kadıköy |
| veli@example.com | player | İstanbul | Beşiktaş |
| can@example.com | player | İstanbul | Şişli |

**DEV MODE OTP Kodu:** `123456`

## 🐛 Sorun Giderme

### "Invalid API key" hatası
```bash
flutter clean
flutter pub get
```

### "Table does not exist" hatası
Migration'ı çalıştırmayı unutmuşsun. Adım 1'e dön.

### Auth çalışmıyor
Supabase Dashboard > Authentication > Settings:
- "Enable email confirmations" kapalı olmalı (development için)

## 📚 Daha Fazla Bilgi

- [SUPABASE_SETUP.md](./SUPABASE_SETUP.md) - Detaylı kurulum rehberi
- [Supabase Dashboard](https://app.supabase.com/project/yyqgomrvjudzduqxdsht)
- [Supabase Flutter Docs](https://supabase.com/docs/reference/dart/introduction)

## ✨ Sonraki Adımlar

1. ✅ Migration'ı çalıştır
2. ✅ Bağlantıyı test et
3. ✅ İlk kullanıcıyı oluştur
4. 🚀 Geliştirmeye başla!

---

**Hazırsın! 🎉**
