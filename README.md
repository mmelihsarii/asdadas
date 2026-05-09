# SAHADA

Futbol sahası rezervasyon ve yönetim uygulaması.

## 🚀 Başlangıç

### Gereksinimler

- Flutter SDK (3.10.7 veya üzeri)
- Dart SDK
- Supabase hesabı
- iOS: Xcode 14+
- Android: Android Studio

### Kurulum

1. **Repository'yi klonla**
```bash
git clone <repository-url>
cd sahada_dev
```

2. **Dependencies yükle**
```bash
flutter pub get
```

3. **Environment yapılandırması**
```bash
cp .env.example .env
```

`.env` dosyasını düzenle ve Supabase credentials'larını ekle:
```env
APP_ENV=development
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

4. **Supabase kurulumu**

Detaylı kurulum için [SUPABASE_SETUP.md](SUPABASE_SETUP.md) dosyasına bakın.

5. **Uygulamayı çalıştır**
```bash
flutter run
```

## 📁 Proje Yapısı

```
sahada_dev/
├── lib/
│   ├── core/
│   │   ├── config/
│   │   │   └── env_config.dart          # Environment yönetimi
│   │   └── services/
│   │       ├── supabase_service.dart    # Merkezi Supabase client
│   │       ├── auth_service.dart        # Authentication
│   │       └── storage_service.dart     # Storage işlemleri
│   └── main.dart
├── supabase/
│   ├── migrations/                      # Database migrations
│   │   ├── 20260505000001_initial_setup.sql
│   │   └── README.md
│   ├── storage/                         # Storage policies
│   │   ├── avatars_policies.sql
│   │   └── README.md
│   └── config.toml                      # Supabase local config
├── .env.example                         # Environment template
├── .gitignore
├── pubspec.yaml
├── README.md
└── SUPABASE_SETUP.md                    # Supabase kurulum rehberi
```

## 🔧 Teknolojiler

- **Flutter**: UI framework
- **Supabase**: Backend as a Service
  - Authentication (Email)
  - PostgreSQL Database
  - Storage
  - Row Level Security (RLS)
- **flutter_dotenv**: Environment variables

## 🔐 Güvenlik

- Tüm tablolarda Row Level Security (RLS) aktif
- Environment variables Git'e commit edilmiyor
- API keys güvenli saklanıyor
- Storage bucket'lar policy korumalı

## 📚 Dokümantasyon

- [Supabase Setup Guide](SUPABASE_SETUP.md) - Detaylı Supabase kurulum rehberi
- [Database Migrations](supabase/migrations/README.md) - Migration yönetimi
- [Storage Buckets](supabase/storage/README.md) - Storage yapılandırması

## 🧪 Test

```bash
flutter test
```

## 🏗️ Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 📝 Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `APP_ENV` | Environment (development/staging/production) | Yes |
| `SUPABASE_URL` | Supabase project URL | Yes |
| `SUPABASE_ANON_KEY` | Supabase anonymous key | Yes |

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'feat: Add amazing feature'`)
4. Push yapın (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📄 Lisans

Bu proje özel bir projedir.

## 📧 İletişim

Proje Sahibi - SAHADA Team

---

**Not**: Production'a geçmeden önce güvenlik ayarlarını gözden geçirin ve email confirmation'ı aktifleştirin.
