# SAHADA - Supabase Setup Checklist

Bu checklist'i kullanarak Supabase kurulumunun tamamlandığından emin olun.

## ✅ Supabase Dashboard Kurulumu

### 1. Proje Oluşturma
- [ ] Supabase'de yeni proje oluşturuldu (proje adı: `sahada`)
- [ ] Database password kaydedildi
- [ ] Proje region seçildi
- [ ] Proje başarıyla oluşturuldu

### 2. API Credentials
- [ ] Project URL kopyalandı
- [ ] Anon public key kopyalandı
- [ ] `.env` dosyası oluşturuldu
- [ ] Credentials `.env` dosyasına eklendi

## ✅ Authentication Ayarları

### Email Authentication
- [ ] Email provider aktifleştirildi
- [ ] Development için email confirmation kapatıldı
- [ ] ⚠️ Production'da email confirmation açılacak (not alındı)

### Phone/SMS Authentication
- [ ] Phone/SMS authentication kapalı (şimdilik kullanılmayacak)

### Social Authentication (Opsiyonel)
- [ ] Google OAuth credentials hazırsa aktifleştirildi
- [ ] Apple OAuth credentials hazırsa aktifleştirildi
- [ ] Veya daha sonra aktifleştirilmek üzere not alındı

## ✅ Database Migration

### İlk Migration
- [ ] `20260505000001_initial_setup.sql` SQL Editor'da çalıştırıldı
- [ ] `uuid-ossp` extension aktif
- [ ] `postgis` extension aktif
- [ ] `update_updated_at_column()` function oluşturuldu

### Migration Doğrulama
```sql
-- Bu sorguları çalıştırarak doğrula:
SELECT * FROM pg_extension WHERE extname IN ('uuid-ossp', 'postgis');
SELECT routine_name FROM information_schema.routines WHERE routine_name = 'update_updated_at_column';
```
- [ ] Extensions doğrulandı
- [ ] Function doğrulandı

## ✅ Storage Bucket Kurulumu

### Avatars Bucket
- [ ] `avatars` bucket oluşturuldu
- [ ] Public bucket olarak ayarlandı
- [ ] File size limit: 2MB (2097152 bytes)
- [ ] Allowed MIME types: `image/jpeg,image/jpg,image/png,image/webp`

### Storage Policies
- [ ] `avatars_policies.sql` SQL Editor'da çalıştırıldı
- [ ] "Users can upload their own avatar" policy oluşturuldu
- [ ] "Users can update their own avatar" policy oluşturuldu
- [ ] "Users can delete their own avatar" policy oluşturuldu
- [ ] "Public can view avatars" policy oluşturuldu

### Storage Doğrulama
- [ ] Storage > avatars bucket görünüyor
- [ ] Policies sekmesinde 4 policy görünüyor

## ✅ Flutter Entegrasyonu

### Dependencies
- [ ] `flutter pub get` çalıştırıldı
- [ ] `supabase_flutter` yüklendi
- [ ] `flutter_dotenv` yüklendi

### Environment
- [ ] `.env` dosyası assets'e eklendi (pubspec.yaml)
- [ ] `.env` dosyası .gitignore'da
- [ ] `.env.example` Git'e commit edildi

### Kod Yapısı
- [ ] `lib/core/config/env_config.dart` oluşturuldu
- [ ] `lib/core/services/supabase_service.dart` oluşturuldu
- [ ] `lib/core/services/auth_service.dart` oluşturuldu
- [ ] `lib/core/services/storage_service.dart` oluşturuldu
- [ ] `lib/main.dart` güncellendi

### Test
- [ ] `flutter run` çalıştırıldı
- [ ] Uygulama başarıyla açıldı
- [ ] "Supabase Ready" mesajı görünüyor
- [ ] Environment bilgisi doğru görünüyor

## ✅ Güvenlik

### Row Level Security (RLS)
- [ ] RLS kuralları anlaşıldı
- [ ] Gelecek tablolarda RLS zorunlu olacak (not alındı)
- [ ] Storage policies aktif

### Environment Security
- [ ] `.env` dosyası Git'e commit edilmedi
- [ ] Sadece `.env.example` Git'e commit edildi
- [ ] API keys güvenli saklanıyor

### Production Hazırlık
- [ ] Email confirmation production'da açılacak (not alındı)
- [ ] Service role key asla client'ta kullanılmayacak (not alındı)
- [ ] RLS tüm tablolarda zorunlu (not alındı)

## ✅ Dokümantasyon

- [ ] `README.md` okundu
- [ ] `SUPABASE_SETUP.md` okundu
- [ ] `supabase/migrations/README.md` okundu
- [ ] `supabase/storage/README.md` okundu

## 🎯 Sonraki Adımlar

### Hemen Yapılacaklar
1. [ ] İlk test kullanıcısı oluştur
2. [ ] Authentication flow'u test et
3. [ ] Avatar upload test et

### Yakında Yapılacaklar
1. [ ] Profiles tablosu migration'ı oluştur
2. [ ] User profile CRUD işlemleri
3. [ ] Saha (field) tablosu ve migration
4. [ ] Rezervasyon sistemi tabloları

### Production Öncesi
1. [ ] Email confirmation aktifleştir
2. [ ] Rate limiting ayarla
3. [ ] Backup stratejisi belirle
4. [ ] Monitoring kur
5. [ ] Error tracking ekle

## 📊 Kurulum Durumu

**Toplam İlerleme**: ___/60

**Kategoriler**:
- Supabase Dashboard: ___/10
- Authentication: ___/7
- Database: ___/6
- Storage: ___/9
- Flutter: ___/10
- Güvenlik: ___/8
- Dokümantasyon: ___/4
- Test: ___/6

---

## 🚨 Sorun mu var?

Herhangi bir adımda sorun yaşıyorsan:

1. `SUPABASE_SETUP.md` dosyasındaki "Sorun Giderme" bölümüne bak
2. Supabase Dashboard'da hata loglarını kontrol et
3. Flutter console'da hata mesajlarını oku
4. Gerekirse Supabase documentation'a başvur

---

**Son Güncelleme**: 5 Mayıs 2026
**Versiyon**: 1.0.0

✨ **Başarılar!** Tüm adımları tamamladıktan sonra SAHADA projesi Supabase ile hazır olacak.
