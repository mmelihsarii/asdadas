# 🔐 OTP Console Debug - Kullanım Kılavuzu

**Tarih:** 13 Mayıs 2026  
**Durum:** ✅ Aktif

---

## 🎯 Ne Değişti?

Artık OTP gönderildiğinde ve doğrulandığında **Flutter console'da** detaylı bilgi göreceksin!

---

## 📱 Console Çıktısı Örnekleri

### 1. Kayıt Olurken (Sign Up)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔐 OTP GÖNDERİLDİ (KAYIT)
📧 Email: test@example.com
👤 İsim: Ahmet Yılmaz
📱 Telefon: Yok
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  OTP kodunu görmek için:
   1. Supabase Dashboard > Authentication > Logs
   2. En son "OTP sent" logunu aç
   3. 6 haneli kodu kopyala
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ OTP başarıyla gönderildi!
```

### 2. Giriş Yaparken (Sign In)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔐 OTP GÖNDERİLDİ (GİRİŞ)
📧 Email: test@example.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  OTP kodunu görmek için:
   1. Supabase Dashboard > Authentication > Logs
   2. En son "OTP sent" logunu aç
   3. 6 haneli kodu kopyala
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ OTP başarıyla gönderildi!
```

### 3. OTP Doğrularken (Verify)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 OTP DOĞRULANIYOR...
📧 Email: test@example.com
🔢 Kod: 123456
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ OTP DOĞRULANDI!
👤 Kullanıcı: test@example.com
```

### 4. Yanlış OTP Girildiğinde

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 OTP DOĞRULANIYOR...
📧 Email: test@example.com
🔢 Kod: 999999
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
❌ OTP DOĞRULANAMADI!
```

---

## 🚀 Nasıl Kullanılır?

### ADIM 1: Uygulamayı Çalıştır

```bash
flutter run
```

### ADIM 2: Kayıt Ol veya Giriş Yap

```
Email: test@example.com
```

### ADIM 3: Console'u İzle

**VS Code:**
- Debug Console'u aç (Ctrl+Shift+Y)
- OTP mesajını gör

**Android Studio:**
- Run tab'ını aç
- OTP mesajını gör

**Terminal:**
- `flutter run` çıktısını izle
- OTP mesajını gör

### ADIM 4: Supabase Dashboard'a Git

```
https://app.supabase.com/project/yyqgomrvjudzduqxdsht/auth/users
```

**Sol menüden:**
```
Authentication > Logs
```

**En son "OTP sent" logunu aç:**
- Orada **6 haneli kod** görünecek
- Örnek: `123456`

### ADIM 5: Kodu Gir

Uygulamada 6 haneli kodu gir ve doğrula!

---

## 🎯 Özellikler

### ✅ Development Mode'da Aktif

- Sadece `kDebugMode` (debug build) aktifken çalışır
- Production build'de görünmez
- Güvenli ve temiz

### ✅ Detaylı Bilgi

- Email adresi
- Kullanıcı adı (kayıt sırasında)
- Telefon numarası (varsa)
- OTP kodu (girilen)
- Doğrulama sonucu

### ✅ Renkli ve Okunabilir

- Emoji'lerle görsel
- Çizgilerle ayrılmış
- Kolay takip edilebilir

---

## 📊 Güncellenen Dosyalar

### 1. `lib/data/repositories/auth_repository.dart`

**Eklenen:**
- `import 'package:flutter/foundation.dart';` (kDebugMode için)
- `debugPrint()` mesajları (3 method'da)

**Güncellenen Method'lar:**
1. `signUpWithEmailOtp()` - Kayıt OTP
2. `signInWithEmailOtp()` - Giriş OTP
3. `verifyEmailOtp()` - OTP Doğrulama

---

## 🐛 Sorun Giderme

### Console'da Mesaj Görünmüyorsa:

1. **Debug mode'da mı çalışıyor?**
   ```bash
   flutter run  # Debug mode (varsayılan)
   ```

2. **Console açık mı?**
   - VS Code: Ctrl+Shift+Y
   - Android Studio: Run tab

3. **Log level doğru mu?**
   - Flutter console'da tüm log'lar görünmeli

### OTP Hala Bulamıyorsan:

1. **Supabase Dashboard'a git:**
   ```
   https://app.supabase.com/project/yyqgomrvjudzduqxdsht/auth/users
   ```

2. **Logs'a bak:**
   ```
   Authentication > Logs > En son "OTP sent"
   ```

3. **Email template'ini kontrol et:**
   ```
   Authentication > Email Templates > Magic Link
   ```

---

## 🎉 Özet

**Artık OTP debug'ı çok kolay!**

1. ✅ `flutter run` çalıştır
2. ✅ Kayıt ol / Giriş yap
3. ✅ Console'u izle
4. ✅ Supabase Logs'a bak
5. ✅ Kodu gir

**Console'da her şey görünecek!** 🚀

---

## 📝 Notlar

- Bu özellik **sadece development** içindir
- Production build'de **otomatik olarak devre dışı** kalır
- Güvenlik riski yoktur
- Supabase OTP'yi backend'de oluşturur, biz sadece bilgilendirme yapıyoruz

---

**Hazırlayan:** Kiro AI Assistant  
**Tarih:** 13 Mayıs 2026  
**Durum:** ✅ Aktif ve Çalışıyor

**İYİ TESTLER! 🎉**
