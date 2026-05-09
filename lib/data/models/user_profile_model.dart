import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'skill_level') @Default(SkillLevel.beginner) SkillLevel skillLevel,
    @Default([]) List<PositionType> positions,
    String? bio,
    @JsonKey(name: 'matches_played_count') @Default(0) int matchesPlayedCount,
    @JsonKey(name: 'rating_avg') @Default(0.0) double ratingAvg,
    @JsonKey(name: 'rating_count') @Default(0) int ratingCount,
    @JsonKey(name: 'no_show_count') @Default(0) int noShowCount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
