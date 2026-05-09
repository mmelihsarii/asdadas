import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'match_listing_model.freezed.dart';
part 'match_listing_model.g.dart';

@freezed
class MatchListing with _$MatchListing {
  const factory MatchListing({
    required String id,
    @JsonKey(name: 'organizer_id') required String organizerId,
    required String title,
    String? description,
    @JsonKey(name: 'pitch_name') required String pitchName,
    required double lat,
    required double lng,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    required MatchFormat format,
    @JsonKey(name: 'needed_count') required int neededCount,
    @JsonKey(name: 'needed_positions') @Default([]) List<PositionType> neededPositions,
    @JsonKey(name: 'skill_level') required SkillLevel skillLevel,
    @JsonKey(name: 'price_type') required PriceType priceType,
    @JsonKey(name: 'base_price') @Default(0) int basePrice,
    @JsonKey(name: 'negotiation_enabled') @Default(false) bool negotiationEnabled,
    @JsonKey(name: 'cancel_window_hours') @Default(2) int cancelWindowHours,
    @JsonKey(name: 'late_tolerance_min') @Default(15) int lateToleranceMin,
    @JsonKey(name: 'payment_method') @Default(PaymentMethod.cash) PaymentMethod paymentMethod,
    @JsonKey(name: 'min_quality_score') @Default(0.0) double minQualityScore,
    @JsonKey(name: 'cancellation_level') @Default(CancellationLevel.medium) CancellationLevel cancellationLevel,
    @Default(ListingStatus.open) ListingStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _MatchListing;

  factory MatchListing.fromJson(Map<String, dynamic> json) =>
      _$MatchListingFromJson(json);
}
