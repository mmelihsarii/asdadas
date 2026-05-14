// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myNotificationsHash() => r'eab357f7d8a0d9134638913dfa94a39b15e0eaa6';

/// Provider for notifications (realtime stream)
///
/// Copied from [myNotifications].
@ProviderFor(myNotifications)
final myNotificationsProvider =
    AutoDisposeStreamProvider<List<AppNotification>>.internal(
      myNotifications,
      name: r'myNotificationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myNotificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyNotificationsRef =
    AutoDisposeStreamProviderRef<List<AppNotification>>;
String _$unreadNotificationsCountHash() =>
    r'd438098d38ec1e66585767141d35d92e8909cbd6';

/// Provider for unread count
///
/// Copied from [unreadNotificationsCount].
@ProviderFor(unreadNotificationsCount)
final unreadNotificationsCountProvider =
    AutoDisposeFutureProvider<int>.internal(
      unreadNotificationsCount,
      name: r'unreadNotificationsCountProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$unreadNotificationsCountHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadNotificationsCountRef = AutoDisposeFutureProviderRef<int>;
String _$markNotificationReadHash() =>
    r'ad4bb01f3beb260b5fa75c5b3bc94ea5bef3b30b';

/// Provider for marking notification as read
///
/// Copied from [MarkNotificationRead].
@ProviderFor(MarkNotificationRead)
final markNotificationReadProvider =
    AutoDisposeAsyncNotifierProvider<MarkNotificationRead, void>.internal(
      MarkNotificationRead.new,
      name: r'markNotificationReadProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$markNotificationReadHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MarkNotificationRead = AutoDisposeAsyncNotifier<void>;
String _$markAllNotificationsReadHash() =>
    r'8140ee005c947798a7ddc67c64060e59d92dc1af';

/// Provider for marking all notifications as read
///
/// Copied from [MarkAllNotificationsRead].
@ProviderFor(MarkAllNotificationsRead)
final markAllNotificationsReadProvider =
    AutoDisposeAsyncNotifierProvider<MarkAllNotificationsRead, void>.internal(
      MarkAllNotificationsRead.new,
      name: r'markAllNotificationsReadProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$markAllNotificationsReadHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MarkAllNotificationsRead = AutoDisposeAsyncNotifier<void>;
String _$deleteNotificationHash() =>
    r'c8cf54e8857c9755ca550e88c0b84d5136ef5dba';

/// Provider for deleting notification
///
/// Copied from [DeleteNotification].
@ProviderFor(DeleteNotification)
final deleteNotificationProvider =
    AutoDisposeAsyncNotifierProvider<DeleteNotification, void>.internal(
      DeleteNotification.new,
      name: r'deleteNotificationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deleteNotificationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DeleteNotification = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
