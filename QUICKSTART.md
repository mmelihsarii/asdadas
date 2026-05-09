# SAHADA - Quick Start Guide

5 dakikada SAHADA projesini çalıştır! 🚀

## 📋 Ön Hazırlık

- [ ] Flutter SDK yüklü (3.10.7+)
- [ ] Supabase hesabı var
- [ ] Git yüklü

## ⚡ Hızlı Kurulum (5 Dakika)

### 1️⃣ Supabase Projesi Oluştur (2 dk)

1. https://app.supabase.com adresine git
2. "New Project" → Proje adı: `sahada`
3. Database password oluştur ve kaydet
4. Region seç → "Create Project"
5. Proje hazır olana kadar bekle (~2 dk)

### 2️⃣ Credentials Al (30 sn)

1. Supabase Dashboard → **Settings** → **API**
2. Kopyala:
   - `Project URL`
   - `anon public` key

### 3️⃣ Flutter Projesini Hazırla (1 dk)

```bash
# Dependencies yükle
cd sahada_dev
flutter pub get

# Environment dosyası oluştur
cp .env.example .env
```

### 4️⃣ .env Dosyasını Düzenle (30 sn)

`.env` dosyasını aç ve credentials'ları yapıştır:

```env
APP_ENV=development
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 5️⃣ Supabase'i Yapılandır (1 dk)

#### Email Auth Aktifleştir
1. Dashboard → **Authentication** → **Providers** → **Email**
2. "Enable Email provider" ✅

#### Email Confirmation Kapat (sadece dev)
1. **Authentication** → **Settings**
2. "Enable email confirmations" ❌

#### İlk Migration'ı Çalıştır
1. Dashboard → **SQL Editor** → **New Query**
2. `supabase/migrations/20260505000001_initial_setup.sql` içeriğini kopyala
3. Yapıştır → **Run**

#### Avatars Bucket Oluştur
1. Dashboard → **Storage** → **Create Bucket**
2. Name: `avatars`
3. Public: ✅
4. **Create**

#### Storage Policies Ekle
1. **SQL Editor** → **New Query**
2. `supabase/storage/avatars_policies.sql` içeriğini kopyala
3. Yapıştır → **Run**

### 6️⃣ Uygulamayı Çalıştır (30 sn)

```bash
flutter run
```

## ✅ Başarı Kontrolü

Uygulama açıldığında şunları görmelisin:

- ⚽ Futbol topu ikonu
- "SAHADA" başlığı
- "Supabase Ready" yeşil yazı
- "Environment: development" bilgisi

## 🎉 Tebrikler!

SAHADA projesi Supabase ile hazır! Artık şunları yapabilirsin:

### Hemen Test Et

```dart
// Authentication test
final auth = AuthService.instance;

// Sign up
await auth.signUpWithEmail(
  email: 'test@example.com',
  password: 'test123456',
);

// Check user
print(auth.currentUser?.email); // test@example.com
```

## 📚 Sonraki Adımlar

1. **Detaylı Kurulum**: [SUPABASE_SETUP.md](SUPABASE_SETUP.md)
2. **Checklist**: [SUPABASE_CHECKLIST.md](SUPABASE_CHECKLIST.md)
3. **Proje Yapısı**: [README.md](README.md)

## 🚨 Sorun mu var?

### "SUPABASE_URL not found"
```bash
# .env dosyasının doğru yerde olduğundan emin ol
ls -la .env

# Pub get yap
flutter pub get

# Uygulamayı yeniden başlat
flutter run
```

### "Invalid API key"
- `.env` dosyasında `SUPABASE_ANON_KEY` değerini kontrol et
- Supabase Dashboard'dan tekrar kopyala
- **Service role key değil, anon key kullan!**

### Migration hatası
- SQL syntax'ı kontrol et
- Supabase Dashboard'da hata mesajını oku
- Extension'ların yüklendiğini doğrula

## 💡 İpuçları

- Development'ta email confirmation kapalı, hemen giriş yapabilirsin
- `.env` dosyası Git'e commit edilmez
- Her geliştirici kendi `.env` dosyasını oluşturmalı
- Production'a geçmeden email confirmation'ı aç

---

**Kurulum Süresi**: ~5 dakika
**Zorluk**: Kolay
**Versiyon**: 1.0.0

Başarılar! 🚀
