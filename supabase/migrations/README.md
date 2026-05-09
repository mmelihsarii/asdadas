# Database Migrations

Bu klasör Supabase database migration dosyalarını içerir.

## Migration Dosya Formatı

Migration dosyaları şu formatta adlandırılır:
```
YYYYMMDDHHMMSS_description.sql
```

Örnek: `20260505000001_initial_setup.sql`

## Migration Sırası

1. **20260505000001_initial_setup.sql** - İlk kurulum
   - uuid-ossp extension
   - postgis extension
   - updated_at trigger function

## Yeni Migration Ekleme

1. Yeni bir SQL dosyası oluştur (timestamp + açıklama)
2. SQL komutlarını yaz
3. Supabase Dashboard > SQL Editor'dan çalıştır
4. Veya Supabase CLI kullan: `supabase db push`

## RLS (Row Level Security) Kuralları

⚠️ **ÖNEMLİ**: Tüm tablolarda RLS aktif olmalıdır!

Her yeni tablo için:
```sql
-- Enable RLS
ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "policy_name" ON table_name
    FOR SELECT
    USING (auth.uid() = user_id);
```

## Best Practices

1. Her migration tek bir mantıksal değişiklik içermeli
2. Migration'lar geri alınabilir olmalı (rollback SQL'i yorum olarak ekle)
3. Production'a gitmeden önce dev ortamında test et
4. Migration'ları asla silme, yeni migration ile düzelt
5. Hassas veri içeren migration'ları .gitignore'a ekle
