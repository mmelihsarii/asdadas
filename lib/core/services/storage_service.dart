import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

/// Storage service
/// Handles all storage operations
class StorageService {
  StorageService._();

  static StorageService? _instance;
  static StorageService get instance {
    _instance ??= StorageService._();
    return _instance!;
  }

  final _supabase = SupabaseService.instance;

  /// Avatars bucket name
  static const String avatarsBucket = 'avatars';

  /// Upload avatar
  /// Returns the public URL of the uploaded file
  Future<String> uploadAvatar({
    required String userId,
    required File file,
    String? fileName,
  }) async {
    final fileExt = file.path.split('.').last;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filePath = '$userId/${fileName ?? timestamp}.$fileExt';

    await _supabase.storage.from(avatarsBucket).upload(
          filePath,
          file,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ),
        );

    return getAvatarUrl(filePath);
  }

  /// Get avatar public URL
  String getAvatarUrl(String path) {
    return _supabase.storage.from(avatarsBucket).getPublicUrl(path);
  }

  /// Delete avatar
  Future<void> deleteAvatar(String path) async {
    await _supabase.storage.from(avatarsBucket).remove([path]);
  }

  /// List user avatars
  Future<List<FileObject>> listUserAvatars(String userId) async {
    return await _supabase.storage.from(avatarsBucket).list(path: userId);
  }

  /// Upload file to custom bucket
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
    FileOptions? options,
  }) async {
    await _supabase.storage.from(bucket).upload(
          path,
          file,
          fileOptions: options ?? const FileOptions(),
        );

    return _supabase.storage.from(bucket).getPublicUrl(path);
  }

  /// Delete file from custom bucket
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    await _supabase.storage.from(bucket).remove([path]);
  }

  /// Get public URL for file
  String getPublicUrl({
    required String bucket,
    required String path,
  }) {
    return _supabase.storage.from(bucket).getPublicUrl(path);
  }
}
