# 🚨 Email Rate Limit Hatası - Çözüm Rehberi

**Hata:** `email rate limit exceeded, status code 429`  
**Sebep:** Supabase free tier'da email gönderim limiti aşıldı  
**Tarih:** 13 Mayıs 2026

---

## 🎯 Hızlı Çözümler

### ✅ Çözüm 1: Bekle (1 Saat)

Supabase free tier limitleri:
- **3-4 email / saat**
- **30 email / gün**

**Ne yapmalısın?**
- 1 saat bekle
- Tekrar dene

---

### ✅ Çözüm 2: Farklı Email Kullan

Aynı email'e çok fazla OTP gönderildi. Farklı email dene:

```
test@example.com     ❌ Rate limit
test2@example.com    ✅ Çalışır
test3@example.com    ✅ Çalışır
ahmet@example.com    ✅ Çalışır
```

---

### ✅ Çözüm 3: Supabase Dashboard'dan Rate Limit Artır

#### ADIM 1: Dashboard'a Git
```
https://app.supabase.com/project/yyqgomrvjudzduqxdsht/settings/auth
```

#### ADIM 2: Rate Limits Ayarları
```
Settings > Authentication > Rate Limits
```

#### ADIM 3: Email Rate Limit'i Artır
```
Email Rate Limit: 3/hour → 10/hour (veya daha fazla)
```

#### ADIM 4: Kaydet
```
Save butonuna bas
```

**NOT:** Free tier'da bu ayar olmayabilir. O zaman Çözüm 4'e geç.

---

### ✅ Çözüm 4: Custom SMTP Kullan (EN İYİ - Production İçin)

Supabase'in varsayılan email provider'ı çok kısıtlı. Kendi SMTP'ni kullan:

#### Önerilen SMTP Provider'lar:

1. **SendGrid** (Ücretsiz: 100 email/gün)
   - https://sendgrid.com
   - Kolay kurulum
   - Güvenilir

2. **Mailgun** (Ücretsiz: 100 email/gün)
   - https://mailgun.com
   - Hızlı
   - İyi dokümantasyon

3. **AWS SES** (Çok ucuz: $0.10/1000 email)
   - https://aws.amazon.com/ses
   - Sınırsız
   - Profesyonel

4. **Resend** (Ücretsiz: 100 email/gün)
   - https://resend.com
   - Modern
   - Developer-friendly

#### Supabase'de Custom SMTP Kurulumu:

**ADIM 1: SMTP Provider'dan Bilgileri Al**
```
SMTP Host: smtp.sendgrid.net
SMTP Port: 587
SMTP Username: apikey
SMTP Password: SG.xxxxxxxxxxxxx
```

**ADIM 2: Supabase Dashboard'a Git**
```
https://app.supabase.com/project/yyqgomrvjudzduqxdsht/settings/auth
```

**ADIM 3: SMTP Settings'i Aç**
```
Settings > Authentication > SMTP Settings
```

**ADIM 4: SMTP Bilgilerini Gir**
```
Enable Custom SMTP: ✅
SMTP Host: smtp.sendgrid.net
SMTP Port: 587
SMTP Username: apikey
SMTP Password: SG.xxxxxxxxxxxxx
Sender Email: noreply@sahada.com
Sender Name: SAHADA
```

**ADIM 5: Test Et**
```
Send Test Email butonuna bas
```

**ADIM 6: Kaydet**
```
Save butonuna bas
```

---

## 🚀 ŞİMDİ NE YAPACAKSIN?

### Seçenek A: Hızlı Test (Şimdi)
```
1. Farklı email kullan: test2@example.com
2. Veya 1 saat bekle
3. Tekrar dene
```

### Seçenek B: Kalıcı Çözüm (Production İçin)
```
1. SendGrid'e kaydol (ücretsiz)
2. API Key al
3. Supabase'de SMTP ayarla
4. Artık sınırsız email gönder
```

---

## 📊 Rate Limit Detayları

### Supabase Free Tier Limitleri:

| Özellik | Limit |
|---------|-------|
| Email / Saat | 3-4 |
| Email / Gün | 30 |
| SMS / Saat | 0 (SMS yok) |
| Auth Requests / Saat | 100 |

### Custom SMTP ile:

| Özellik | Limit |
|---------|-------|
| Email / Saat | Sınırsız* |
| Email / Gün | Provider'a göre |
| SMS / Saat | Provider'a göre |
| Auth Requests / Saat | 100 (değişmez) |

*Provider'ın limitine bağlı

---

## 🐛 Sorun Giderme

### Hala Rate Limit Alıyorsan:

1. **Farklı email dene:**
   ```
   test@example.com → test2@example.com
   ```

2. **Cache temizle:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

3. **Supabase Dashboard'da kontrol et:**
   ```
   Authentication > Users
   Kaç tane user var? Hepsini sil ve tekrar dene
   ```

4. **1 saat bekle:**
   ```
   Rate limit saatlik resetlenir
   ```

---

## 💡 Development İçin İpuçları

### 1. Test Email'leri Sil
```
Supabase Dashboard > Authentication > Users
Test kullanıcılarını sil (test@, test2@, vb.)
```

### 2. Tek Email Kullan
```
Aynı email'i tekrar tekrar kullanma
Her test için farklı email kullan
```

### 3. OTP'yi Kaydet
```
Bir kere OTP al
Birden fazla kez doğrula (aynı OTP 60 saniye geçerli)
```

### 4. Local Development Kullan
```bash
# Supabase CLI kur
npm install -g supabase

# Local Supabase başlat
supabase start

# Inbucket'ta email'leri gör
http://localhost:54324
```

---

## 🎉 Özet

**Rate Limit Hatası Aldın:**
- ✅ Normal, çok fazla OTP gönderdin
- ✅ 1 saat bekle veya farklı email kullan
- ✅ Production için custom SMTP kullan

**Hızlı Çözüm:**
```
Farklı email: test2@example.com
```

**Kalıcı Çözüm:**
```
SendGrid + Custom SMTP
```

---

## 📞 Yardım

**Supabase Docs:**
- https://supabase.com/docs/guides/auth/auth-smtp

**SendGrid Kurulum:**
- https://docs.sendgrid.com/for-developers/sending-email/integrating-with-the-smtp-api

**Mailgun Kurulum:**
- https://documentation.mailgun.com/en/latest/quickstart-sending.html

---

**Hazırlayan:** Kiro AI Assistant  
**Tarih:** 13 Mayıs 2026

**ŞİMDİ FARKLI BİR EMAIL DENE! 🚀**
