import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/enums.dart';

part 'profile_setup_state.freezed.dart';

@freezed
class ProfileSetupState with _$ProfileSetupState {
  const factory ProfileSetupState({
    @Default('') String displayName,
    DateTime? birthDate,
    File? avatarFile,
    String? avatarUrl,
    @Default([]) List<PositionType> selectedPositions,
    SkillLevel? skillLevel,
    double? homeLat,
    double? homeLng,
    @Default(false) bool kvkkAccepted,
    @Default(false) bool isLoading,
    String? error,
  }) = _ProfileSetupState;
}
