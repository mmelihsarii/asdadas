# 🚀 Supabase Entegrasyon Rehberi

## ✅ Tamamlanan Adımlar

### 1. Environment Yapılandırması
- ✅ `.env` dosyasında `SUPABASE_URL` ve `SUPABASE_ANON_KEY` tanımlandı
- ✅ URL düzeltildi: `/rest/v1/` kısmı kaldırıldı (Supabase SDK otomatik ekler)

### 2. Veritabanı Şeması
- ✅ Migration dosyası oluşturuldu: `supabase/migrations/20260505000001_initial_setup.sql`
- ✅ 9 tablo tanımlandı (users, player_profiles, match_posts, vb.)
- ✅ 4 enum tipi oluşturuldu
- ✅ Row Level Security (RLS) politikaları eklendi
- ✅ Mock data hazırlandı

### 3. Kod Yapısı
- ✅ `SupabaseService` singleton servisi mevcut
- ✅ `AuthService` authentication işlemleri için hazır
- ✅ Repository pattern kullanılıyor (users, reviews, reports, vb.)
- ✅ Riverpod state management entegre

## 🔧 Yapılması Gerekenler

### 1. Migration'ı Çalıştır
```bash
# Supabase CLI ile migration'ı uygula
supabase db reset

# Veya Supabase Dashboard'dan SQL Editor'de çalıştır
# supabase/migrations/20260505000001_initial_setup.sql dosyasını kopyala-yapıştır
```

### 2. Auth Servisini Aktif Et
Şu anda `login_notifier.dart` dosyasında auth servisi **DEV MODE**'da çalışıyor:
- Mock OTP kodu: `123456`
- Gerçek Supabase auth çağrıları yorum satırında

**Production'a geçmek için:**

`lib/features/auth/application/login_notifier.dart` dosyasında:

```dart
// Bu satırları aktif et:
await _authService.signInWithEmailOtp(state.email.trim().toLowerCase());

// Ve mock kod satırlarını kaldır:
// final mockOtpCode = '123456';
```

### 3. Auth Repository Oluştur (Önerilen)
Şu anda auth işlemleri doğrudan `AuthService` üzerinden yapılıyor. Daha iyi bir yapı için:

```dart
// lib/data/repositories/auth_repository.dart
class AuthRepository {
  final _supabase = SupabaseService.instance.client;
  
  Future<void> signUpWithEmail(String email, String password, Map<String, dynamic> userData) async {
    // 1. Supabase auth ile kayıt
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );
    
    // 2. users tablosuna profil bilgilerini ekle
    await _supabase.from('users').insert({
      'id': response.user!.id,
      'email': email,
      'name': userData['name'],
      'role': userData['role'],
      'city': userData['city'],
      'district': userData['district'],
    });
  }
}
```

### 4. Realtime Subscriptions (Opsiyonel)
Bildirimler ve mesajlar için realtime dinleme:

```dart
// Bildirimleri dinle
_supabase
  .from('notifications')
  .stream(primaryKey: ['id'])
  .eq('user_id', currentUserId)
  .listen((data) {
    // Yeni bildirim geldi
  });
```

### 5. Storage Yapılandırması (Avatar/Resim Yükleme)
Supabase Dashboard'dan:
1. Storage > Create Bucket: `avatars`
2. Policies > New Policy: Public read, authenticated write

```dart
// Avatar yükleme
Future<String> uploadAvatar(File file) async {
  final userId = SupabaseService.instance.currentUserId;
  final path = 'avatars/$userId.jpg';
  
  await _supabase.storage
    .from('avatars')
    .upload(path, file, fileOptions: FileOptions(upsert: true));
  
  return _supabase.storage.from('avatars').getPublicUrl(path);
}
```

## 📋 Kontrol Listesi

- [x] .env dosyası yapılandırıldı
- [x] Supabase URL ve Key eklendi
- [x] Migration dosyası hazırlandı
- [ ] Migration çalıştırıldı (Supabase Dashboard'dan)
- [ ] Auth servisi production moduna alındı
- [ ] İlk test kullanıcısı oluşturuldu
- [ ] Storage bucket'ları oluşturuldu
- [ ] RLS politikaları test edildi

## 🧪 Test Etme

### 1. Bağlantı Testi
```dart
// main.dart'ta zaten var:
await SupabaseService.initialize();
print('Supabase bağlantısı başarılı!');
```

### 2. Auth Testi
```dart
// Login screen'de email ile giriş yap
// OTP kodu: 123456 (DEV MODE)
```

### 3. Database Testi
```dart
// Kullanıcıları listele
final users = await _supabase.from('users').select();
print('Kullanıcı sayısı: ${users.length}');
```

## 🔐 Güvenlik Notları

1. **RLS Politikaları**: Tüm tablolarda aktif
2. **Auth Trigger**: Yeni kullanıcı kaydında otomatik `users` tablosuna ekleme
3. **API Keys**: 
   - `SUPABASE_ANON_KEY`: Client-side için güvenli
   - Service role key'i **asla** client-side'da kullanma

## 📚 Faydalı Linkler

- [Supabase Dashboard](https://app.supabase.com/project/yyqgomrvjudzduqxdsht)
- [Supabase Flutter Docs](https://supabase.com/docs/reference/dart/introduction)
- [Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)

## 🐛 Sorun Giderme

### "Invalid API key" hatası
- `.env` dosyasındaki key'i kontrol et
- `flutter clean` ve `flutter pub get` çalıştır

### "Table does not exist" hatası
- Migration'ı çalıştırmayı unutmuş olabilirsin
- Supabase Dashboard > SQL Editor'den migration'ı çalıştır

### Auth çalışmıyor
- Email confirmation ayarlarını kontrol et
- Supabase Dashboard > Authentication > Settings
- "Enable email confirmations" kapalı olmalı (development için)
