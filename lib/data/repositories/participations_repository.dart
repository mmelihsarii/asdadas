import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/app_exception.dart';
import '../models/models.dart';

part 'participations_repository.g.dart';

@riverpod
ParticipationsRepository participationsRepository(
  ParticipationsRepositoryRef ref,
) {
  return ParticipationsRepository();
}

class ParticipationsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Create a new participation (join a match)
  Future<Participation> create({
    required String matchId,
    int agreedAmount = 0,
  }) async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      final response = await _supabase
          .from('participations')
          .insert({
            'match_id': matchId,
            'player_id': userId,
            'agreed_amount': agreedAmount,
            'status': 'ACCEPTED',
          })
          .select()
          .single();

      return Participation.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get my participations (matches I'm playing in)
  Future<List<Participation>> getMyParticipations() async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      final response = await _supabase
          .from('participations')
          .select()
          .eq('player_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Participation.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Leave a match
  Future<void> leave(String participationId) async {
    try {
      await _supabase
          .from('participations')
          .update({'status': 'LEFT'})
          .eq('id', participationId);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get participations for a match
  Future<List<Participation>> getParticipationsForMatch(String matchId) async {
    try {
      final response = await _supabase
          .from('participations')
          .select()
          .eq('match_id', matchId)
          .order('created_at', ascending: true);

      return (response as List)
          .map((json) => Participation.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Check if user is participating in a match
  Future<bool> isParticipating(String matchId) async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) return false;

      final response = await _supabase
          .from('participations')
          .select()
          .eq('match_id', matchId)
          .eq('player_id', userId)
          .eq('status', 'ACCEPTED')
          .maybeSingle();

      return response != null;
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }
}
