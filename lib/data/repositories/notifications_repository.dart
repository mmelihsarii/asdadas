import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/supabase_service.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/app_exception.dart';
import '../models/models.dart';

part 'notifications_repository.g.dart';

@riverpod
NotificationsRepository notificationsRepository(
  NotificationsRepositoryRef ref,
) {
  return NotificationsRepository();
}

class NotificationsRepository {
  final _supabase = SupabaseService.instance.client;

  /// Get my notifications
  Future<List<AppNotification>> getMyNotifications({
    int limit = 50,
    int offset = 0,
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
          .from('notifications')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      return (response as List)
          .map((json) => AppNotification.fromJson(json))
          .toList();
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get my notifications as a realtime stream
  Stream<List<AppNotification>> getMyNotificationsStream() {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      return _supabase
          .from('notifications')
          .stream(primaryKey: ['id'])
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .map(
            (data) => (data as List)
                .map((json) => AppNotification.fromJson(json))
                .toList(),
          );
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) {
        throw const AuthException(
          message: 'Kullanıcı girişi gerekli',
          code: 'NOT_AUTHENTICATED',
        );
      }

      await _supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', userId)
          .eq('is_read', false);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Delete notification
  Future<void> delete(String notificationId) async {
    try {
      await _supabase.from('notifications').delete().eq('id', notificationId);
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }

  /// Get unread count
  Future<int> getUnreadCount() async {
    try {
      final userId = SupabaseService.instance.currentUserId;
      if (userId == null) return 0;

      final response = await _supabase
          .from('notifications')
          .select('id')
          .eq('user_id', userId)
          .eq('is_read', false)
          .count();

      return response.count;
    } catch (e, stackTrace) {
      throw ErrorHandler.handleError(e, stackTrace);
    }
  }
}
