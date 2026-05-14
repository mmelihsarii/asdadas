import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    String? phone, // artık optional
    String? email,
    @JsonKey(name: 'phone_verified_at') DateTime? phoneVerifiedAt,
    @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'birth_year') int? birthYear,
    @JsonKey(name: 'home_lat') double? homeLat,
    @JsonKey(name: 'home_lng') double? homeLng,
    @JsonKey(name: 'is_admin') @Default(false) bool isAdmin,
    @JsonKey(name: 'is_banned') @Default(false) bool isBanned,
    @JsonKey(name: 'kvkk_accepted_at') DateTime? kvkkAcceptedAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
