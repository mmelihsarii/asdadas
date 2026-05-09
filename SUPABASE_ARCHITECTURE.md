# SAHADA - Supabase Architecture

Bu dokümantasyon SAHADA projesinin Supabase mimarisini açıklar.

## 🏗️ Mimari Genel Bakış

```
┌─────────────────────────────────────────────────────────────┐
│                      Flutter Application                     │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Auth Service │  │Storage Service│  │ DB Service   │      │
│  └──────┬───────┘  └──────┬────────┘  └──────┬───────┘      │
│         │                  │                   │              │
│         └──────────────────┼───────────────────┘              │
│                            │                                  │
│                   ┌────────▼────────┐                        │
│                   │ Supabase Service│                        │
│                   │   (Singleton)   │                        │
│                   └────────┬────────┘                        │
│                            │                                  │
│                   ┌────────▼────────┐                        │
│                   │   Env Config    │                        │
│                   │  (.env loader)  │                        │
│                   └─────────────────┘                        │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ HTTPS
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                      Supabase Cloud                          │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │     Auth     │  │   Storage    │  │  PostgreSQL  │      │
│  │   (GoTrue)   │  │   (Buckets)  │  │  (Database)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │   Realtime   │  │     Edge     │  │     RLS      │      │
│  │  (WebSocket) │  │  Functions   │  │  (Security)  │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## 📦 Katman Yapısı

### 1. Configuration Layer (Yapılandırma Katmanı)

**Dosya**: `lib/core/config/env_config.dart`

**Sorumluluklar**:
- Environment variables yönetimi
- `.env` dosyasından yapılandırma okuma
- Environment type kontrolü (dev/staging/prod)

**Kullanım**:
```dart
await EnvConfig.init();
String url = EnvConfig.supabaseUrl;
bool isDev = EnvConfig.isDevelopment;
```

### 2. Service Layer (Servis Katmanı)

#### 2.1 Supabase Service (Merkezi Yönetim)

**Dosya**: `lib/core/services/supabase_service.dart`

**Sorumluluklar**:
- Supabase client singleton yönetimi
- Tüm Supabase modüllerine erişim sağlama
- Client initialization

**Özellikler**:
- ✅ Singleton pattern
- ✅ Lazy initialization
- ✅ Centralized access

**Kullanım**:
```dart
final supabase = SupabaseService.instance;
final client = supabase.client;
final auth = supabase.auth;
```

#### 2.2 Auth Service (Kimlik Doğrulama)

**Dosya**: `lib/core/services/auth_service.dart`

**Sorumluluklar**:
- Kullanıcı kaydı (sign up)
- Kullanıcı girişi (sign in)
- Çıkış (sign out)
- Şifre sıfırlama
- Kullanıcı bilgisi güncelleme
- Auth state yönetimi

**Özellikler**:
- ✅ Singleton pattern
- ✅ Stream-based auth state
- ✅ Session management

**Kullanım**:
```dart
final auth = AuthService.instance;
await auth.signUpWithEmail(email: '...', password: '...');
bool isAuth = auth.isAuthenticated;
User? user = auth.currentUser;
```

#### 2.3 Storage Service (Dosya Depolama)

**Dosya**: `lib/core/services/storage_service.dart`

**Sorumluluklar**:
- Avatar upload/download
- Dosya silme
- Public URL oluşturma
- Bucket yönetimi

**Özellikler**:
- ✅ Singleton pattern
- ✅ Type-safe bucket names
- ✅ Automatic path generation

**Kullanım**:
```dart
final storage = StorageService.instance;
String url = await storage.uploadAvatar(userId: '...', file: file);
await storage.deleteAvatar(path);
```

## 🗄️ Database Architecture

### Migration Strategy

**Klasör**: `supabase/migrations/`

**Naming Convention**:
```
YYYYMMDDHHMMSS_description.sql
```

**İlk Migration**: `20260505000001_initial_setup.sql`
- ✅ uuid-ossp extension
- ✅ postgis extension
- ✅ update_updated_at_column() function

### Table Design Principles

1. **Her tablo şunları içermeli**:
```sql
CREATE TABLE table_name (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    -- diğer kolonlar
);

-- Updated at trigger
CREATE TRIGGER update_table_name_updated_at
    BEFORE UPDATE ON table_name
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
```

2. **RLS her tabloda zorunlu**:
```sql
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
```

3. **Foreign key'ler CASCADE olmalı**:
```sql
user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE
```

## 📦 Storage Architecture

### Bucket Structure

**Klasör**: `supabase/storage/`

#### avatars Bucket

**Yapı**:
```
avatars/
├── {user_id_1}/
│   ├── avatar_1.jpg
│   └── avatar_2.png
├── {user_id_2}/
│   └── avatar.webp
```

**Policies**:
- ✅ Users can upload own avatars
- ✅ Users can update own avatars
- ✅ Users can delete own avatars
- ✅ Public read access

**Limits**:
- Max file size: 2MB
- Allowed types: jpg, jpeg, png, webp

## 🔐 Security Architecture

### Row Level Security (RLS)

**Prensip**: Her tablo için RLS zorunlu

**Policy Tipleri**:

1. **SELECT Policies**:
```sql
-- Kullanıcı kendi kaydını görebilir
CREATE POLICY "Users can view own record"
ON table_name FOR SELECT
USING (auth.uid() = user_id);

