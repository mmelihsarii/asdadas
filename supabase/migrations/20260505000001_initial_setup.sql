-- ============================================
-- SAHADA - Halı Saha Organizasyon Uygulaması
-- Veritabanı Şeması ve Mock Data
-- ============================================

-- ============================================
-- 1. CLEANUP - Önceki Tabloları ve Enum'ları Temizle
-- ============================================

DROP TABLE IF EXISTS notifications CASCADE;
DROP TABLE IF EXISTS ratings CASCADE;
DROP TABLE IF EXISTS invitations CASCADE;
DROP TABLE IF EXISTS applications CASCADE;
DROP TABLE IF EXISTS player_ads CASCADE;
DROP TABLE IF EXISTS match_posts CASCADE;
DROP TABLE IF EXISTS player_profiles CASCADE;
DROP TABLE IF EXISTS users CASCADE;

DROP TYPE IF EXISTS user_role CASCADE;
DROP TYPE IF EXISTS post_status CASCADE;
DROP TYPE IF EXISTS application_status CASCADE;
DROP TYPE IF EXISTS notification_type CASCADE;

-- ============================================
-- 2. ENUM TYPES - Veri Bütünlüğü İçin
-- ============================================

CREATE TYPE user_role AS ENUM ('organizer', 'player');
CREATE TYPE post_status AS ENUM ('open', 'closed', 'completed', 'cancelled');
CREATE TYPE application_status AS ENUM ('pending', 'accepted', 'rejected');
CREATE TYPE notification_type AS ENUM ('invite', 'application', 'rating', 'system');

-- ============================================
-- 3. USERS TABLOSU
-- ============================================

CREATE TABLE users (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    role user_role NOT NULL,
    city TEXT NOT NULL,
    district TEXT NOT NULL,
    avatar_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================
-- 4. PLAYER_PROFILES TABLOSU
-- ============================================

CREATE TABLE player_profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    position TEXT NOT NULL,
    skill_level INTEGER NOT NULL CHECK (skill_level >= 1 AND skill_level <= 10),
    rating_avg FLOAT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id)
);

-- ============================================
-- 5. MATCH_POSTS TABLOSU
-- ============================================

CREATE TABLE match_posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organizer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    city TEXT NOT NULL,
    district TEXT NOT NULL,
    location_name TEXT NOT NULL,
    lat FLOAT NOT NULL,
    lng FLOAT NOT NULL,
    match_time TIMESTAMPTZ NOT NULL,
    needed_players INTEGER NOT NULL CHECK (needed_players > 0),
    status post_status NOT NULL DEFAULT 'open',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================
-- 6. PLAYER_ADS TABLOSU
-- ============================================

CREATE TABLE player_ads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    player_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    preferred_position TEXT NOT NULL,
    city TEXT NOT NULL,
    district TEXT NOT NULL,
    available_time TIMESTAMPTZ NOT NULL,
    status TEXT NOT NULL DEFAULT 'active',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================
-- 7. APPLICATIONS TABLOSU
-- ============================================

CREATE TABLE applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id UUID NOT NULL REFERENCES match_posts(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status application_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(post_id, player_id)
);

-- ============================================
-- 8. INVITATIONS TABLOSU
-- ============================================

CREATE TABLE invitations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ad_id UUID NOT NULL REFERENCES player_ads(id) ON DELETE CASCADE,
    organizer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status application_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(ad_id, organizer_id)
);

-- ============================================
-- 9. RATINGS TABLOSU
-- ============================================

CREATE TABLE ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    from_user UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    to_user UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    score INTEGER NOT NULL CHECK (score >= 1 AND score <= 5),
    comment TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(from_user, to_user)
);

-- ============================================
-- 10. NOTIFICATIONS TABLOSU
-- ============================================

CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type notification_type NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================
-- 11. INDEXES - Performans İçin
-- ============================================

CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_city_district ON users(city, district);
CREATE INDEX idx_player_profiles_user_id ON player_profiles(user_id);
CREATE INDEX idx_match_posts_organizer_id ON match_posts(organizer_id);
CREATE INDEX idx_match_posts_status ON match_posts(status);
CREATE INDEX idx_match_posts_city_district ON match_posts(city, district);
CREATE INDEX idx_player_ads_player_id ON player_ads(player_id);
CREATE INDEX idx_player_ads_status ON player_ads(status);
CREATE INDEX idx_applications_post_id ON applications(post_id);
CREATE INDEX idx_applications_player_id ON applications(player_id);
CREATE INDEX idx_invitations_ad_id ON invitations(ad_id);
CREATE INDEX idx_invitations_player_id ON invitations(player_id);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);

