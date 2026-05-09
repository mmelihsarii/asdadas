// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
  id: json['id'] as String,
  matchId: json['match_id'] as String,
  reviewerId: json['reviewer_id'] as String,
  revieweeId: json['reviewee_id'] as String,
  stars: (json['stars'] as num).toInt(),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  comment: json['comment'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.matchId,
      'reviewer_id': instance.reviewerId,
      'reviewee_id': instance.revieweeId,
      'stars': instance.stars,
      'tags': instance.tags,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
    };
