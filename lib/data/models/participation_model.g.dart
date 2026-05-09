// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParticipationImpl _$$ParticipationImplFromJson(Map<String, dynamic> json) =>
    _$ParticipationImpl(
      id: json['id'] as String,
      matchId: json['match_id'] as String,
      playerId: json['player_id'] as String,
      agreedAmount: (json['agreed_amount'] as num).toInt(),
      status:
          $enumDecodeNullable(_$ParticipationStatusEnumMap, json['status']) ??
          ParticipationStatus.accepted,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ParticipationImplToJson(_$ParticipationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'match_id': instance.matchId,
      'player_id': instance.playerId,
      'agreed_amount': instance.agreedAmount,
      'status': _$ParticipationStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$ParticipationStatusEnumMap = {
  ParticipationStatus.accepted: 'ACCEPTED',
  ParticipationStatus.left: 'LEFT',
  ParticipationStatus.kicked: 'KICKED',
};
