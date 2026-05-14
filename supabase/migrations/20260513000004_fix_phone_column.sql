-- ============================================
-- SAHADA - FIX PHONE COLUMN
-- users.phone kolonunu NULL yapılabilir hale getir
-- ============================================
-- Tarih: 13 Mayıs 2026
-- Amaç: Kayıt sırasında phone zorunlu olmasın

-- ============================================
-- 1. PHONE KOLONUNU NULL YAPABİLİR HALE GETİR
-- ============================================

-- Mevcut NULL veya boş phone'ları email ile doldur
UPDATE users 
SET phone = COALESCE(phone, email) 
WHERE phone IS NULL OR phone = '';

-- phone kolonunu NULL yapabilir hale getir
ALTER TABLE users ALTER COLUMN phone DROP NOT NULL;

-- ============================================
-- 2. HANDLE_NEW_USER TRIGGER'INI GÜNCELLE
-- ============================================

-- Trigger fonksiyonunu güncelle
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

-- ============================================
-- 3. NOTLAR
-- ============================================

-- Migration tamamlandı!
-- 
-- Yapılanlar:
-- ✅ users.phone kolonu NULL yapılabilir hale getirildi
-- ✅ Mevcut NULL/boş phone'lar email ile dolduruldu
-- ✅ handle_new_user trigger'ı güncellendi
--
-- Artık kayıt sırasında phone gönderilmese de sorun olmayacak
-- phone yoksa email kullanılacak

