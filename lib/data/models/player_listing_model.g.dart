// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerListingImpl _$$PlayerListingImplFromJson(Map<String, dynamic> json) =>
    _$PlayerListingImpl(
      id: json['id'] as String,
      playerId: json['player_id'] as String,
      notes: json['notes'] as String?,
      centerLat: (json['center_lat'] as num).toDouble(),
      centerLng: (json['center_lng'] as num).toDouble(),
      radiusKm: (json['radius_km'] as num?)?.toInt() ?? 10,
      availableStart: DateTime.parse(json['available_start'] as String),
      availableEnd: DateTime.parse(json['available_end'] as String),
      positions:
          (json['positions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PositionTypeEnumMap, e))
              .toList() ??
          const [],
      skillLevel: $enumDecode(_$SkillLevelEnumMap, json['skill_level']),
      preferredFormats:
          (json['preferred_formats'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MatchFormatEnumMap, e))
              .toList() ??
          const [],
      askPrice: (json['ask_price'] as num?)?.toInt() ?? 0,
      status:
          $enumDecodeNullable(_$ListingStatusEnumMap, json['status']) ??
          ListingStatus.open,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PlayerListingImplToJson(_$PlayerListingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'player_id': instance.playerId,
      'notes': instance.notes,
      'center_lat': instance.centerLat,
      'center_lng': instance.centerLng,
      'radius_km': instance.radiusKm,
      'available_start': instance.availableStart.toIso8601String(),
      'available_end': instance.availableEnd.toIso8601String(),
      'positions': instance.positions
          .map((e) => _$PositionTypeEnumMap[e]!)
          .toList(),
      'skill_level': _$SkillLevelEnumMap[instance.skillLevel]!,
      'preferred_formats': instance.preferredFormats
          .map((e) => _$MatchFormatEnumMap[e]!)
          .toList(),
      'ask_price': instance.askPrice,
      'status': _$ListingStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$PositionTypeEnumMap = {
  PositionType.goalkeeper: 'GOALKEEPER',
  PositionType.defender: 'DEFENDER',
  PositionType.midfielder: 'MIDFIELDER',
  PositionType.forward: 'FORWARD',
  PositionType.any: 'ANY',
};

const _$SkillLevelEnumMap = {
  SkillLevel.beginner: 'BEGINNER',
  SkillLevel.intermediate: 'INTERMEDIATE',
  SkillLevel.advanced: 'ADVANCED',
};

const _$MatchFormatEnumMap = {
  MatchFormat.fiveVsFive: 'FIVE_VS_FIVE',
  MatchFormat.sixVsSix: 'SIX_VS_SIX',
  MatchFormat.sevenVsSeven: 'SEVEN_VS_SEVEN',
};

const _$ListingStatusEnumMap = {
  ListingStatus.open: 'OPEN',
  ListingStatus.filled: 'FILLED',
  ListingStatus.completed: 'COMPLETED',
  ListingStatus.canceled: 'CANCELED',
};