-- Herkes public kayıtları görebilir
CREATE POLICY "Public records viewable"
ON table_name FOR SELECT
USING (is_public = true);
```

2. **INSERT Policies**:
```sql
CREATE POLICY "Users can insert own record"
ON table_name FOR INSERT
WITH CHECK (auth.uid() = user_id);
```

3. **UPDATE Policies**:
```sql
CREATE POLICY "Users can update own record"
ON table_name FOR UPDATE
USING (auth.uid() = user_id);
```

4. **DELETE Policies**:
```sql
CREATE POLICY "Users can delete own record"
ON table_name FOR DELETE
USING (auth.uid() = user_id);
```

### Authentication Security

**Email Auth**:
- ✅ Development: Email confirmation kapalı
- ⚠️ Production: Email confirmation açık olmalı
- ✅ Password minimum 6 karakter
- ✅ JWT token-based authentication

**API Keys**:
- ✅ Anon key: Client-side kullanımı güvenli
- ❌ Service role key: Asla client'ta kullanılmamalı
- ✅ Keys .env dosyasında saklanır
- ✅ .env dosyası Git'e commit edilmez

## 🔄 Data Flow

### Authentication Flow

```
User Action (Sign Up)
    ↓
AuthService.signUpWithEmail()
    ↓
SupabaseService.auth.signUp()
    ↓
Supabase Cloud (GoTrue)
    ↓
JWT Token Generated
    ↓
Session Created
    ↓
AuthState Stream Updated
    ↓
UI Updated
```

### Storage Upload Flow

```
User Selects File
    ↓
StorageService.uploadAvatar()
    ↓
Generate Path: {userId}/{filename}
    ↓
SupabaseService.storage.upload()
    ↓
RLS Policy Check
    ↓
File Uploaded to Bucket
    ↓
Public URL Generated
    ↓
URL Returned to App
```

### Database Query Flow

```
App Needs Data
    ↓
SupabaseService.client.from('table')
    ↓
Query Builder
    ↓
RLS Policy Applied
    ↓
PostgreSQL Query
    ↓
Data Returned
    ↓
Dart Objects Created
    ↓
UI Updated
```

## 🌍 Environment Management

### Environment Types

1. **Development**:
   - Email confirmation: ❌
   - Debug logging: ✅
   - Local testing: ✅

2. **Staging**:
   - Email confirmation: ✅
   - Debug logging: ✅
   - Production-like testing: ✅

3. **Production**:
   - Email confirmation: ✅
   - Debug logging: ❌
   - Live users: ✅

### Environment Variables

```env
# Required
APP_ENV=development|staging|production
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGc...

# Optional (future)
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...  # Backend only!
SENTRY_DSN=https://...
ANALYTICS_KEY=...
```

## 📊 Monitoring & Logging

### Supabase Dashboard

**Monitoring**:
- Database > Logs
- Auth > Users
- Storage > Usage
- API > Logs

**Metrics**:
- Active users
- Database size
- Storage usage
- API requests

### Flutter Logging

```dart
// Development
if (EnvConfig.isDevelopment) {
  print('Debug: $message');
}

// Production
// Use proper logging service (Sentry, Firebase Crashlytics)
```

## 🚀 Scalability Considerations

### Database

- ✅ Indexes on foreign keys
- ✅ Proper data types
- ✅ Normalized structure
- ✅ Efficient queries

### Storage

- ✅ CDN for public files
- ✅ Image optimization
- ✅ Lazy loading
- ✅ Caching strategy

### Authentication

- ✅ JWT token caching
- ✅ Refresh token rotation
- ✅ Session management
- ✅ Rate limiting

## 📈 Future Enhancements

### Planned Features

1. **Realtime Subscriptions**:
```dart
supabase.client
  .from('reservations')
  .stream(primaryKey: ['id'])
  .listen((data) {
    // Handle realtime updates
  });
```

2. **Edge Functions**:
- Payment processing
- Email notifications
- Complex business logic

3. **Advanced RLS**:
- Role-based access control
- Team permissions
- Admin privileges

4. **Caching Layer**:
- Local database (Hive/Isar)
- Offline support
- Sync strategy

## 🔗 Dependencies

### Flutter Packages

```yaml
dependencies:
  supabase_flutter: ^2.5.0    # Supabase client
  flutter_dotenv: ^5.1.0      # Environment variables
```

### Supabase Extensions

```sql
uuid-ossp    # UUID generation
postgis      # Geospatial data
```

## 📚 Best Practices

### DO ✅

- Her zaman RLS kullan
- Migration'larla ilerle
- Environment variables kullan
- Singleton pattern uygula
- Error handling yap
- Type-safe kod yaz

### DON'T ❌

- Service role key'i client'ta kullanma
- .env dosyasını commit etme
- RLS'siz tablo oluşturma
- Hardcoded credentials kullanma
- Migration'ları silme
- Production'da debug logging

---

**Versiyon**: 1.0.0
**Son Güncelleme**: 5 Mayıs 2026
**Mimari Tipi**: Clean Architecture + Service Layer Pattern
