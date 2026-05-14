import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repositories/users_repository.dart';
import '../../../core/services/supabase_service.dart';
import 'current_user_provider.dart';

part 'profile_edit_provider.g.dart';

@riverpod
class ProfileEdit extends _$ProfileEdit {
  @override
  FutureOr<void> build() {}

  Future<bool> updateProfile({
    required String displayName,
    required String phone,
    File? avatarFile,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repo = ref.read(usersRepositoryProvider);
      String? avatarUrl;

      // Upload avatar if provided
      if (avatarFile != null) {
        avatarUrl = await _uploadAvatar(avatarFile);
      }

      // Update user profile
      final data = <String, dynamic>{
        'display_name': displayName,
        'phone': phone,
      };

      if (avatarUrl != null) {
        data['avatar_url'] = avatarUrl;
      }

      await repo.updateProfile(data);

      // Invalidate current user to refresh
      ref.invalidate(currentUserProvider);
    });

    return !state.hasError;
  }

  Future<String> _uploadAvatar(File file) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final path = '$userId/$fileName';

    await SupabaseService.instance.storage.from('avatars').upload(path, file);

    final url = SupabaseService.instance.storage
        .from('avatars')
        .getPublicUrl(path);

    return url;
  }

  Future<File?> pickAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