-- ============================================
-- 12. MOCK DATA - Test Verileri
-- ============================================

-- Organizatörler
INSERT INTO users (id, name, email, role, city, district, avatar_url) VALUES
('11111111-1111-1111-1111-111111111111', 'Ahmet Yılmaz', 'ahmet@example.com', 'organizer', 'İstanbul', 'Kadıköy', 'https://i.pravatar.cc/150?img=1'),
('22222222-2222-2222-2222-222222222222', 'Mehmet Demir', 'mehmet@example.com', 'organizer', 'İstanbul', 'Beşiktaş', 'https://i.pravatar.cc/150?img=2');

-- Oyuncular
INSERT INTO users (id, name, email, role, city, district, avatar_url) VALUES
('33333333-3333-3333-3333-333333333333', 'Ali Kaya', 'ali@example.com', 'player', 'İstanbul', 'Kadıköy', 'https://i.pravatar.cc/150?img=3'),
('44444444-4444-4444-4444-444444444444', 'Veli Öztürk', 'veli@example.com', 'player', 'İstanbul', 'Beşiktaş', 'https://i.pravatar.cc/150?img=4'),
('55555555-5555-5555-5555-555555555555', 'Can Arslan', 'can@example.com', 'player', 'İstanbul', 'Şişli', 'https://i.pravatar.cc/150?img=5');

-- Oyuncu Profilleri
INSERT INTO player_profiles (user_id, position, skill_level, rating_avg) VALUES
('33333333-3333-3333-3333-333333333333', 'Forvet', 8, 4.5),
('44444444-4444-4444-4444-444444444444', 'Orta Saha', 7, 4.2),
('55555555-5555-5555-5555-555555555555', 'Defans', 6, 3.8);

-- Maç İlanları
INSERT INTO match_posts (id, organizer_id, title, city, district, location_name, lat, lng, match_time, needed_players, status) VALUES
('a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1', '11111111-1111-1111-1111-111111111111', 'Kadıköy Halı Saha - Akşam Maçı', 'İstanbul', 'Kadıköy', 'Fenerbahçe Halı Saha', 40.9887, 29.0323, NOW() + INTERVAL '2 days', 5, 'open'),
('b2b2b2b2-b2b2-b2b2-b2b2-b2b2b2b2b2b2', '11111111-1111-1111-1111-111111111111', 'Moda Sahil Maçı', 'İstanbul', 'Kadıköy', 'Moda Spor Tesisleri', 40.9833, 29.0297, NOW() + INTERVAL '5 days', 3, 'open'),
('c3c3c3c3-c3c3-c3c3-c3c3-c3c3c3c3c3c3', '22222222-2222-2222-2222-222222222222', 'Beşiktaş Hafta Sonu Turnuvası', 'İstanbul', 'Beşiktaş', 'Beşiktaş Spor Kompleksi', 41.0422, 29.0089, NOW() + INTERVAL '7 days', 8, 'open'),
('d4d4d4d4-d4d4-d4d4-d4d4-d4d4d4d4d4d4', '22222222-2222-2222-2222-222222222222', 'Ortaköy Gece Maçı', 'İstanbul', 'Beşiktaş', 'Ortaköy Halı Saha', 41.0553, 29.0264, NOW() + INTERVAL '3 days', 4, 'closed');

-- Oyuncu İlanları
INSERT INTO player_ads (id, player_id, preferred_position, city, district, available_time, status) VALUES
('e5e5e5e5-e5e5-e5e5-e5e5-e5e5e5e5e5e5', '33333333-3333-3333-3333-333333333333', 'Forvet', 'İstanbul', 'Kadıköy', NOW() + INTERVAL '1 day', 'active'),
('f6f6f6f6-f6f6-f6f6-f6f6-f6f6f6f6f6f6', '44444444-4444-4444-4444-444444444444', 'Orta Saha', 'İstanbul', 'Beşiktaş', NOW() + INTERVAL '3 days', 'active'),
('a7a7a7a7-a7a7-a7a7-a7a7-a7a7a7a7a7a7', '55555555-5555-5555-5555-555555555555', 'Defans', 'İstanbul', 'Şişli', NOW() + INTERVAL '2 days', 'active');

