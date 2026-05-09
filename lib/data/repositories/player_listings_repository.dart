import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../models/models.dart';

part 'player_listings_repository.g.dart';

@riverpod
PlayerListingsRepository playerListingsRepository(
  PlayerListingsRepositoryRef ref,
) {
  return PlayerListingsRepository();
}

class PlayerListingsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Create a new player listing
  Future<PlayerListing> create(Map<String, dynamic> data) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    data['player_id'] = userId;

    final response = await _supabase
        .from('player_listings')
        .insert(data)
        .select()
        .single();

    return PlayerListing.fromJson(response);
  }

  /// Get my player listings
  Future<List<PlayerListing>> getMyListings() async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    final response = await _supabase
        .from('player_listings')
        .select()
        .eq('player_id', userId)
        .order('available_start', ascending: false);

    return (response as List)
        .map((json) => PlayerListing.fromJson(json))
        .toList();
  }

  /// Get player listing by ID
  Future<PlayerListing> getOne(String id) async {
    final response = await _supabase
        .from('player_listings')
        .select()
        .eq('id', id)
        .single();

    return PlayerListing.fromJson(response);
  }

  /// Update player listing
  Future<PlayerListing> update(String id, Map<String, dynamic> data) async {
    final response = await _supabase
        .from('player_listings')
        .update(data)
        .eq('id', id)
        .select()
        .single();

    return PlayerListing.fromJson(response);
  }

  /// Cancel player listing
  Future<void> cancel(String id) async {
    await _supabase
        .from('player_listings')
        .update({'status': 'CANCELED'})
        .eq('id', id);
  }

  /// Get nearby players (alias for searchNearby)
  Future<List<PlayerListing>> getNearby({
    required double lat,
    required double lng,
    double radiusKm = 10,
    SkillLevel? skillLevel,
    List<PositionType>? positions,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return searchNearby(
      lat: lat,
      lng: lng,
      radiusKm: radiusKm.toInt(),
      skillLevel: skillLevel,
      positions: positions,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Search nearby players
  Future<List<PlayerListing>> searchNearby({
    required double lat,
    required double lng,
    int radiusKm = 10,
    SkillLevel? skillLevel,
    List<PositionType>? positions,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Use RPC function for nearby search
    var response = await _supabase.rpc(
      'nearby_players',
      params: {'p_lat': lat, 'p_lng': lng, 'p_radius_km': radiusKm},
    );

    var players = (response as List)
        .map((json) => PlayerListing.fromJson(json))
        .toList();

    // Apply additional filters
    if (skillLevel != null) {
      players = players.where((p) => p.skillLevel == skillLevel).toList();
    }

    if (positions != null && positions.isNotEmpty) {
      players = players.where((p) {
        return p.positions.any((pos) => positions.contains(pos));
      }).toList();
    }

    if (startDate != null) {
      players = players
          .where((p) => p.availableStart.isAfter(startDate))
          .toList();
    }

    if (endDate != null) {
      players = players.where((p) => p.availableEnd.isBefore(endDate)).toList();
    }

    return players;
  }

  /// Get all open player listings (for explore)
  Future<List<PlayerListing>> getOpenListings({
    int limit = 50,
    int offset = 0,
  }) async {
    final response = await _supabase
        .from('player_listings')
        .select()
        .eq('status', 'OPEN')
        .gte('available_start', DateTime.now().toIso8601String())
        .order('available_start', ascending: true)
        .range(offset, offset + limit - 1);

    return (response as List)
        .map((json) => PlayerListing.fromJson(json))
        .toList();
  }
}
