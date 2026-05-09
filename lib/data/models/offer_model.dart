import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'offer_model.freezed.dart';
part 'offer_model.g.dart';

@freezed
class Offer with _$Offer {
  const factory Offer({
    required String id,
    @JsonKey(name: 'from_user_id') required String fromUserId,
    @JsonKey(name: 'to_user_id') required String toUserId,
    @JsonKey(name: 'match_listing_id') String? matchListingId,
    @JsonKey(name: 'player_listing_id') String? playerListingId,
    required int amount,
    @Default(OfferStatus.sent) OfferStatus status,
    @JsonKey(name: 'counter_count') @Default(0) int counterCount,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
}
