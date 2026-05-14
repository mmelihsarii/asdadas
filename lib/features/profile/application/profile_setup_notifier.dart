import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahada_dev/core/services/storage_service.dart';
import 'package:sahada_dev/data/repositories/users_repository.dart';
import 'package:sahada_dev/data/models/enums.dart';
import 'package:sahada_dev/features/profile/application/profile_setup_state.dart';

final profileSetupNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileSetupNotifier, ProfileSetupState>((
      ref,
    ) {
      return ProfileSetupNotifier(
        ref.read(usersRepositoryProvider),
        StorageService.instance,
      );
    });

class ProfileSetupNotifier extends StateNotifier<ProfileSetupState> {
  ProfileSetupNotifier(this._usersRepository, this._storageService)
    : super(const ProfileSetupState());

  final UsersRepository _usersRepository;
  final StorageService _storageService;
  final _imagePicker = ImagePicker();

  void setDisplayName(String value) {
    state = state.copyWith(displayName: value);
  }

  void setBirthDate(DateTime? date) {
    state = state.copyWith(birthDate: date);
  }

  void setSkillLevel(SkillLevel? level) {
    state = state.copyWith(skillLevel: level);
  }

  void togglePosition(PositionType position) {
    final positions = List<PositionType>.from(state.selectedPositions);
    if (positions.contains(position)) {
      positions.remove(position);
    } else {
      positions.add(position);
    }
    state = state.copyWith(selectedPositions: positions);
  }

  void setHomeLocation(double lat, double lng) {
    state = state.copyWith(homeLat: lat, homeLng: lng);
  }

  void setKvkkAccepted(bool value) {
    state = state.copyWith(kvkkAccepted: value);
  }

  Future<void> pickAvatar() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        state = state.copyWith(avatarFile: File(image.path));
      }
    } catch (e) {
      state = state.copyWith(error: 'Resim seçilemedi: ${e.toString()}');
    }
  }

  Future<bool> submit() async {
    // Validation
    if (state.displayName.trim().isEmpty) {
      state = state.copyWith(error: 'Kullanıcı adı gereklidir');
      return false;
    }

    if (state.birthDate == null) {
      state = state.copyWith(error: 'Doğum tarihi gereklidir');
      return false;
    }

    if (state.selectedPositions.isEmpty) {
      state = state.copyWith(error: 'En az bir mevki seçmelisiniz');
      return false;
    }

    if (state.skillLevel == null) {
      state = state.copyWith(error: 'Seviye seçmelisiniz');
      return false;
    }

    if (state.homeLat == null || state.homeLng == null) {
      state = state.copyWith(error: 'Ev konumu seçmelisiniz');
      return false;
    }

    if (!state.kvkkAccepted) {
      state = state.copyWith(error: 'KVKK metnini kabul etmelisiniz');
      return false;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Get current user
      final currentUser = await _usersRepository.getCurrentUser();
      if (currentUser == null) {
        throw Exception('Kullanıcı bulunamadı');
      }

      String? avatarUrl;

      // Upload avatar if selected
      if (state.avatarFile != null) {
        avatarUrl = await _storageService.uploadAvatar(
          userId: currentUser.id,
          file: state.avatarFile!,
        );
      }

      final birthYear = state.birthDate!.year;

      // Update user profile
      await _usersRepository.updateProfile({
        'display_name': state.displayName.trim(),
        'birth_year': birthYear,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        'home_lat': state.homeLat,
        'home_lng': state.homeLng,
        'kvkk_accepted_at': DateTime.now().toIso8601String(),
      });

      // Create user_profile entry
      await _usersRepository.upsertUserProfile({
        'skill_level': state.skillLevel!.name.toUpperCase(),
        'positions': state.selectedPositions
            .map((p) => p.name.toUpperCase())
            .toList(),
      });

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'Güncelleme başarısız: ${e.toString()}',
        isLoading: false,
      );
      return false;
    }
  }
}
