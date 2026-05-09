import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../../../data/repositories/match_listings_repository.dart';
import '../../../data/repositories/player_listings_repository.dart';
import 'explore_state.dart';

part 'explore_notifier.g.dart';

@riverpod
class ExploreNotifier extends _$ExploreNotifier {
  @override
  ExploreState build() {
    _initializeLocation();
    return const ExploreState();
  }

  Future<void> _initializeLocation() async {
    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Use default location (Istanbul center)
        state = state.copyWith(userLat: 41.0082, userLng: 28.9784);
        await _loadListings();
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition();
      state = state.copyWith(
        userLat: position.latitude,
        userLng: position.longitude,
      );
      await _loadListings();
    } catch (e) {
      // Fallback to Istanbul
      state = state.copyWith(userLat: 41.0082, userLng: 28.9784);
      await _loadListings();
    }
  }

  Future<void> _loadListings() async {
    if (state.userLat == null || state.userLng == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final matchRepo = ref.read(matchListingsRepositoryProvider);
      final playerRepo = ref.read(playerListingsRepositoryProvider);

      // Load nearby matches and players
      final matches = await matchRepo.getNearby(
        lat: state.userLat!,
        lng: state.userLng!,
        radiusKm: state.radiusKm,
      );

      final players = await playerRepo.getNearby(
        lat: state.userLat!,
        lng: state.userLng!,
        radiusKm: state.radiusKm,
      );

      state = state.copyWith(
        matchListings: matches,
        playerListings: players,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'İlanlar yüklenirken hata oluştu: $e',
      );
    }
  }

  void setViewMode(ExploreViewMode mode) {
    state = state.copyWith(viewMode: mode);
  }

  void setListingType(ExploreListingType type) {
    state = state.copyWith(listingType: type);
  }

  void setRadius(double radiusKm) {
    state = state.copyWith(radiusKm: radiusKm);
    _loadListings();
  }

  Future<void> refresh() async {
    await _loadListings();
  }
}
