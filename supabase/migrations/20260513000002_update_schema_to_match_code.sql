-- ============================================
-- SAHADA - Schema Update Migration
-- Veritabanı şemasını kod ile uyumlu hale getir
-- ============================================
-- Tarih: 13 Mayıs 2026
-- Amaç: Eski tablo isimlerini ve kolonları yeni kod yapısına uyarla

-- ============================================
-- 1. TABLO İSİMLERİNİ GÜNCELLE
-- ============================================

-- match_posts -> match_listings
ALTER TABLE IF EXISTS match_posts RENAME TO match_listings;

-- player_ads -> player_listings
ALTER TABLE IF EXISTS player_ads RENAME TO player_listings;

-- applications -> participations
ALTER TABLE IF EXISTS applications RENAME TO participations;

-- player_profiles -> user_profiles
ALTER TABLE IF EXISTS player_profiles RENAME TO user_profiles;

-- ============================================
-- 2. ENUM TİPLERİNİ GÜNCELLE
-- ============================================

-- Yeni enum'ları oluştur (IF NOT EXISTS yok, önce DROP sonra CREATE)
DO $$ BEGIN
    CREATE TYPE skill_level AS ENUM ('BEGINNER', 'INTERMEDIATE', 'ADVANCED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE match_format AS ENUM ('FIVE_VS_FIVE', 'SIX_VS_SIX', 'SEVEN_VS_SEVEN');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE position_type AS ENUM ('GOALKEEPER', 'DEFENDER', 'MIDFIELDER', 'FORWARD', 'ANY');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE price_type AS ENUM ('FREE', 'PAID');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE listing_status AS ENUM ('OPEN', 'FILLED', 'COMPLETED', 'CANCELED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE participation_status AS ENUM ('ACCEPTED', 'LEFT', 'KICKED');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE payment_method AS ENUM ('CASH', 'IBAN');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE cancellation_level AS ENUM ('FLEXIBLE', 'MEDIUM', 'STRICT');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- ============================================
-- 3. MATCH_LISTINGS TABLOSUNU GÜNCELLE
-- ============================================

-- Eski kolonları yeniden adlandır
ALTER TABLE match_listings RENAME COLUMN location_name TO pitch_name;
ALTER TABLE match_listings RENAME COLUMN match_time TO starts_at;
ALTER TABLE match_listings RENAME COLUMN needed_players TO needed_count;

-- Eski city ve district kolonlarını kaldır (artık lat/lng kullanıyoruz)
ALTER TABLE match_listings DROP COLUMN IF EXISTS city;
ALTER TABLE match_listings DROP COLUMN IF EXISTS district;

-- Yeni kolonları ekle
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS format match_format DEFAULT 'FIVE_VS_FIVE';
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS needed_positions position_type[] DEFAULT '{}';
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS skill_level skill_level DEFAULT 'INTERMEDIATE';
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS price_type price_type DEFAULT 'FREE';
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS base_price INTEGER DEFAULT 0;
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS negotiation_enabled BOOLEAN DEFAULT FALSE;
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS cancel_window_hours INTEGER DEFAULT 2;
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS late_tolerance_min INTEGER DEFAULT 15;
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS payment_method payment_method DEFAULT 'CASH';
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS min_quality_score FLOAT DEFAULT 0.0;
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS cancellation_level cancellation_level DEFAULT 'MEDIUM';
ALTER TABLE match_listings ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- Status kolonunu güncelle
ALTER TABLE match_listings DROP COLUMN IF EXISTS status CASCADE;
ALTER TABLE match_listings ADD COLUMN status listing_status DEFAULT 'OPEN';

-- ============================================
-- 4. PLAYER_LISTINGS TABLOSUNU GÜNCELLE
-- ============================================

-- Eski kolonları yeniden adlandır
ALTER TABLE player_listings RENAME COLUMN preferred_position TO positions_temp;
ALTER TABLE player_listings RENAME COLUMN available_time TO available_start;

-- Eski city ve district kolonlarını kaldır
ALTER TABLE player_listings DROP COLUMN IF EXISTS city;
ALTER TABLE player_listings DROP COLUMN IF EXISTS district;

-- Yeni kolonları ekle
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS notes TEXT;
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS center_lat FLOAT DEFAULT 41.0082;
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS center_lng FLOAT DEFAULT 28.9784;
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS radius_km INTEGER DEFAULT 10;
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS available_end TIMESTAMPTZ DEFAULT NOW() + INTERVAL '7 days';
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS positions position_type[] DEFAULT '{}';
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS skill_level skill_level DEFAULT 'INTERMEDIATE';
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS preferred_formats match_format[] DEFAULT '{}';
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS ask_price INTEGER DEFAULT 0;
ALTER TABLE player_listings ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- Status kolonunu güncelle
ALTER TABLE player_listings DROP COLUMN IF EXISTS status CASCADE;
ALTER TABLE player_listings ADD COLUMN status listing_status DEFAULT 'OPEN';

-- Geçici kolonu kaldır
ALTER TABLE player_listings DROP COLUMN IF EXISTS positions_temp;

-- ============================================
-- 5. PARTICIPATIONS TABLOSUNU GÜNCELLE
-- ============================================

-- Kolon isimlerini güncelle
ALTER TABLE participations RENAME COLUMN post_id TO match_id;

-- Status kolonunu güncelle
ALTER TABLE participations DROP COLUMN IF EXISTS status CASCADE;
ALTER TABLE participations ADD COLUMN status participation_status DEFAULT 'ACCEPTED';

-- ============================================
-- 6. USER_PROFILES TABLOSUNU GÜNCELLE
-- ============================================

-- Eski position kolonunu kaldır, yeni positions array ekle
ALTER TABLE user_profiles DROP COLUMN IF EXISTS position;
ALTER TABLE user_profiles ADD COLUMN IF NOT EXISTS positions position_type[] DEFAULT '{}';

-- Skill level kolonunu güncelle
ALTER TABLE user_profiles DROP COLUMN IF EXISTS skill_level CASCADE;
ALTER TABLE user_profiles ADD COLUMN skill_level skill_level DEFAULT 'BEGINNER';

-- Yeni kolonları ekle
ALTER TABLE user_profiles ADD COLUMN IF NOT EXISTS bio TEXT;
ALTER TABLE user_profiles ADD COLUMN IF NOT EXISTS matches_played_count INTEGER DEFAULT 0;
ALTER TABLE user_profiles ADD COLUMN IF NOT EXISTS rating_count INTEGER DEFAULT 0;
ALTER TABLE user_profiles ADD COLUMN IF NOT EXISTS no_show_count INTEGER DEFAULT 0;
ALTER TABLE user_profiles ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- ============================================
-- 7. USERS TABLOSUNU GÜNCELLE
-- ============================================

-- Yeni kolonları ekle (auth.users ile senkronizasyon için)
ALTER TABLE users ADD COLUMN IF NOT EXISTS display_name TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

-- Eski role, city, district kolonlarını kaldır (artık kullanılmıyor)
ALTER TABLE users DROP COLUMN IF EXISTS role;
ALTER TABLE users DROP COLUMN IF EXISTS city;
ALTER TABLE users DROP COLUMN IF EXISTS district;

-- ============================================
-- 8. YENİ TABLOLAR OLUŞTUR
-- ============================================

-- CHATS tablosu
DO $$ BEGIN
    CREATE TABLE chats (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
EXCEPTION
    WHEN duplicate_table THEN null;
END $$;

-- CHAT_MEMBERS tablosu
DO $$ BEGIN
    CREATE TABLE chat_members (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        chat_id UUID NOT NULL REFERENCES chats(id) ON DELETE CASCADE,
        user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        UNIQUE(chat_id, user_id)
    );
EXCEPTION
    WHEN duplicate_table THEN null;
END $$;

-- MESSAGES tablosu
DO $$ BEGIN
    CREATE TABLE messages (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        chat_id UUID NOT NULL REFERENCES chats(id) ON DELETE CASCADE,
        sender_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        body TEXT NOT NULL,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
EXCEPTION
    WHEN duplicate_table THEN null;
END $$;

-- OFFERS tablosu
DO $$ BEGIN
    CREATE TABLE offers (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        match_id UUID NOT NULL REFERENCES match_listings(id) ON DELETE CASCADE,
        player_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        organizer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        amount INTEGER NOT NULL,
        message TEXT,
        status TEXT NOT NULL DEFAULT 'SENT',
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
EXCEPTION
    WHEN duplicate_table THEN null;
END $$;

-- REPORTS tablosu
DO $$ BEGIN
    CREATE TABLE reports (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        reporter_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        reported_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        reason TEXT NOT NULL,
        description TEXT,
        status TEXT NOT NULL DEFAULT 'PENDING',
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
EXCEPTION
    WHEN duplicate_table THEN null;
END $$;

-- REVIEWS tablosu
DO $$ BEGIN
    CREATE TABLE reviews (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        match_id UUID NOT NULL REFERENCES match_listings(id) ON DELETE CASCADE,
        reviewer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        reviewee_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
        comment TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
EXCEPTION
    WHEN duplicate_table THEN null;
END $$;

-- ============================================
-- 9. İNDEXLERİ GÜNCELLE
-- ============================================

-- Eski indexleri kaldır
DROP INDEX IF EXISTS idx_match_posts_organizer_id;
DROP INDEX IF EXISTS idx_match_posts_status;
DROP INDEX IF EXISTS idx_match_posts_city_district;
DROP INDEX IF EXISTS idx_player_ads_player_id;
DROP INDEX IF EXISTS idx_player_ads_status;
DROP INDEX IF EXISTS idx_applications_post_id;
DROP INDEX IF EXISTS idx_applications_player_id;

-- Yeni indexleri oluştur
CREATE INDEX IF NOT EXISTS idx_match_listings_organizer_id ON match_listings(organizer_id);
CREATE INDEX IF NOT EXISTS idx_match_listings_status ON match_listings(status);
CREATE INDEX IF NOT EXISTS idx_match_listings_starts_at ON match_listings(starts_at);
-- Location indexleri - basit lat/lng indexleri (PostGIS gerekmez)
CREATE INDEX IF NOT EXISTS idx_match_listings_lat ON match_listings(lat);
CREATE INDEX IF NOT EXISTS idx_match_listings_lng ON match_listings(lng);

CREATE INDEX IF NOT EXISTS idx_player_listings_player_id ON player_listings(player_id);
CREATE INDEX IF NOT EXISTS idx_player_listings_status ON player_listings(status);
-- Location indexleri - basit lat/lng indexleri
CREATE INDEX IF NOT EXISTS idx_player_listings_center_lat ON player_listings(center_lat);
CREATE INDEX IF NOT EXISTS idx_player_listings_center_lng ON player_listings(center_lng);

CREATE INDEX IF NOT EXISTS idx_participations_match_id ON participations(match_id);
CREATE INDEX IF NOT EXISTS idx_participations_player_id ON participations(player_id);

CREATE INDEX IF NOT EXISTS idx_user_profiles_user_id ON user_profiles(user_id);

CREATE INDEX IF NOT EXISTS idx_chat_members_chat_id ON chat_members(chat_id);
CREATE INDEX IF NOT EXISTS idx_chat_members_user_id ON chat_members(user_id);

CREATE INDEX IF NOT EXISTS idx_messages_chat_id ON messages(chat_id);
CREATE INDEX IF NOT EXISTS idx_messages_sender_id ON messages(sender_id);

CREATE INDEX IF NOT EXISTS idx_offers_match_id ON offers(match_id);
CREATE INDEX IF NOT EXISTS idx_offers_player_id ON offers(player_id);

CREATE INDEX IF NOT EXISTS idx_reviews_match_id ON reviews(match_id);
CREATE INDEX IF NOT EXISTS idx_reviews_reviewee_id ON reviews(reviewee_id);

-- ============================================
-- 10. RLS POLİTİKALARINI GÜNCELLE
-- ============================================

-- Eski politikaları kaldır
DROP POLICY IF EXISTS "Match posts are viewable by everyone" ON match_listings;
DROP POLICY IF EXISTS "Organizers can insert match posts" ON match_listings;
DROP POLICY IF EXISTS "Organizers can update own match posts" ON match_listings;
DROP POLICY IF EXISTS "Organizers can delete own match posts" ON match_listings;

DROP POLICY IF EXISTS "Player ads are viewable by everyone" ON player_listings;
DROP POLICY IF EXISTS "Players can insert own ads" ON player_listings;
DROP POLICY IF EXISTS "Players can update own ads" ON player_listings;
DROP POLICY IF EXISTS "Players can delete own ads" ON player_listings;

DROP POLICY IF EXISTS "Applications viewable by post owner and applicant" ON participations;
DROP POLICY IF EXISTS "Players can insert applications" ON participations;
DROP POLICY IF EXISTS "Post owners can update applications" ON participations;

DROP POLICY IF EXISTS "Player profiles are viewable by everyone" ON user_profiles;
DROP POLICY IF EXISTS "Players can update own profile" ON user_profiles;
DROP POLICY IF EXISTS "Players can insert own profile" ON user_profiles;

-- Yeni politikaları oluştur
-- Match Listings
CREATE POLICY "Match listings are viewable by everyone" ON match_listings FOR SELECT USING (true);
CREATE POLICY "Organizers can insert match listings" ON match_listings FOR INSERT WITH CHECK (auth.uid() = organizer_id);
CREATE POLICY "Organizers can update own match listings" ON match_listings FOR UPDATE USING (auth.uid() = organizer_id);
CREATE POLICY "Organizers can delete own match listings" ON match_listings FOR DELETE USING (auth.uid() = organizer_id);

-- Player Listings
CREATE POLICY "Player listings are viewable by everyone" ON player_listings FOR SELECT USING (true);
CREATE POLICY "Players can insert own listings" ON player_listings FOR INSERT WITH CHECK (auth.uid() = player_id);
CREATE POLICY "Players can update own listings" ON player_listings FOR UPDATE USING (auth.uid() = player_id);
CREATE POLICY "Players can delete own listings" ON player_listings FOR DELETE USING (auth.uid() = player_id);

-- Participations
CREATE POLICY "Participations viewable by match owner and participant" ON participations FOR SELECT USING (
    auth.uid() = player_id OR 
    auth.uid() IN (SELECT organizer_id FROM match_listings WHERE id = match_id)
);
CREATE POLICY "Players can insert participations" ON participations FOR INSERT WITH CHECK (auth.uid() = player_id);
CREATE POLICY "Match owners can update participations" ON participations FOR UPDATE USING (
    auth.uid() IN (SELECT organizer_id FROM match_listings WHERE id = match_id)
);

-- User Profiles
CREATE POLICY "User profiles are viewable by everyone" ON user_profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON user_profiles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own profile" ON user_profiles FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Chats
ALTER TABLE chats ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own chats" ON chats FOR SELECT USING (
    auth.uid() IN (SELECT user_id FROM chat_members WHERE chat_id = id)
);
CREATE POLICY "Users can create chats" ON chats FOR INSERT WITH CHECK (true);

-- Chat Members
ALTER TABLE chat_members ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view chat members" ON chat_members FOR SELECT USING (
    auth.uid() IN (SELECT user_id FROM chat_members WHERE chat_id = chat_members.chat_id)
);
CREATE POLICY "Users can add chat members" ON chat_members FOR INSERT WITH CHECK (true);

-- Messages
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view messages in their chats" ON messages FOR SELECT USING (
    auth.uid() IN (SELECT user_id FROM chat_members WHERE chat_id = messages.chat_id)
);
CREATE POLICY "Users can send messages to their chats" ON messages FOR INSERT WITH CHECK (
    auth.uid() IN (SELECT user_id FROM chat_members WHERE chat_id = chat_id)
);

-- Offers
ALTER TABLE offers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own offers" ON offers FOR SELECT USING (
    auth.uid() = player_id OR auth.uid() = organizer_id
);
CREATE POLICY "Players can create offers" ON offers FOR INSERT WITH CHECK (auth.uid() = player_id);
CREATE POLICY "Users can update own offers" ON offers FOR UPDATE USING (
    auth.uid() = player_id OR auth.uid() = organizer_id
);

-- Reports
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can view own reports" ON reports FOR SELECT USING (auth.uid() = reporter_id);
CREATE POLICY "Users can create reports" ON reports FOR INSERT WITH CHECK (auth.uid() = reporter_id);

-- Reviews
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Reviews are viewable by everyone" ON reviews FOR SELECT USING (true);
CREATE POLICY "Users can create reviews" ON reviews FOR INSERT WITH CHECK (auth.uid() = reviewer_id);

-- ============================================
-- 11. TRIGGER'LARI GÜNCELLE
-- ============================================

-- Updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger'ları ekle
DROP TRIGGER IF EXISTS update_match_listings_updated_at ON match_listings;
CREATE TRIGGER update_match_listings_updated_at
    BEFORE UPDATE ON match_listings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_player_listings_updated_at ON player_listings;
CREATE TRIGGER update_player_listings_updated_at
    BEFORE UPDATE ON player_listings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_user_profiles_updated_at ON user_profiles;
CREATE TRIGGER update_user_profiles_updated_at
    BEFORE UPDATE ON user_profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- 12. FUNCTIONS - RPC Endpoints
-- ============================================

-- Nearby matches function (PostGIS olmadan - Haversine formula)
CREATE OR REPLACE FUNCTION nearby_matches(
    p_lat FLOAT,
    p_lng FLOAT,
    p_radius_km INTEGER DEFAULT 10,
    p_format match_format DEFAULT NULL,
    p_skill_level skill_level DEFAULT NULL
)
RETURNS SETOF match_listings AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM match_listings
    WHERE status = 'OPEN'
        -- Haversine formula ile mesafe hesaplama (yaklaşık)
        AND (
            6371 * acos(
                cos(radians(p_lat)) * 
                cos(radians(lat)) * 
                cos(radians(lng) - radians(p_lng)) + 
                sin(radians(p_lat)) * 
                sin(radians(lat))
            )
        ) <= p_radius_km
        AND (p_format IS NULL OR format = p_format)
        AND (p_skill_level IS NULL OR skill_level = p_skill_level)
    ORDER BY starts_at ASC;
END;
$$ LANGUAGE plpgsql;

-- User stats function
CREATE OR REPLACE FUNCTION get_user_stats(p_user_id UUID)
RETURNS JSON AS $$
DECLARE
    result JSON;
BEGIN
    SELECT json_build_object(
        'matches_played', COALESCE(up.matches_played_count, 0),
        'rating_avg', COALESCE(up.rating_avg, 0.0),
        'rating_count', COALESCE(up.rating_count, 0),
        'no_show_count', COALESCE(up.no_show_count, 0)
    ) INTO result
    FROM user_profiles up
    WHERE up.user_id = p_user_id;
    
    RETURN COALESCE(result, '{}'::json);
END;
$$ LANGUAGE plpgsql;

-- ============================================
-- 13. STORAGE BUCKET OLUŞTUR
-- ============================================

-- NOT: Bu SQL ile bucket oluşturulamaz, Supabase Dashboard'dan manuel oluşturulmalı
-- Bucket name: chat-images
-- Public: Yes
-- File size limit: 5MB
-- Allowed MIME types: image/jpeg, image/png, image/webp

-- ============================================
-- 14. NOTLAR
-- ============================================

-- Migration tamamlandı!
-- 
-- Yapılanlar:
-- 1. Tablo isimleri güncellendi (match_posts -> match_listings, vb.)
-- 2. Yeni enum'lar eklendi
-- 3. Kolonlar eklendi/güncellendi
-- 4. Yeni tablolar oluşturuldu (chats, messages, offers, vb.)
-- 5. İndexler güncellendi (basit lat/lng indexleri)
-- 6. RLS politikaları güncellendi
-- 7. Trigger'lar eklendi
-- 8. RPC functions oluşturuldu (Haversine formula ile)
--
-- Yapılması Gerekenler:
-- 1. Supabase Dashboard'dan 'chat-images' storage bucket'ını oluştur
-- 2. Mock data'yı yeni schema'ya göre güncelle (opsiyonel)
-- 3. Test et!
--
-- NOT: PostGIS extension kullanılmadı - basit Haversine formula ile mesafe hesaplama
-- Daha hassas mesafe hesaplama için PostGIS extension'ı etkinleştirilebilir.

