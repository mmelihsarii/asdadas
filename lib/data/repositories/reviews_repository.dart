import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../models/models.dart';

part 'reviews_repository.g.dart';

@riverpod
ReviewsRepository reviewsRepository(ReviewsRepositoryRef ref) {
  return ReviewsRepository();
}

class ReviewsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Create a review
  Future<Review> create(Map<String, dynamic> data) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    data['reviewer_id'] = userId;

    final response = await _supabase
        .from('reviews')
        .insert(data)
        .select()
        .single();

    return Review.fromJson(response);
  }

  /// Get reviews for a user
  Future<List<Review>> getUserReviews(String userId) async {
    final response = await _supabase
        .from('reviews')
        .select()
        .eq('reviewee_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Review.fromJson(json))
        .toList();
  }

  /// Get reviews for a match
  Future<List<Review>> getMatchReviews(String matchId) async {
    final response = await _supabase
        .from('reviews')
        .select()
        .eq('match_id', matchId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => Review.fromJson(json))
        .toList();
  }

  /// Check if user has reviewed another user for a match
  Future<bool> hasReviewed({
    required String matchId,
    required String revieweeId,
  }) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) return false;

    final response = await _supabase
        .from('reviews')
        .select()
        .eq('match_id', matchId)
        .eq('reviewer_id', userId)
        .eq('reviewee_id', revieweeId)
        .maybeSingle();

    return response != null;
  }
}
