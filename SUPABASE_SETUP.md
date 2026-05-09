# SAHADA - Supabase Setup Guide

Bu dokümantasyon SAHADA projesinin Supabase kurulum ve yapılandırma rehberidir.

## 📋 İçindekiler

1. [Supabase Projesi Oluşturma](#supabase-projesi-oluşturma)
2. [Environment Yapılandırması](#environment-yapılandırması)
3. [Authentication Ayarları](#authentication-ayarları)
4. [Database Migration](#database-migration)
5. [Storage Bucket Kurulumu](#storage-bucket-kurulumu)
6. [Flutter Entegrasyonu](#flutter-entegrasyonu)
7. [Güvenlik ve RLS](#güvenlik-ve-rls)

---

## 🚀 Supabase Projesi Oluşturma

### 1. Supabase Dashboard'a Git
- https://app.supabase.com adresine git
- "New Project" butonuna tıkla

### 2. Proje Bilgilerini Gir
- **Project Name**: `sahada`
- **Database Password**: Güçlü bir şifre oluştur (kaydet!)
- **Region**: En yakın bölgeyi seç (örn: Frankfurt)
- **Pricing Plan**: Free tier ile başla

### 3. Proje Oluşturulmasını Bekle
- Yaklaşık 2-3 dakika sürer
- Proje hazır olduğunda dashboard açılır

---

## 🔧 Environment Yapılandırması

### 1. API Credentials'ı Al

Supabase Dashboard'da:
- **Settings** > **API** sayfasına git
- Şu bilgileri kopyala:
  - `Project URL`
  - `anon public` key

### 2. .env Dosyası Oluştur

Proje root dizininde `.env` dosyası oluştur:

```bash
cp .env.example .env
```

### 3. .env Dosyasını Doldur

```env
# Environment
APP_ENV=development

# Supabase Configuration
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

⚠️ **ÖNEMLİ**: 
- `.env` dosyası Git'e commit edilmemelidir (zaten .gitignore'da)
- Sadece `.env.example` dosyası Git'e commit edilir
- Her geliştirici kendi `.env` dosyasını oluşturmalıdır

---

## 🔐 Authentication Ayarları

### 1. Email Authentication'ı Aktifleştir

Dashboard'da:
- **Authentication** > **Providers** > **Email**
- "Enable Email provider" ✅ Aktif

### 2. Development Ortamı İçin Email Confirmation'ı Kapat

- **Authentication** > **Settings**
- "Enable email confirmations" ❌ Kapalı (sadece dev için)

⚠️ **Production'da mutlaka açılmalı!**

### 3. Phone/SMS Authentication

- **Authentication** > **Providers** > **Phone**
- ❌ Kapalı (şimdilik kullanılmayacak)

### 4. Social Authentication (Opsiyonel)

Credential'lar hazır olduğunda:

#### Google OAuth
- **Authentication** > **Providers** > **Google**
- Client ID ve Client Secret gir
- ✅ Aktif

#### Apple OAuth
- **Authentication** > **Providers** > **Apple**
- Service ID, Team ID, Key ID gir
- ✅ Aktif

---

## 🗄️ Database Migration

### 1. İlk Migration'ı Çalıştır

Supabase Dashboard'da:
- **SQL Editor** > **New Query**
- `supabase/migrations/20260505000001_initial_setup.sql` dosyasının içeriğini kopyala
- Yapıştır ve **Run** butonuna tıkla

Bu migration şunları yapar:
- ✅ `uuid-ossp` extension'ı aktifleştirir
- ✅ `postgis` extension'ı aktifleştirir (geospatial data için)
- ✅ `update_updated_at_column()` trigger function'ı oluşturur

### 2. Migration Doğrulama

SQL Editor'da çalıştır:

```sql
-- Extensions kontrolü
SELECT * FROM pg_extension WHERE extname IN ('uuid-ossp', 'postgis');

-- Function kontrolü
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_name = 'update_updated_at_column';
```

### 3. Yeni Migration Ekleme

Yeni migration dosyası oluştur:
```
supabase/migrations/YYYYMMDDHHMMSS_description.sql
```

Örnek:
```sql
-- Create profiles table
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    username TEXT UNIQUE NOT NULL,
    full_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Public profiles are viewable by everyone"
ON profiles FOR SELECT
USING (true);

CREATE POLICY "Users can update own profile"
ON profiles FOR UPDATE
USING (auth.uid() = id);

-- Create trigger
CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
```

---

## 📦 Storage Bucket Kurulumu

### 1. Avatars Bucket Oluştur

Dashboard'da:
- **Storage** > **Create Bucket**
- **Bucket name**: `avatars`
- **Public bucket**: ✅ Aktif
- **File size limit**: 2097152 (2MB)
- **Allowed MIME types**: `image/jpeg,image/jpg,image/png,image/webp`
- **Create Bucket** butonuna tıkla

### 2. Storage Policies Ekle

**SQL Editor**'da çalıştır:

```sql
-- Users can upload their own avatar
CREATE POLICY "Users can upload their own avatar"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Users can update their own avatar
CREATE POLICY "Users can update their own avatar"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Users can delete their own avatar
CREATE POLICY "Users can delete their own avatar"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Public can view avatars
CREATE POLICY "Public can view avatars"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'avatars');
```

---

## 📱 Flutter Entegrasyonu

### 1. Dependencies Yükle

```bash
cd sahada_dev
flutter pub get
```

### 2. Proje Yapısı

```
lib/
├── core/
│   ├── config/
│   │   └── env_config.dart          # Environment yönetimi
│   └── services/
│       ├── supabase_service.dart    # Merkezi Supabase client
│       ├── auth_service.dart        # Authentication işlemleri
│       └── storage_service.dart     # Storage işlemleri
└── main.dart                        # App entry point
```

### 3. Kullanım Örnekleri

#### Authentication

```dart
import 'package:sahada_dev/core/services/auth_service.dart';

final authService = AuthService.instance;

// Sign up
await authService.signUpWithEmail(
  email: 'user@example.com',
  password: 'password123',
  metadata: {'username': 'johndoe'},
);

// Sign in
await authService.signInWithEmail(
  email: 'user@example.com',
  password: 'password123',
);

// Sign out
await authService.signOut();

// Check auth state
bool isAuthenticated = authService.isAuthenticated;
User? currentUser = authService.currentUser;
```

#### Storage

```dart
import 'package:sahada_dev/core/services/storage_service.dart';
import 'dart:io';

final storageService = StorageService.instance;

// Upload avatar
final file = File('path/to/image.jpg');
final avatarUrl = await storageService.uploadAvatar(
  userId: authService.currentUserId!,
  file: file,
);

// Get avatar URL
final url = storageService.getAvatarUrl('user-id/avatar.jpg');

// Delete avatar
await storageService.deleteAvatar('user-id/avatar.jpg');
```

#### Database

```dart
import 'package:sahada_dev/core/services/supabase_service.dart';

final supabase = SupabaseService.instance;

// Query
final response = await supabase.client
    .from('profiles')
    .select()
    .eq('id', userId)
    .single();

// Insert
await supabase.client
    .from('profiles')
    .insert({
      'id': userId,
      'username': 'johndoe',
      'full_name': 'John Doe',
    });

// Update
await supabase.client
    .from('profiles')
    .update({'full_name': 'Jane Doe'})
    .eq('id', userId);

// Delete
await supabase.client
    .from('profiles')
    .delete()
    .eq('id', userId);
```

---

## 🔒 Güvenlik ve RLS

### Row Level Security (RLS) Kuralları

⚠️ **ZORUNLU**: Tüm tablolarda RLS aktif olmalıdır!

### RLS Best Practices

1. **Her tablo için RLS aktif et**
```sql
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
```

2. **Minimum yetki prensibi**
- Kullanıcılar sadece kendi verilerine erişebilmeli
- Public veriler için ayrı policy oluştur

3. **Policy örnekleri**

```sql
-- Kullanıcı sadece kendi kaydını görebilir
CREATE POLICY "Users can view own record"
ON table_name FOR SELECT
USING (auth.uid() = user_id);

-- Kullanıcı sadece kendi kaydını güncelleyebilir
CREATE POLICY "Users can update own record"
ON table_name FOR UPDATE
USING (auth.uid() = user_id);

-- Herkes public kayıtları görebilir
CREATE POLICY "Public records are viewable"
ON table_name FOR SELECT
USING (is_public = true);
```

### Security Checklist

- [ ] Tüm tablolarda RLS aktif
- [ ] Her tablo için uygun policy'ler tanımlanmış
- [ ] Storage bucket'lar için policy'ler tanımlanmış
- [ ] Production'da email confirmation aktif
- [ ] API keys güvenli saklanıyor (.env)
- [ ] Service role key asla client'ta kullanılmıyor

---

## 🧪 Test ve Doğrulama

### 1. Flutter Uygulamasını Çalıştır

```bash
flutter run
```

Ana ekranda şunları görmelisin:
- ✅ "SAHADA" başlığı
- ✅ "Supabase Ready" mesajı
- ✅ "Environment: development" bilgisi

### 2. Supabase Bağlantısını Test Et

```dart
// Test kodu
final supabase = SupabaseService.instance;
print('Supabase connected: ${supabase.client.auth.currentUser}');
```

### 3. Authentication Test

```dart
// Sign up test
try {
  final response = await AuthService.instance.signUpWithEmail(
    email: 'test@example.com',
    password: 'test123456',
  );
  print('Sign up success: ${response.user?.email}');
} catch (e) {
  print('Sign up error: $e');
}
```

---

## 🚨 Sorun Giderme

### "SUPABASE_URL not found" hatası
- `.env` dosyasının proje root'unda olduğundan emin ol
- `flutter pub get` komutunu çalıştır
- Uygulamayı yeniden başlat

### "Invalid API key" hatası
- `.env` dosyasındaki `SUPABASE_ANON_KEY` değerini kontrol et
- Supabase Dashboard'dan doğru key'i kopyaladığından emin ol
- Service role key değil, anon key kullanmalısın

### Migration çalışmıyor
- SQL syntax hatalarını kontrol et
- Supabase Dashboard > SQL Editor'da hata mesajını oku
- Extension'ların yüklü olduğunu doğrula

### Storage upload hatası
- Bucket'ın oluşturulduğunu kontrol et
- Storage policies'in tanımlandığını doğrula
- Dosya boyutunun limit içinde olduğunu kontrol et

---

## 📚 Kaynaklar

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Flutter SDK](https://supabase.com/docs/reference/dart/introduction)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)
- [Storage](https://supabase.com/docs/guides/storage)

---

## 📝 Notlar

- Bu setup development ortamı içindir
- Production'a geçmeden önce güvenlik ayarlarını gözden geçir
- Email confirmation production'da mutlaka aktif olmalı
- API keys'i asla Git'e commit etme
- Düzenli olarak Supabase güncellemelerini takip et

---

**Son Güncelleme**: 5 Mayıs 2026
**Versiyon**: 1.0.0
