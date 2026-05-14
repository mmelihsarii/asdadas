# 🔐 OTP Doğrulama Kodu Nerede?

## Development Modunda (Şu An)

### ✅ Yöntem 1: Supabase Dashboard Logs (EN KOLAY)

1. **Supabase Dashboard'a git:**
   ```
   https://app.supabase.com/project/yyqgomrvjudzduqxdsht/auth/users
   ```

2. **Logs'a git:**
   ```
   Sol menüden: Authentication > Logs
   ```

3. **OTP kodunu bul:**
   - En son "OTP sent" logunu aç
   - Orada **6 haneli kod** görünecek
   - Örnek: `123456`

### Yöntem 2: Supabase Email Templates

1. **Email Templates'e git:**
   ```
   Authentication > Email Templates
   ```

2. **"Magic Link" template'ini aç**
   - Orada `{{ .Token }}` değişkeni var
   - Bu kod email'de görünür (ama development'ta email gönderilmez)

---

## Production Modunda (Canlıya Alınca)

### Email ile OTP:
- Kullanıcının email'ine gelir
- Supabase otomatik gönderir
- Email template'ini özelleştirebilirsin

### SMS ile OTP (Opsiyonel):
- Twilio entegrasyonu gerekir
- Supabase Dashboard > Authentication > Providers > Phone

---

## 🎯 Development İçin Hızlı Çözüm

### Seçenek A: Test Email Kullan

Supabase'de test email'leri otomatik olarak logs'a düşer:

```
1. Kayıt ol: test@example.com
2. Supabase Dashboard > Authentication > Logs
3. OTP kodunu kopyala
4. Uygulamada gir
```

### Seçenek B: Inbucket (Local Email Testing)

Supabase Local Development kullanıyorsan:

```bash
# Supabase local start
supabase start

# Inbucket açılır: http://localhost:54324
# Tüm email'ler burada görünür
```

### Seçenek C: Sabit Test OTP (En Kolay)

Development'ta sabit bir test OTP kullan:

```dart
// auth_repository.dart'a ekle:
if (kDebugMode && email.contains('test')) {
  // Test kullanıcıları için sabit OTP: 123456
  print('🔐 TEST OTP: 123456');
}
```

---

## 📱 Şu An Ne Yapmalısın?

### ADIM 1: Supabase Dashboard'a Git
```
https://app.supabase.com/project/yyqgomrvjudzduqxdsht/auth/users
```

### ADIM 2: Uygulamada Kayıt Ol
```
Email: test@example.com
```

### ADIM 3: Logs'a Bak
```
Authentication > Logs > En son "OTP sent" > Kodu kopyala
```

### ADIM 4: Kodu Gir
```
Uygulamada 6 haneli kodu gir
```

---

## 🐛 Sorun Yaşarsan

### OTP Logs'da Görünmüyorsa:

1. **Email doğru mu?**
   - Geçerli email formatı olmalı
   - Örnek: `test@example.com`

2. **Supabase bağlantısı var mı?**
   - `.env` dosyasında `SUPABASE_URL` doğru mu?
   - Internet bağlantısı var mı?

3. **Auth ayarları doğru mu?**
   ```
   Supabase Dashboard > Authentication > Providers
   Email provider enabled olmalı
   ```

---

## 🎉 Özet

**Development'ta OTP nerede?**
→ **Supabase Dashboard > Authentication > Logs**

**Production'da OTP nerede?**
→ **Kullanıcının email'inde**

**En kolay test yöntemi?**
→ **Supabase Logs'a bak**

---

**Hazırlayan:** Kiro AI Assistant  
**Tarih:** 13 Mayıs 2026
