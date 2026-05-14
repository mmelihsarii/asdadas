import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/app_exception.dart';
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
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) return null;

      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response != null) {
        return User.fromJson(response);
      }

      return await ensureCurrentUserRecord();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Ensure the authenticated user has a matching row in public.users.
  ///
  /// The database trigger should normally create this row. This fallback keeps
  /// onboarding resilient when an older trigger is deployed or the auth row is
  /// created before the app schema migration reaches production.
  Future<User> ensureCurrentUserRecord() async {
    try {
      final authUser = SupabaseService.instance.currentUser;
      if (authUser == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      final metadata = authUser.userMetadata ?? const <String, dynamic>{};
      final email = authUser.email;
      final displayName = [
        metadata['first_name'],
        metadata['last_name'],
      ].whereType<String>().where((value) => value.trim().isNotEmpty).join(' ');

      final response = await _supabase
          .from('users')
          .upsert({
            'id': authUser.id,
            'email': email,
            'phone': metadata['phone'] ?? email,
            'display_name':
                metadata['display_name'] ??
                metadata['name'] ??
                (displayName.isEmpty ? null : displayName),
            'email_verified_at': DateTime.now().toIso8601String(),
          }, onConflict: 'id')
          .select()
          .single();

      return User.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get user by ID
  Future<User> getUserById(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      return User.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Update current user profile
  Future<User> updateProfile(Map<String, dynamic> data) async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      final response = await _supabase
          .from('users')
          .update(data)
          .eq('id', userId)
          .select()
          .single();

      return User.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get user profile (extended info)
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('user_profiles')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) return null;
      return UserProfile.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Create or update user profile
  Future<UserProfile> upsertUserProfile(Map<String, dynamic> data) async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      data['user_id'] = userId;

      final response = await _supabase
          .from('user_profiles')
          .upsert(data)
          .select()
          .single();

      return UserProfile.fromJson(response);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get user statistics
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final response = await _supabase
          .rpc('get_user_stats', params: {'p_user_id': userId})
          .single();

      return response;
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }
}
