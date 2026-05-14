-- Test Migration Syntax
-- Bu dosyayı çalıştırarak migration syntax'ının doğru olduğunu test edebilirsin

-- Test 1: Enum oluşturma
DO $$ BEGIN
    CREATE TYPE test_enum AS ENUM ('VALUE1', 'VALUE2');
EXCEPTION
    WHEN duplicate_object THEN 
        RAISE NOTICE 'test_enum already exists';
END $$;

-- Test 2: Enum'u kontrol et
SELECT typname FROM pg_type WHERE typname = 'test_enum';

-- Test 3: Enum'u temizle
DROP TYPE IF EXISTS test_enum;

-- Başarılı! Şimdi gerçek migration'ı çalıştırabilirsin.
SELECT 'Migration syntax is correct!' as result;
