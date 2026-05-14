import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/app_exception.dart';
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
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      data['reviewer_id'] = userId;

      final response = await _supabase
          .from('reviews')
          .insert(data)
          .select()
          .single();

      return Review.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get reviews for a user
  Future<List<Review>> getUserReviews(String userId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select()
          .eq('reviewee_id', userId)
          .order('created_at', ascending: false);

      return (response as List).map((json) => Review.fromJson(json)).toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get reviews for a match
  Future<List<Review>> getMatchReviews(String matchId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select()
          .eq('match_id', matchId)
          .order('created_at', ascending: false);

      return (response as List).map((json) => Review.fromJson(json)).toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Check if user has reviewed another user for a match
  Future<bool> hasReviewed({
    required String matchId,
    required String revieweeId,
  }) async {
    try {
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
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }
}
