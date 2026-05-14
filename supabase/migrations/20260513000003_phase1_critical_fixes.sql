-- ============================================
-- SAHADA - PHASE 1 CRITICAL FIXES
-- Backend Schema Düzeltmeleri
-- ============================================
-- Tarih: 13 Mayıs 2026
-- Amaç: Model-Backend uyumsuzluklarını düzelt

-- ============================================
-- 1. PARTICIPATIONS TABLOSUNA EKSIK KOLON EKLE
-- ============================================

-- agreed_amount kolonu ekle (Participation model'de var ama backend'de yok)
ALTER TABLE participations ADD COLUMN IF NOT EXISTS agreed_amount INTEGER DEFAULT 0;

-- ============================================
-- 2. OFFERS TABLOSUNU MODEL'E UYARLA
-- ============================================

-- Mevcut kolonları yeniden adlandır (IF EXISTS kullan)
DO $$ 
BEGIN
    -- match_id -> match_listing_id (eğer match_id varsa)
    IF EXISTS (SELECT 1 FROM information_schema.columns 
               WHERE table_name = 'offers' AND column_name = 'match_id') THEN
        ALTER TABLE offers RENAME COLUMN match_id TO match_listing_id;
    END IF;
    
    -- player_id -> from_user_id (eğer player_id varsa)
    IF EXISTS (SELECT 1 FROM information_schema.columns 
               WHERE table_name = 'offers' AND column_name = 'player_id') THEN
        ALTER TABLE offers RENAME COLUMN player_id TO from_user_id;
    END IF;
    
    -- organizer_id -> to_user_id (eğer organizer_id varsa)
    IF EXISTS (SELECT 1 FROM information_schema.columns 
               WHERE table_name = 'offers' AND column_name = 'organizer_id') THEN
        ALTER TABLE offers RENAME COLUMN organizer_id TO to_user_id;
    END IF;
END $$;

-- player_listing_id kolonu ekle (opsiyonel)
ALTER TABLE offers ADD COLUMN IF NOT EXISTS player_listing_id UUID REFERENCES player_listings(id) ON DELETE CASCADE;

-- counter_count kolonu ekle
ALTER TABLE offers ADD COLUMN IF NOT EXISTS counter_count INTEGER DEFAULT 0;

-- expires_at kolonu ekle
ALTER TABLE offers ADD COLUMN IF NOT EXISTS expires_at TIMESTAMPTZ DEFAULT NOW() + INTERVAL '7 days';

-- Status enum'unu güncelle
DO $$ BEGIN
    CREATE TYPE offer_status AS ENUM ('SENT', 'COUNTERED', 'ACCEPTED', 'REJECTED', 'EXPIRED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- Status kolonunu güncelle
ALTER TABLE offers DROP COLUMN IF EXISTS status CASCADE;
ALTER TABLE offers ADD COLUMN status offer_status DEFAULT 'SENT';

-- ============================================
-- 3. CHATS TABLOSUNA MATCH_ID EKLE
-- ============================================

-- match_id kolonu ekle (Chat model'de var ama backend'de yok)
ALTER TABLE chats ADD COLUMN IF NOT EXISTS match_id UUID REFERENCES match_listings(id) ON DELETE SET NULL;

-- Index ekle
CREATE INDEX IF NOT EXISTS idx_chats_match_id ON chats(match_id);

-- ============================================
-- 4. USERS TABLOSUNA EKSİK KOLONLARI EKLE
-- ============================================

-- User model'deki tüm eksik kolonları ekle
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone_verified_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN IF NOT EXISTS email_verified_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN IF NOT EXISTS birth_year INTEGER;
ALTER TABLE users ADD COLUMN IF NOT EXISTS home_lat DOUBLE PRECISION;
ALTER TABLE users ADD COLUMN IF NOT EXISTS home_lng DOUBLE PRECISION;
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_banned BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS kvkk_accepted_at TIMESTAMPTZ;

-- phone kolonunu NULL yapabilir hale getir
-- NOT: Mevcut data varsa önce NULL'ları temizle
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns 
               WHERE table_name = 'users' AND column_name = 'phone') THEN
        UPDATE users SET phone = COALESCE(phone, email) WHERE phone IS NULL OR phone = '';
        ALTER TABLE users ALTER COLUMN phone DROP NOT NULL;
    END IF;
END $$;

-- ============================================
-- 5. NEARBY_PLAYERS RPC FONKSİYONU OLUŞTUR
-- ============================================

