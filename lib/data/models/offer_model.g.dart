// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfferImpl _$$OfferImplFromJson(Map<String, dynamic> json) => _$OfferImpl(
  id: json['id'] as String,
  fromUserId: json['from_user_id'] as String,
  toUserId: json['to_user_id'] as String,
  matchListingId: json['match_listing_id'] as String?,
  playerListingId: json['player_listing_id'] as String?,
  amount: (json['amount'] as num).toInt(),
  status:
      $enumDecodeNullable(_$OfferStatusEnumMap, json['status']) ??
      OfferStatus.sent,
  counterCount: (json['counter_count'] as num?)?.toInt() ?? 0,
  expiresAt: DateTime.parse(json['expires_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$OfferImplToJson(_$OfferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_user_id': instance.fromUserId,
      'to_user_id': instance.toUserId,
      'match_listing_id': instance.matchListingId,
      'player_listing_id': instance.playerListingId,
      'amount': instance.amount,
      'status': _$OfferStatusEnumMap[instance.status]!,
      'counter_count': instance.counterCount,
      'expires_at': instance.expiresAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$OfferStatusEnumMap = {
  OfferStatus.sent: 'SENT',
  OfferStatus.countered: 'COUNTERED',
  OfferStatus.accepted: 'ACCEPTED',
  OfferStatus.rejected: 'REJECTED',
  OfferStatus.expired: 'EXPIRED',
};
