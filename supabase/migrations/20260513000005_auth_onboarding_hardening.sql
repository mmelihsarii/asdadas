-- ============================================
-- SAHADA - AUTH ONBOARDING HARDENING
-- Keeps email OTP signup, public.users, and profile setup in sync.
-- ============================================

ALTER TABLE users ADD COLUMN IF NOT EXISTS display_name TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS email_verified_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone_verified_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN IF NOT EXISTS birth_year INTEGER;
ALTER TABLE users ADD COLUMN IF NOT EXISTS home_lat DOUBLE PRECISION;
ALTER TABLE users ADD COLUMN IF NOT EXISTS home_lng DOUBLE PRECISION;
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_banned BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS kvkk_accepted_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT NOW();

UPDATE users
SET
    display_name = COALESCE(display_name, name),
    phone = COALESCE(NULLIF(phone, ''), email),
    updated_at = COALESCE(updated_at, created_at, NOW())
WHERE display_name IS NULL
   OR phone IS NULL
   OR phone = ''
   OR updated_at IS NULL;

ALTER TABLE users ALTER COLUMN phone DROP NOT NULL;

ALTER TABLE users ENABLE ROW LEVEL SECURITY;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public'
          AND tablename = 'users'
          AND policyname = 'Users can insert own record'
    ) THEN
        CREATE POLICY "Users can insert own record"
        ON users FOR INSERT
        WITH CHECK (auth.uid() = id);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public'
          AND tablename = 'users'
          AND policyname = 'Users can update own record'
    ) THEN
        CREATE POLICY "Users can update own record"
        ON users FOR UPDATE
        USING (auth.uid() = id)
        WITH CHECK (auth.uid() = id);
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE schemaname = 'public'
          AND tablename = 'users'
          AND policyname = 'Users are viewable by everyone'
    ) THEN
        CREATE POLICY "Users are viewable by everyone"
        ON users FOR SELECT
        USING (true);
    END IF;
END $$;

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
DECLARE
    v_display_name TEXT;
    v_phone TEXT;
BEGIN
    v_display_name := COALESCE(
        NEW.raw_user_meta_data->>'display_name',
        NEW.raw_user_meta_data->>'name',
        NULLIF(CONCAT_WS(
            ' ',
            NULLIF(NEW.raw_user_meta_data->>'first_name', ''),
            NULLIF(NEW.raw_user_meta_data->>'last_name', '')
        ), ''),
        'Kullanıcı'
    );

    v_phone := COALESCE(
        NULLIF(NEW.raw_user_meta_data->>'phone', ''),
        NEW.phone,
        NEW.email
    );

    INSERT INTO public.users (
        id,
        name,
        email,
        phone,
        display_name,
        email_verified_at,
        created_at,
        updated_at
    )
    VALUES (
        NEW.id,
        v_display_name,
        NEW.email,
        v_phone,
        v_display_name,
        CASE WHEN NEW.email_confirmed_at IS NULL THEN NOW() ELSE NEW.email_confirmed_at END,
        NOW(),
        NOW()
    )
    ON CONFLICT (id) DO UPDATE
    SET
        email = EXCLUDED.email,
        phone = COALESCE(public.users.phone, EXCLUDED.phone),
        display_name = COALESCE(public.users.display_name, EXCLUDED.display_name),
        email_verified_at = COALESCE(public.users.email_verified_at, EXCLUDED.email_verified_at),
        updated_at = NOW();

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION handle_new_user();

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_updated_at ON users(updated_at);