-- Nearby players function (Haversine formula ile)
CREATE OR REPLACE FUNCTION nearby_players(
    p_lat DOUBLE PRECISION,
    p_lng DOUBLE PRECISION,
    p_radius_km INTEGER DEFAULT 10
)
RETURNS SETOF player_listings AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM player_listings
    WHERE status = 'OPEN'
        -- Haversine formula ile mesafe hesaplama
        AND (
            6371 * acos(
                cos(radians(p_lat)) * 
                cos(radians(center_lat)) * 
                cos(radians(center_lng) - radians(p_lng)) + 
                sin(radians(p_lat)) * 
                sin(radians(center_lat))
            )
        ) <= p_radius_km
        AND available_end >= NOW()
    ORDER BY available_start ASC;
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 6. APPLICATIONS TABLOSUNU KALDIR
-- ============================================

-- applications tablosu artık kullanılmıyor, participations kullanılıyor
-- Önce foreign key'leri kaldır
DROP TABLE IF EXISTS applications CASCADE;

-- applications_repository.dart dosyası participations kullanacak şekilde güncellenecek

-- ============================================
-- 7. KULLANILMAYAN TABLOLARI KALDIR
-- ============================================

-- invitations tablosu hiç kullanılmıyor
DROP TABLE IF EXISTS invitations CASCADE;

-- ratings tablosu kullanılmıyor (reviews tablosu kullanılıyor)
DROP TABLE IF EXISTS ratings CASCADE;

-- ============================================
-- 8. RLS POLİTİKALARINI GÜNCELLE
-- ============================================

-- Offers tablosu için yeni politikalar (kolon isimleri değişti)
-- Önce tüm mevcut policy'leri kaldır
DROP POLICY IF EXISTS "Users can view own offers" ON offers;
DROP POLICY IF EXISTS "Players can create offers" ON offers;
DROP POLICY IF EXISTS "Users can create offers" ON offers;
DROP POLICY IF EXISTS "Users can update own offers" ON offers;

-- Yeni policy'leri oluştur
DO $$ 
BEGIN
    -- Users can view own offers
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE tablename = 'offers' 
        AND policyname = 'Users can view own offers'
    ) THEN
        CREATE POLICY "Users can view own offers" ON offers FOR SELECT USING (
            auth.uid() = from_user_id OR auth.uid() = to_user_id
        );
    END IF;

    -- Users can create offers
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE tablename = 'offers' 
        AND policyname = 'Users can create offers'
    ) THEN
        CREATE POLICY "Users can create offers" ON offers FOR INSERT WITH CHECK (
            auth.uid() = from_user_id
        );
    END IF;

    -- Users can update own offers
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE tablename = 'offers' 
        AND policyname = 'Users can update own offers'
    ) THEN
        CREATE POLICY "Users can update own offers" ON offers FOR UPDATE USING (
            auth.uid() = from_user_id OR auth.uid() = to_user_id
        );
    END IF;
END $$;

-- ============================================
-- 9. TRIGGER'LARI GÜNCELLE
-- ============================================

-- Offers için updated_at trigger
DROP TRIGGER IF EXISTS update_offers_updated_at ON offers;
CREATE TRIGGER update_offers_updated_at
    BEFORE UPDATE ON offers
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Chats için updated_at trigger
DROP TRIGGER IF EXISTS update_chats_updated_at ON chats;
CREATE TRIGGER update_chats_updated_at
    BEFORE UPDATE ON chats
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- 10. OFFER EXPIRATION TRIGGER
-- ============================================

-- Expired offer'ları otomatik güncelle
CREATE OR REPLACE FUNCTION expire_old_offers()
RETURNS void AS $$
BEGIN
    UPDATE offers
    SET status = 'EXPIRED'
    WHERE status IN ('SENT', 'COUNTERED')
        AND expires_at < NOW();
END;
$$ LANGUAGE plpgsql;

-- Cron job için (Supabase Dashboard'dan pg_cron extension'ı etkinleştir)
-- SELECT cron.schedule('expire-offers', '0 * * * *', 'SELECT expire_old_offers()');

-- ============================================
-- 11. DATA MİGRATION (Mevcut Data Varsa)
-- ============================================

-- Mevcut participations'lara agreed_amount ekle (varsayılan 0)
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns 
               WHERE table_name = 'participations' AND column_name = 'agreed_amount') THEN
        UPDATE participations SET agreed_amount = 0 WHERE agreed_amount IS NULL;
    END IF;