-- Başvurular
INSERT INTO applications (post_id, player_id, status) VALUES
('a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1', '33333333-3333-3333-3333-333333333333', 'accepted'),
('a1a1a1a1-a1a1-a1a1-a1a1-a1a1a1a1a1a1', '44444444-4444-4444-4444-444444444444', 'pending'),
('b2b2b2b2-b2b2-b2b2-b2b2-b2b2b2b2b2b2', '55555555-5555-5555-5555-555555555555', 'pending'),
('c3c3c3c3-c3c3-c3c3-c3c3-c3c3c3c3c3c3', '33333333-3333-3333-3333-333333333333', 'rejected'),
('c3c3c3c3-c3c3-c3c3-c3c3-c3c3c3c3c3c3', '44444444-4444-4444-4444-444444444444', 'accepted');

-- Davetler
INSERT INTO invitations (ad_id, organizer_id, player_id, status) VALUES
('e5e5e5e5-e5e5-e5e5-e5e5-e5e5e5e5e5e5', '11111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333', 'pending'),
('f6f6f6f6-f6f6-f6f6-f6f6-f6f6f6f6f6f6', '22222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', 'accepted'),
('a7a7a7a7-a7a7-a7a7-a7a7-a7a7a7a7a7a7', '11111111-1111-1111-1111-111111111111', '55555555-5555-5555-5555-555555555555', 'pending');

