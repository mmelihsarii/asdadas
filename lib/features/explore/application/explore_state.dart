import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/match_listing_model.dart';
import '../../../data/models/player_listing_model.dart';

part 'explore_state.freezed.dart';

enum ExploreViewMode { map, list }

enum ExploreListingType { all, matches, players }

@freezed
class ExploreState with _$ExploreState {
  const factory ExploreState({
    @Default([]) List<MatchListing> matchListings,
    @Default([]) List<PlayerListing> playerListings,
    @Default(ExploreViewMode.map) ExploreViewMode viewMode,
    @Default(ExploreListingType.all) ExploreListingType listingType,
    @Default(false) bool isLoading,
    String? error,
    double? userLat,
    double? userLng,
    @Default(10.0) double radiusKm,
  }) = _ExploreState;
}
