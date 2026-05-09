# Storage Buckets

Bu klasör Supabase Storage bucket yapılandırmalarını içerir.

## Mevcut Bucket'lar

### 1. avatars
- **Amaç**: Kullanıcı profil fotoğrafları
- **Public**: Evet
- **Dosya Boyutu Limiti**: 2MB
- **İzin Verilen Formatlar**: jpg, jpeg, png, webp
- **Klasör Yapısı**: `{user_id}/{filename}.{ext}`

## Bucket Oluşturma (Supabase Dashboard)

1. Storage > Create Bucket
2. Bucket adı: `avatars`
3. Public bucket: ✅ Aktif
4. File size limit: 2097152 (2MB)
5. Allowed MIME types: `image/jpeg,image/jpg,image/png,image/webp`

## Storage Policies

### avatars bucket policies:

```sql
-- Allow authenticated users to upload their own avatars
CREATE POLICY "Users can upload their own avatar"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Allow authenticated users to update their own avatars
CREATE POLICY "Users can update their own avatar"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Allow authenticated users to delete their own avatars
CREATE POLICY "Users can delete their own avatar"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'avatars' 
  AND (storage.foldername(name))[1] = auth.uid()::text
);

-- Allow public read access to avatars
CREATE POLICY "Public can view avatars"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'avatars');
```

## Yeni Bucket Ekleme

1. Supabase Dashboard'dan bucket oluştur
2. Bu klasöre README güncellemesi ekle
3. Storage policies'i SQL Editor'dan çalıştır
4. Flutter'da StorageService'e yeni metodlar ekle
