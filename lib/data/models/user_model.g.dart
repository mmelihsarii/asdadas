// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: json['id'] as String,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  phoneVerifiedAt: json['phone_verified_at'] == null
      ? null
      : DateTime.parse(json['phone_verified_at'] as String),
  emailVerifiedAt: json['email_verified_at'] == null
      ? null
      : DateTime.parse(json['email_verified_at'] as String),
  displayName: json['display_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  birthYear: (json['birth_year'] as num?)?.toInt(),
  homeLat: (json['home_lat'] as num?)?.toDouble(),
  homeLng: (json['home_lng'] as num?)?.toDouble(),
  isAdmin: json['is_admin'] as bool? ?? false,
  isBanned: json['is_banned'] as bool? ?? false,
  kvkkAcceptedAt: json['kvkk_accepted_at'] == null
      ? null
      : DateTime.parse(json['kvkk_accepted_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'email': instance.email,
      'phone_verified_at': instance.phoneVerifiedAt?.toIso8601String(),
      'email_verified_at': instance.emailVerifiedAt?.toIso8601String(),
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'birth_year': instance.birthYear,
      'home_lat': instance.homeLat,
      'home_lng': instance.homeLng,
      'is_admin': instance.isAdmin,
      'is_banned': instance.isBanned,
      'kvkk_accepted_at': instance.kvkkAcceptedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
