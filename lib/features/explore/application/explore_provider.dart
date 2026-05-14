import 'dart:math' as math;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/match_listings_repository.dart';
import '../../../data/repositories/player_listings_repository.dart';

part 'explore_provider.g.dart';

/// Combined listing type for explore screen
class ExploreListing {
  final String id;
  final String type; // 'match' or 'player'
  final String title;
  final String location;
  final DateTime? dateTime;
  final double? lat;
  final double? lng;
  final int? playersNeeded;
  final String? position;
  final dynamic originalData; // MatchListing or PlayerListing

  ExploreListing({
    required this.id,
    required this.type,
    required this.title,
    required this.location,
    this.dateTime,
    this.lat,
    this.lng,
    this.playersNeeded,
    this.position,
    this.originalData,
  });

  factory ExploreListing.fromMatchListing(MatchListing match) {
    return ExploreListing(
      id: match.id,
      type: 'match',
      title: match.title,
      location: match.pitchName,
      dateTime: match.startsAt,
      lat: match.lat,
      lng: match.lng,
      playersNeeded: match.neededCount,
      originalData: match,
    );
  }

  factory ExploreListing.fromPlayerListing(PlayerListing player) {
    // Get first position if available
    final position = player.positions.isNotEmpty
        ? player.positions.first.toString().split('.').last
        : null;

    return ExploreListing(
      id: player.id,
      type: 'player',
      title: 'Oyuncu Arıyor${position != null ? " - $position" : ""}',
      location: 'Merkez konum (${player.radiusKm}km)',
      dateTime: player.availableStart,
      lat: player.centerLat,
      lng: player.centerLng,
      position: position,
      originalData: player,
    );
  }
}

/// Provider for all listings (matches + players)
@riverpod
Future<List<ExploreListing>> allListings(AllListingsRef ref) async {
  final matchListingsRepo = ref.watch(matchListingsRepositoryProvider);
  final playerListingsRepo = ref.watch(playerListingsRepositoryProvider);

  // Fetch both in parallel
  final results = await Future.wait([
    matchListingsRepo.getAllActive(),
    playerListingsRepo.getAllActive(),
  ]);

  final matchListings = results[0] as List<MatchListing>;
  final playerListings = results[1] as List<PlayerListing>;

  // Convert to ExploreListing
  final allListings = <ExploreListing>[
    ...matchListings.map((m) => ExploreListing.fromMatchListing(m)),
    ...playerListings.map((p) => ExploreListing.fromPlayerListing(p)),
  ];

  // Sort by date (newest first)
  allListings.sort((a, b) {
    final aDate = a.dateTime ?? DateTime.now();
    final bDate = b.dateTime ?? DateTime.now();
    return bDate.compareTo(aDate);
  });

  return allListings;
}

/// Provider for match listings only
@riverpod
Future<List<ExploreListing>> matchListings(MatchListingsRef ref) async {
  final repo = ref.watch(matchListingsRepositoryProvider);
  final matches = await repo.getAllActive();

  return matches.map((m) => ExploreListing.fromMatchListing(m)).toList()
    ..sort((a, b) {
      final aDate = a.dateTime ?? DateTime.now();
      final bDate = b.dateTime ?? DateTime.now();
      return bDate.compareTo(aDate);
    });
}

/// Provider for player listings only
@riverpod
Future<List<ExploreListing>> playerListings(PlayerListingsRef ref) async {
  final repo = ref.watch(playerListingsRepositoryProvider);
  final players = await repo.getAllActive();

  return players.map((p) => ExploreListing.fromPlayerListing(p)).toList()
    ..sort((a, b) {
      final aDate = a.dateTime ?? DateTime.now();
      final bDate = b.dateTime ?? DateTime.now();
      return bDate.compareTo(aDate);
    });
}

/// Provider for filtered listings based on type
@riverpod
Future<List<ExploreListing>> filteredListings(
  FilteredListingsRef ref,
  String filterType, // 'all', 'matches', 'players'
) async {
  if (filterType == 'matches') {
    return ref.watch(matchListingsProvider.future);
  } else if (filterType == 'players') {
    return ref.watch(playerListingsProvider.future);
  } else {
    return ref.watch(allListingsProvider.future);
  }
}

/// Provider for nearby listings (within radius)
@riverpod
Future<List<ExploreListing>> nearbyListings(
  NearbyListingsRef ref, {
  required double userLat,
  required double userLng,
  double radiusKm = 10.0,
}) async {
  final allListings = await ref.watch(allListingsProvider.future);

  // Filter by distance
  return allListings.where((listing) {
    if (listing.lat == null || listing.lng == null) return false;

    final distance = _calculateDistance(
      userLat,
      userLng,
      listing.lat!,
      listing.lng!,
    );

    return distance <= radiusKm;
  }).toList();
}

/// Calculate distance between two coordinates (Haversine formula)
double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // km

  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);

  final a =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(_toRadians(lat1)) *
          math.cos(_toRadians(lat2)) *
          math.pow(math.sin(dLon / 2), 2);

  final c = 2 * math.asin(math.sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degrees) {
  return degrees * (math.pi / 180.0);
}
