// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchListingImpl _$$MatchListingImplFromJson(Map<String, dynamic> json) =>
    _$MatchListingImpl(
      id: json['id'] as String,
      organizerId: json['organizer_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      pitchName: json['pitch_name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      startsAt: DateTime.parse(json['starts_at'] as String),
      format: $enumDecode(_$MatchFormatEnumMap, json['format']),
      neededCount: (json['needed_count'] as num).toInt(),
      neededPositions:
          (json['needed_positions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PositionTypeEnumMap, e))
              .toList() ??
          const [],
      skillLevel: $enumDecode(_$SkillLevelEnumMap, json['skill_level']),
      priceType: $enumDecode(_$PriceTypeEnumMap, json['price_type']),
      basePrice: (json['base_price'] as num?)?.toInt() ?? 0,
      negotiationEnabled: json['negotiation_enabled'] as bool? ?? false,
      cancelWindowHours: (json['cancel_window_hours'] as num?)?.toInt() ?? 2,
      lateToleranceMin: (json['late_tolerance_min'] as num?)?.toInt() ?? 15,
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']) ??
          PaymentMethod.cash,
      minQualityScore: (json['min_quality_score'] as num?)?.toDouble() ?? 0.0,
      cancellationLevel:
          $enumDecodeNullable(
            _$CancellationLevelEnumMap,
            json['cancellation_level'],
          ) ??
          CancellationLevel.medium,
      status:
          $enumDecodeNullable(_$ListingStatusEnumMap, json['status']) ??
          ListingStatus.open,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MatchListingImplToJson(
  _$MatchListingImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'organizer_id': instance.organizerId,
  'title': instance.title,
  'description': instance.description,
  'pitch_name': instance.pitchName,
  'lat': instance.lat,
  'lng': instance.lng,
  'starts_at': instance.startsAt.toIso8601String(),
  'format': _$MatchFormatEnumMap[instance.format]!,
  'needed_count': instance.neededCount,
  'needed_positions': instance.neededPositions
      .map((e) => _$PositionTypeEnumMap[e]!)
      .toList(),
  'skill_level': _$SkillLevelEnumMap[instance.skillLevel]!,
  'price_type': _$PriceTypeEnumMap[instance.priceType]!,
  'base_price': instance.basePrice,
  'negotiation_enabled': instance.negotiationEnabled,
  'cancel_window_hours': instance.cancelWindowHours,
  'late_tolerance_min': instance.lateToleranceMin,
  'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod]!,
  'min_quality_score': instance.minQualityScore,
  'cancellation_level': _$CancellationLevelEnumMap[instance.cancellationLevel]!,
  'status': _$ListingStatusEnumMap[instance.status]!,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$MatchFormatEnumMap = {
  MatchFormat.fiveVsFive: 'FIVE_VS_FIVE',
  MatchFormat.sixVsSix: 'SIX_VS_SIX',
  MatchFormat.sevenVsSeven: 'SEVEN_VS_SEVEN',
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

const _$PriceTypeEnumMap = {PriceType.free: 'FREE', PriceType.paid: 'PAID'};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'CASH',
  PaymentMethod.iban: 'IBAN',
};

const _$CancellationLevelEnumMap = {
  CancellationLevel.flexible: 'FLEXIBLE',
  CancellationLevel.medium: 'MEDIUM',
  CancellationLevel.strict: 'STRICT',
};

const _$ListingStatusEnumMap = {
  ListingStatus.open: 'OPEN',
  ListingStatus.filled: 'FILLED',
  ListingStatus.completed: 'COMPLETED',
  ListingStatus.canceled: 'CANCELED',
};