END $$;

-- Mevcut users'lara phone ekle (email'den kopyala - geçici)
-- Production'da gerçek phone numaraları toplanmalı
DO $$ 
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns 
               WHERE table_name = 'users' AND column_name = 'phone') THEN
        UPDATE users SET phone = COALESCE(phone, email) WHERE phone IS NULL OR phone = '';
    END IF;
END $$;

-- ============================================
-- 12. INDEXES GÜNCELLE
-- ============================================

-- Eski indexleri kaldır (IF EXISTS kullan)
DROP INDEX IF EXISTS idx_offers_match_id;
DROP INDEX IF EXISTS idx_offers_player_id;
DROP INDEX IF EXISTS idx_offers_organizer_id;

-- Yeni indexleri oluştur
CREATE INDEX IF NOT EXISTS idx_offers_match_listing_id ON offers(match_listing_id);
CREATE INDEX IF NOT EXISTS idx_offers_player_listing_id ON offers(player_listing_id);
CREATE INDEX IF NOT EXISTS idx_offers_from_user_id ON offers(from_user_id);
CREATE INDEX IF NOT EXISTS idx_offers_to_user_id ON offers(to_user_id);
CREATE INDEX IF NOT EXISTS idx_offers_status ON offers(status);
CREATE INDEX IF NOT EXISTS idx_offers_expires_at ON offers(expires_at);

-- Participations için yeni index
CREATE INDEX IF NOT EXISTS idx_participations_agreed_amount ON participations(agreed_amount);

-- Users için yeni indexler
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
CREATE INDEX IF NOT EXISTS idx_users_is_admin ON users(is_admin);
CREATE INDEX IF NOT EXISTS idx_users_is_banned ON users(is_banned);

-- ============================================
-- 13. VALIDATION CONSTRAINTS
-- ============================================

-- Participations: agreed_amount pozitif olmalı
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'participations_agreed_amount_positive') THEN
        ALTER TABLE participations ADD CONSTRAINT participations_agreed_amount_positive 
            CHECK (agreed_amount >= 0);
    END IF;
END $$;

-- Offers: amount pozitif olmalı
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'offers_amount_positive') THEN
        ALTER TABLE offers ADD CONSTRAINT offers_amount_positive 
            CHECK (amount > 0);
    END IF;
END $$;

-- Offers: counter_count pozitif olmalı
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'offers_counter_count_positive') THEN
        ALTER TABLE offers ADD CONSTRAINT offers_counter_count_positive 
            CHECK (counter_count >= 0);
    END IF;
END $$;

-- Users: birth_year geçerli aralıkta olmalı
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'users_birth_year_valid') THEN
        ALTER TABLE users ADD CONSTRAINT users_birth_year_valid 
            CHECK (birth_year IS NULL OR (birth_year >= 1900 AND birth_year <= EXTRACT(YEAR FROM NOW())));
    END IF;
END $$;

-- ============================================
-- 14. NOTLAR
-- ============================================

-- Migration tamamlandı!
-- 
-- Yapılanlar:
-- ✅ 1. participations tablosuna agreed_amount eklendi
-- ✅ 2. offers tablosu model'e uyarlandı (kolon isimleri değişti)
-- ✅ 3. chats tablosuna match_id eklendi
-- ✅ 4. users tablosuna eksik kolonlar eklendi
-- ✅ 5. nearby_players RPC fonksiyonu oluşturuldu
-- ✅ 6. applications tablosu kaldırıldı (participations kullanılıyor)
-- ✅ 7. invitations ve ratings tabloları kaldırıldı
-- ✅ 8. RLS politikaları güncellendi
-- ✅ 9. Trigger'lar eklendi
-- ✅ 10. Offer expiration mekanizması eklendi
-- ✅ 11. Mevcut data migrate edildi
-- ✅ 12. Indexler güncellendi
-- ✅ 13. Validation constraint'ler eklendi
--
-- Yapılması Gerekenler:
-- 1. Dart repository dosyalarını güncelle (error handling ekle)
-- 2. applications_repository.dart'ı participations_repository.dart'a dönüştür
-- 3. Freezed dosyalarını yeniden oluştur: flutter pub run build_runner build --delete-conflicting-outputs
-- 4. Test et!
--
-- NOT: Bu migration'ı çalıştırmadan önce backup al!
-- Supabase Dashboard > Database > Backups

