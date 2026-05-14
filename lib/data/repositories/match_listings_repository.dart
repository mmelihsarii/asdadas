import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/app_exception.dart';
import '../models/models.dart';

part 'match_listings_repository.g.dart';

@riverpod
MatchListingsRepository matchListingsRepository(
  MatchListingsRepositoryRef ref,
) {
  return MatchListingsRepository();
}

class MatchListingsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Create a new match listing
  Future<MatchListing> create(Map<String, dynamic> data) async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      data['organizer_id'] = userId;

      final response = await _supabase
          .from('match_listings')
          .insert(data)
          .select()
          .single();

      return MatchListing.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get my match listings (as organizer)
  Future<List<MatchListing>> getMyListings() async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      final response = await _supabase
          .from('match_listings')
          .select()
          .eq('organizer_id', userId)
          .order('starts_at', ascending: false);

      return (response as List)
          .map((json) => MatchListing.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get all active match listings
  Future<List<MatchListing>> getAllActive() async {
    try {
      final response = await _supabase
          .from('match_listings')
          .select()
          .eq('status', 'OPEN')
          .gte('starts_at', DateTime.now().toIso8601String())
          .order('starts_at', ascending: true)
          .limit(100);

      return (response as List)
          .map((json) => MatchListing.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get match listing by ID
  Future<MatchListing> getOne(String id) async {
    try {
      final response = await _supabase
          .from('match_listings')
          .select()
          .eq('id', id)
          .single();

      return MatchListing.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Update match listing
  Future<MatchListing> update(String id, Map<String, dynamic> data) async {
    try {
      final response = await _supabase
          .from('match_listings')
          .update(data)
          .eq('id', id)
          .select()
          .single();

      return MatchListing.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Cancel match listing
  Future<void> cancel(String id) async {
    try {
      await _supabase
          .from('match_listings')
          .update({'status': 'CANCELED'})
          .eq('id', id);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Complete match listing
  Future<MatchListing> complete(String id) async {
    try {
      final response = await _supabase
          .from('match_listings')
          .update({'status': 'COMPLETED'})
          .eq('id', id)
          .select()
          .single();

      return MatchListing.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get match roster (participations)
  Future<List<Participation>> getRoster(String matchId) async {
    try {
      final response = await _supabase
          .from('participations')
          .select()
          .eq('match_id', matchId)
          .eq('status', 'ACCEPTED');

      return (response as List)
          .map((json) => Participation.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Kick player from match
  Future<void> kickPlayer(String matchId, String playerId) async {
    try {
      await _supabase
          .from('participations')
          .update({'status': 'KICKED'})
          .eq('match_id', matchId)
          .eq('player_id', playerId);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get nearby matches (alias for searchNearby)
  Future<List<MatchListing>> getNearby({
    required double lat,
    required double lng,
    double radiusKm = 10,
    MatchFormat? format,
    SkillLevel? skillLevel,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return searchNearby(
      lat: lat,
      lng: lng,
      radiusKm: radiusKm.toInt(),
      format: format,
      skillLevel: skillLevel,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Search nearby matches
  Future<List<MatchListing>> searchNearby({
    required double lat,
    required double lng,
    int radiusKm = 10,
    MatchFormat? format,
    SkillLevel? skillLevel,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Use RPC function for nearby search
      var response = await _supabase.rpc(
        'nearby_matches',
        params: {'p_lat': lat, 'p_lng': lng, 'p_radius_km': radiusKm},
      );

      var matches = (response as List)
          .map((json) => MatchListing.fromJson(json))
          .toList();

      // Apply additional filters
      if (format != null) {
        matches = matches.where((m) => m.format == format).toList();
      }

      if (skillLevel != null) {
        matches = matches.where((m) => m.skillLevel == skillLevel).toList();
      }

      if (startDate != null) {
        matches = matches.where((m) => m.startsAt.isAfter(startDate)).toList();
      }

      if (endDate != null) {
        matches = matches.where((m) => m.startsAt.isBefore(endDate)).toList();
      }

      return matches;
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get all open matches (for explore)
  Future<List<MatchListing>> getOpenMatches({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await _supabase
          .from('match_listings')
          .select()
          .eq('status', 'OPEN')
          .gte('starts_at', DateTime.now().toIso8601String())
          .order('starts_at', ascending: true)
          .range(offset, offset + limit - 1);

      return (response as List)
          .map((json) => MatchListing.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }
}
