// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'5630f9295962e55fea37c946b00218b4219acc52';

/// Provider for current authenticated user
///
/// Copied from [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeFutureProvider<User?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeFutureProviderRef<User?>;
String _$currentUserStatsHash() => r'9b96ab52b12d247cadc59e5e81eaec6cc205b450';

/// Provider for current user stats
///
/// Copied from [currentUserStats].
@ProviderFor(currentUserStats)
final currentUserStatsProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
      currentUserStats,
      name: r'currentUserStatsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentUserStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserStatsRef =
    AutoDisposeFutureProviderRef<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
