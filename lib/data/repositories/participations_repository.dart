import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../models/models.dart';

part 'participations_repository.g.dart';

@riverpod
ParticipationsRepository participationsRepository(ParticipationsRepositoryRef ref) {
  return ParticipationsRepository();
}

class ParticipationsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Get my participations (matches I'm playing in)
  Future<List<Participation>> getMyParticipations() async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    final response = await _supabase
        .from('participations')
        .select()
        .eq('player_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Participation.fromJson(json))
        .toList();
  }

  /// Leave a match
  Future<void> leave(String participationId) async {
    await _supabase
        .from('participations')
        .update({'status': 'LEFT'})
        .eq('id', participationId);
  }

  /// Get participations for a match
  Future<List<Participation>> getParticipationsForMatch(String matchId) async {
    final response = await _supabase
        .from('participations')
        .select()
        .eq('match_id', matchId)
        .order('created_at', ascending: true);

    return (response as List)
        .map((json) => Participation.fromJson(json))
        .toList();
  }

  /// Check if user is participating in a match
  Future<bool> isParticipating(String matchId) async {
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
  }
}
