import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../models/models.dart';

part 'users_repository.g.dart';

@riverpod
UsersRepository usersRepository(UsersRepositoryRef ref) {
  return UsersRepository();
}

class UsersRepository {
  final _supabase = SupabaseService.instance.client;

  /// Get current user
  Future<User?> getCurrentUser() async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) return null;

    final response = await _supabase
        .from('users')
        .select()
        .eq('id', userId)
        .single();

    return User.fromJson(response);
  }

  /// Get user by ID
  Future<User> getUserById(String userId) async {
    final response = await _supabase
        .from('users')
        .select()
        .eq('id', userId)
        .single();

    return User.fromJson(response);
  }

  /// Update current user profile
  Future<User> updateProfile(Map<String, dynamic> data) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    final response = await _supabase
        .from('users')
        .update(data)
        .eq('id', userId)
        .select()
        .single();

    return User.fromJson(response);
  }

  /// Get user profile (extended info)
  Future<UserProfile?> getUserProfile(String userId) async {
    final response = await _supabase
        .from('user_profiles')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return null;
    return UserProfile.fromJson(response);
  }

  /// Create or update user profile
  Future<UserProfile> upsertUserProfile(Map<String, dynamic> data) async {
    final userId = SupabaseService.instance.currentUserId;
    if (userId == null) throw Exception('Kullanıcı girişi gerekli');

    data['user_id'] = userId;

    final response = await _supabase
        .from('user_profiles')
        .upsert(data)
        .select()
        .single();

    return UserProfile.fromJson(response);
  }

  /// Get user statistics
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    final response = await _supabase
        .rpc('get_user_stats', params: {'p_user_id': userId})
        .single();

    return response;
  }
}