-- Puanlamalar
INSERT INTO ratings (from_user, to_user, score, comment) VALUES
('11111111-1111-1111-1111-111111111111', '33333333-3333-3333-3333-333333333333', 5, 'Harika bir oyuncu, kesinlikle tavsiye ederim!'),
('11111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', 4, 'İyi bir takım oyuncusu, zamanında geldi.'),
('22222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', 5, 'Çok profesyonel ve yetenekli.'),
('33333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 4, 'Organizasyon çok iyiydi, teşekkürler.'),
('44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 5, 'Mükemmel bir organizatör!');

-- Bildirimler
INSERT INTO notifications (user_id, type, message, is_read) VALUES
('33333333-3333-3333-3333-333333333333', 'application', 'Kadıköy Halı Saha - Akşam Maçı başvurunuz kabul edildi!', FALSE),
('33333333-3333-3333-3333-333333333333', 'invite', 'Ahmet Yılmaz sizi bir maça davet etti.', FALSE),
('33333333-3333-3333-3333-333333333333', 'rating', 'Ahmet Yılmaz sizi 5 yıldız ile puanladı!', TRUE),
('44444444-4444-4444-4444-444444444444', 'invite', 'Mehmet Demir sizi Beşiktaş Hafta Sonu Turnuvası için davet etti.', FALSE),
('44444444-4444-4444-4444-444444444444', 'rating', 'Ahmet Yılmaz sizi puanladı.', FALSE),
('55555555-5555-5555-5555-555555555555', 'application', 'Moda Sahil Maçı başvurunuz beklemede.', FALSE),
('11111111-1111-1111-1111-111111111111', 'application', 'Ali Kaya maçınıza başvurdu.', TRUE),
('11111111-1111-1111-1111-111111111111', 'system', 'Hoş geldiniz! Profilinizi tamamlayın.', TRUE),
('22222222-2222-2222-2222-222222222222', 'application', 'Veli Öztürk turnuvanıza başvurdu.', FALSE);

-- ============================================
-- 13. ROW LEVEL SECURITY (RLS) POLİTİKALARI
-- ============================================

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE match_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_ads ENABLE ROW LEVEL SECURITY;
ALTER TABLE applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE invitations ENABLE ROW LEVEL SECURITY;
ALTER TABLE ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Users: Herkes okuyabilir, sadece kendi kaydını güncelleyebilir
CREATE POLICY "Users are viewable by everyone" ON users FOR SELECT USING (true);
CREATE POLICY "Users can update own record" ON users FOR UPDATE USING (auth.uid() = id);

-- Player Profiles: Herkes okuyabilir, sadece kendi profilini güncelleyebilir
CREATE POLICY "Player profiles are viewable by everyone" ON player_profiles FOR SELECT USING (true);
CREATE POLICY "Players can update own profile" ON player_profiles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Players can insert own profile" ON player_profiles FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Match Posts: Herkes okuyabilir, sadece organizatör kendi ilanlarını yönetebilir
CREATE POLICY "Match posts are viewable by everyone" ON match_posts FOR SELECT USING (true);
CREATE POLICY "Organizers can insert match posts" ON match_posts FOR INSERT WITH CHECK (auth.uid() = organizer_id);
CREATE POLICY "Organizers can update own match posts" ON match_posts FOR UPDATE USING (auth.uid() = organizer_id);
CREATE POLICY "Organizers can delete own match posts" ON match_posts FOR DELETE USING (auth.uid() = organizer_id);

-- Player Ads: Herkes okuyabilir, sadece oyuncu kendi ilanlarını yönetebilir
CREATE POLICY "Player ads are viewable by everyone" ON player_ads FOR SELECT USING (true);
CREATE POLICY "Players can insert own ads" ON player_ads FOR INSERT WITH CHECK (auth.uid() = player_id);
CREATE POLICY "Players can update own ads" ON player_ads FOR UPDATE USING (auth.uid() = player_id);
CREATE POLICY "Players can delete own ads" ON player_ads FOR DELETE USING (auth.uid() = player_id);

-- Applications: İlgili kullanıcılar görebilir ve yönetebilir
CREATE POLICY "Applications viewable by post owner and applicant" ON applications FOR SELECT USING (
    auth.uid() = player_id OR 
    auth.uid() IN (SELECT organizer_id FROM match_posts WHERE id = post_id)
);
CREATE POLICY "Players can insert applications" ON applications FOR INSERT WITH CHECK (auth.uid() = player_id);
CREATE POLICY "Post owners can update applications" ON applications FOR UPDATE USING (
    auth.uid() IN (SELECT organizer_id FROM match_posts WHERE id = post_id)
);

-- Invitations: İlgili kullanıcılar görebilir ve yönetebilir
CREATE POLICY "Invitations viewable by organizer and player" ON invitations FOR SELECT USING (
    auth.uid() = organizer_id OR auth.uid() = player_id
);
CREATE POLICY "Organizers can insert invitations" ON invitations FOR INSERT WITH CHECK (auth.uid() = organizer_id);
CREATE POLICY "Players can update invitation status" ON invitations FOR UPDATE USING (auth.uid() = player_id);

-- Ratings: Herkes okuyabilir, sadece kendi puanlamasını ekleyebilir
CREATE POLICY "Ratings are viewable by everyone" ON ratings FOR SELECT USING (true);
CREATE POLICY "Users can insert own ratings" ON ratings FOR INSERT WITH CHECK (auth.uid() = from_user);

-- Notifications: Sadece kendi bildirimlerini görebilir ve güncelleyebilir
CREATE POLICY "Users can view own notifications" ON notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own notifications" ON notifications FOR UPDATE USING (auth.uid() = user_id);

-- ============================================
-- 14. FUNCTIONS - Otomatik İşlemler
-- ============================================

-- Oyuncu ortalama puanını güncelleme fonksiyonu
CREATE OR REPLACE FUNCTION update_player_rating_avg()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE player_profiles
    SET rating_avg = (
        SELECT COALESCE(AVG(score), 0)
        FROM ratings
        WHERE to_user = NEW.to_user
    )
    WHERE user_id = NEW.to_user;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger: Yeni rating eklendiğinde ortalamayı güncelle
CREATE TRIGGER trigger_update_player_rating
AFTER INSERT OR UPDATE ON ratings
FOR EACH ROW
EXECUTE FUNCTION update_player_rating_avg();

-- ============================================
-- 15. AUTH TRIGGER - Production İçin
-- ============================================
-- NOT: Production'da auth.users ile senkronizasyon için
-- Yeni kullanıcı kaydolduğunda otomatik users tablosuna ekle

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users (id, name, email, phone)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'name', 'Kullanıcı'),
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'phone', NEW.email, NEW.phone)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger: auth.users'a yeni kayıt eklendiğinde çalışır
CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION handle_new_user();

-- ============================================
-- 16. YARDIMCI NOTLAR
-- ============================================
-- Mock Data Kullanıcı Bilgileri:
-- Email: ahmet@example.com, mehmet@example.com, ali@example.com, veli@example.com, can@example.com
-- Şifre: password123 (tüm kullanıcılar için)
--
-- Production'da:
-- 1. Kullanıcılar Supabase Auth API ile kaydolmalı
-- 2. handle_new_user() trigger'ı otomatik users tablosuna ekler
-- 3. Mock data'yı production'da kullanmayın!
