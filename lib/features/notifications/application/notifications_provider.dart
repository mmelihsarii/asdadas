import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/models.dart';
import '../../../data/repositories/notifications_repository.dart';

part 'notifications_provider.g.dart';

/// Provider for notifications (realtime stream)
@riverpod
Stream<List<AppNotification>> myNotifications(MyNotificationsRef ref) {
  final repo = ref.watch(notificationsRepositoryProvider);
  return repo.getMyNotificationsStream();
}

/// Provider for unread count
@riverpod
Future<int> unreadNotificationsCount(UnreadNotificationsCountRef ref) async {
  final repo = ref.watch(notificationsRepositoryProvider);
  return repo.getUnreadCount();
}

/// Provider for marking notification as read
@riverpod
class MarkNotificationRead extends _$MarkNotificationRead {
  @override
  FutureOr<void> build() {}

  Future<void> mark(String notificationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(notificationsRepositoryProvider);
      await repo.markAsRead(notificationId);

      // Invalidate to refresh
      ref.invalidate(myNotificationsProvider);
      ref.invalidate(unreadNotificationsCountProvider);
    });
  }
}

/// Provider for marking all notifications as read
@riverpod
class MarkAllNotificationsRead extends _$MarkAllNotificationsRead {
  @override
  FutureOr<void> build() {}

  Future<void> markAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(notificationsRepositoryProvider);
      await repo.markAllAsRead();

      // Invalidate to refresh
      ref.invalidate(myNotificationsProvider);
      ref.invalidate(unreadNotificationsCountProvider);
    });
  }
}

/// Provider for deleting notification
@riverpod
class DeleteNotification extends _$DeleteNotification {
  @override
  FutureOr<void> build() {}

  Future<void> delete(String notificationId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(notificationsRepositoryProvider);
      await repo.delete(notificationId);

      // Invalidate to refresh
      ref.invalidate(myNotificationsProvider);
      ref.invalidate(unreadNotificationsCountProvider);
    });
  }
}
