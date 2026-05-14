// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allListingsHash() => r'ccb00c488f25a21ec7c378f2e07dd5b5ff42adda';

/// Provider for all listings (matches + players)
///
/// Copied from [allListings].
@ProviderFor(allListings)
final allListingsProvider =
    AutoDisposeFutureProvider<List<ExploreListing>>.internal(
      allListings,
      name: r'allListingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allListingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllListingsRef = AutoDisposeFutureProviderRef<List<ExploreListing>>;
String _$matchListingsHash() => r'0f764ffdb1b750d675608acff5419d7e2ee43ae5';

/// Provider for match listings only
///
/// Copied from [matchListings].
@ProviderFor(matchListings)
final matchListingsProvider =
    AutoDisposeFutureProvider<List<ExploreListing>>.internal(
      matchListings,
      name: r'matchListingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$matchListingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MatchListingsRef = AutoDisposeFutureProviderRef<List<ExploreListing>>;
String _$playerListingsHash() => r'6b1dac39411c597b881636efdb49bf5e532617d2';

/// Provider for player listings only
///
/// Copied from [playerListings].
@ProviderFor(playerListings)
final playerListingsProvider =
    AutoDisposeFutureProvider<List<ExploreListing>>.internal(
      playerListings,
      name: r'playerListingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$playerListingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PlayerListingsRef = AutoDisposeFutureProviderRef<List<ExploreListing>>;
String _$filteredListingsHash() => r'8688d8fb5de9833e96861925c7db909d48c04b3f';

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

/// Provider for filtered listings based on type
///
/// Copied from [filteredListings].
@ProviderFor(filteredListings)
const filteredListingsProvider = FilteredListingsFamily();

/// Provider for filtered listings based on type
///
/// Copied from [filteredListings].
class FilteredListingsFamily extends Family<AsyncValue<List<ExploreListing>>> {
  /// Provider for filtered listings based on type
  ///
  /// Copied from [filteredListings].
  const FilteredListingsFamily();

  /// Provider for filtered listings based on type
  ///
  /// Copied from [filteredListings].
  FilteredListingsProvider call(String filterType) {
    return FilteredListingsProvider(filterType);
  }

  @override
  FilteredListingsProvider getProviderOverride(
    covariant FilteredListingsProvider provider,
  ) {
    return call(provider.filterType);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredListingsProvider';
}

/// Provider for filtered listings based on type
///
/// Copied from [filteredListings].
class FilteredListingsProvider
    extends AutoDisposeFutureProvider<List<ExploreListing>> {
  /// Provider for filtered listings based on type
  ///
  /// Copied from [filteredListings].
  FilteredListingsProvider(String filterType)
    : this._internal(
        (ref) => filteredListings(ref as FilteredListingsRef, filterType),
        from: filteredListingsProvider,
        name: r'filteredListingsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$filteredListingsHash,
        dependencies: FilteredListingsFamily._dependencies,
        allTransitiveDependencies:
            FilteredListingsFamily._allTransitiveDependencies,
        filterType: filterType,
      );

  FilteredListingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filterType,
  }) : super.internal();

  final String filterType;

  @override
  Override overrideWith(
    FutureOr<List<ExploreListing>> Function(FilteredListingsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredListingsProvider._internal(
        (ref) => create(ref as FilteredListingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filterType: filterType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ExploreListing>> createElement() {
    return _FilteredListingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredListingsProvider && other.filterType == filterType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filterType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredListingsRef
    on AutoDisposeFutureProviderRef<List<ExploreListing>> {
  /// The parameter `filterType` of this provider.
  String get filterType;
}

class _FilteredListingsProviderElement
    extends AutoDisposeFutureProviderElement<List<ExploreListing>>
    with FilteredListingsRef {
  _FilteredListingsProviderElement(super.provider);

  @override
  String get filterType => (origin as FilteredListingsProvider).filterType;
}

String _$nearbyListingsHash() => r'ddcf22a4d095172d752b5975b9a370659b5dc87b';

/// Provider for nearby listings (within radius)
///
/// Copied from [nearbyListings].
@ProviderFor(nearbyListings)
const nearbyListingsProvider = NearbyListingsFamily();

/// Provider for nearby listings (within radius)
///
/// Copied from [nearbyListings].
class NearbyListingsFamily extends Family<AsyncValue<List<ExploreListing>>> {
  /// Provider for nearby listings (within radius)
  ///
  /// Copied from [nearbyListings].
  const NearbyListingsFamily();

  /// Provider for nearby listings (within radius)
  ///
  /// Copied from [nearbyListings].
  NearbyListingsProvider call({
    required double userLat,
    required double userLng,
    double radiusKm = 10.0,
  }) {
    return NearbyListingsProvider(
      userLat: userLat,
      userLng: userLng,
      radiusKm: radiusKm,
    );
  }

  @override
  NearbyListingsProvider getProviderOverride(
    covariant NearbyListingsProvider provider,
  ) {
    return call(
      userLat: provider.userLat,
      userLng: provider.userLng,
      radiusKm: provider.radiusKm,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nearbyListingsProvider';
}

/// Provider for nearby listings (within radius)
///
/// Copied from [nearbyListings].
class NearbyListingsProvider
    extends AutoDisposeFutureProvider<List<ExploreListing>> {
  /// Provider for nearby listings (within radius)
  ///
  /// Copied from [nearbyListings].
  NearbyListingsProvider({
    required double userLat,
    required double userLng,
    double radiusKm = 10.0,
  }) : this._internal(
         (ref) => nearbyListings(
           ref as NearbyListingsRef,
           userLat: userLat,
           userLng: userLng,
           radiusKm: radiusKm,
         ),
         from: nearbyListingsProvider,
         name: r'nearbyListingsProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$nearbyListingsHash,
         dependencies: NearbyListingsFamily._dependencies,
         allTransitiveDependencies:
             NearbyListingsFamily._allTransitiveDependencies,
         userLat: userLat,
         userLng: userLng,
         radiusKm: radiusKm,
       );

  NearbyListingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userLat,
    required this.userLng,
    required this.radiusKm,
  }) : super.internal();

  final double userLat;
  final double userLng;
  final double radiusKm;

  @override
  Override overrideWith(
    FutureOr<List<ExploreListing>> Function(NearbyListingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NearbyListingsProvider._internal(
        (ref) => create(ref as NearbyListingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userLat: userLat,
        userLng: userLng,
        radiusKm: radiusKm,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ExploreListing>> createElement() {
    return _NearbyListingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyListingsProvider &&
        other.userLat == userLat &&
        other.userLng == userLng &&
        other.radiusKm == radiusKm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userLat.hashCode);
    hash = _SystemHash.combine(hash, userLng.hashCode);
    hash = _SystemHash.combine(hash, radiusKm.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NearbyListingsRef on AutoDisposeFutureProviderRef<List<ExploreListing>> {
  /// The parameter `userLat` of this provider.
  double get userLat;

  /// The parameter `userLng` of this provider.
  double get userLng;

  /// The parameter `radiusKm` of this provider.
  double get radiusKm;
}

class _NearbyListingsProviderElement
    extends AutoDisposeFutureProviderElement<List<ExploreListing>>
    with NearbyListingsRef {
  _NearbyListingsProviderElement(super.provider);

  @override
  double get userLat => (origin as NearbyListingsProvider).userLat;
  @override
  double get userLng => (origin as NearbyListingsProvider).userLng;
  @override
  double get radiusKm => (origin as NearbyListingsProvider).radiusKm;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
