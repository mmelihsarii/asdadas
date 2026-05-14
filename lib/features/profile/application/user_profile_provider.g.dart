// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileHash() => r'a8106c6f52083ce256ffbb096c337c1ba529c87c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for viewing another user's profile
///
/// Copied from [userProfile].
@ProviderFor(userProfile)
const userProfileProvider = UserProfileFamily();

/// Provider for viewing another user's profile
///
/// Copied from [userProfile].
class UserProfileFamily extends Family<AsyncValue<User>> {
  /// Provider for viewing another user's profile
  ///
  /// Copied from [userProfile].
  const UserProfileFamily();

  /// Provider for viewing another user's profile
  ///
  /// Copied from [userProfile].
  UserProfileProvider call(String userId) {
    return UserProfileProvider(userId);
  }

  @override
  UserProfileProvider getProviderOverride(
    covariant UserProfileProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProfileProvider';
}

/// Provider for viewing another user's profile
///
/// Copied from [userProfile].
class UserProfileProvider extends AutoDisposeFutureProvider<User> {
  /// Provider for viewing another user's profile
  ///
  /// Copied from [userProfile].
  UserProfileProvider(String userId)
    : this._internal(
        (ref) => userProfile(ref as UserProfileRef, userId),
        from: userProfileProvider,
        name: r'userProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userProfileHash,
        dependencies: UserProfileFamily._dependencies,
        allTransitiveDependencies: UserProfileFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<User> Function(UserProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProfileProvider._internal(
        (ref) => create(ref as UserProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<User> createElement() {
    return _UserProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserProfileRef on AutoDisposeFutureProviderRef<User> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProfileProviderElement extends AutoDisposeFutureProviderElement<User>
    with UserProfileRef {
  _UserProfileProviderElement(super.provider);

  @override
  String get userId => (origin as UserProfileProvider).userId;
}

String _$userProfileDetailsHash() =>
    r'cf87964d807d5183d70d2c8da436e3fbf9679e77';

/// Provider for user's profile details
///
/// Copied from [userProfileDetails].
@ProviderFor(userProfileDetails)
const userProfileDetailsProvider = UserProfileDetailsFamily();

/// Provider for user's profile details
///
/// Copied from [userProfileDetails].
class UserProfileDetailsFamily extends Family<AsyncValue<UserProfile?>> {
  /// Provider for user's profile details
  ///
  /// Copied from [userProfileDetails].
  const UserProfileDetailsFamily();

  /// Provider for user's profile details
  ///
  /// Copied from [userProfileDetails].
  UserProfileDetailsProvider call(String userId) {
    return UserProfileDetailsProvider(userId);
  }

  @override
  UserProfileDetailsProvider getProviderOverride(
    covariant UserProfileDetailsProvider provider,
  ) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProfileDetailsProvider';
}

/// Provider for user's profile details
///
/// Copied from [userProfileDetails].
class UserProfileDetailsProvider
    extends AutoDisposeFutureProvider<UserProfile?> {
  /// Provider for user's profile details
  ///
  /// Copied from [userProfileDetails].
  UserProfileDetailsProvider(String userId)
    : this._internal(
        (ref) => userProfileDetails(ref as UserProfileDetailsRef, userId),
        from: userProfileDetailsProvider,
        name: r'userProfileDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userProfileDetailsHash,
        dependencies: UserProfileDetailsFamily._dependencies,
        allTransitiveDependencies:
            UserProfileDetailsFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserProfileDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<UserProfile?> Function(UserProfileDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProfileDetailsProvider._internal(
        (ref) => create(ref as UserProfileDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserProfile?> createElement() {
    return _UserProfileDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileDetailsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserProfileDetailsRef on AutoDisposeFutureProviderRef<UserProfile?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProfileDetailsProviderElement
    extends AutoDisposeFutureProviderElement<UserProfile?>
    with UserProfileDetailsRef {
  _UserProfileDetailsProviderElement(super.provider);

  @override
  String get userId => (origin as UserProfileDetailsProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
