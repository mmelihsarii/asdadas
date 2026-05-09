import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'player_listing_model.freezed.dart';
part 'player_listing_model.g.dart';

@freezed
class PlayerListing with _$PlayerListing {
  const factory PlayerListing({
    required String id,
    @JsonKey(name: 'player_id') required String playerId,
    String? notes,
    @JsonKey(name: 'center_lat') required double centerLat,
    @JsonKey(name: 'center_lng') required double centerLng,
    @JsonKey(name: 'radius_km') @Default(10) int radiusKm,
    @JsonKey(name: 'available_start') required DateTime availableStart,
    @JsonKey(name: 'available_end') required DateTime availableEnd,
    @Default([]) List<PositionType> positions,
    @JsonKey(name: 'skill_level') required SkillLevel skillLevel,
    @JsonKey(name: 'preferred_formats') @Default([]) List<MatchFormat> preferredFormats,
    @JsonKey(name: 'ask_price') @Default(0) int askPrice,
    @Default(ListingStatus.open) ListingStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _PlayerListing;

  factory PlayerListing.fromJson(Map<String, dynamic> json) =>
      _$PlayerListingFromJson(json);
}
