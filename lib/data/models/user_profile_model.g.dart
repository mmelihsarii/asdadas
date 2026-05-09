// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      skillLevel:
          $enumDecodeNullable(_$SkillLevelEnumMap, json['skill_level']) ??
          SkillLevel.beginner,
      positions:
          (json['positions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PositionTypeEnumMap, e))
              .toList() ??
          const [],
      bio: json['bio'] as String?,
      matchesPlayedCount: (json['matches_played_count'] as num?)?.toInt() ?? 0,
      ratingAvg: (json['rating_avg'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (json['rating_count'] as num?)?.toInt() ?? 0,
      noShowCount: (json['no_show_count'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'skill_level': _$SkillLevelEnumMap[instance.skillLevel]!,
      'positions': instance.positions
          .map((e) => _$PositionTypeEnumMap[e]!)
          .toList(),
      'bio': instance.bio,
      'matches_played_count': instance.matchesPlayedCount,
      'rating_avg': instance.ratingAvg,
      'rating_count': instance.ratingCount,
      'no_show_count': instance.noShowCount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$SkillLevelEnumMap = {
  SkillLevel.beginner: 'BEGINNER',
  SkillLevel.intermediate: 'INTERMEDIATE',
  SkillLevel.advanced: 'ADVANCED',
};

const _$PositionTypeEnumMap = {
  PositionType.goalkeeper: 'GOALKEEPER',
  PositionType.defender: 'DEFENDER',
  PositionType.midfielder: 'MIDFIELDER',
  PositionType.forward: 'FORWARD',
  PositionType.any: 'ANY',
};
