// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$matchDetailHash() => r'7b8ff2b14080bb8b6dcebc3cec83f43ecdeb18fd';

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

/// Provider for match listing detail
///
/// Copied from [matchDetail].
@ProviderFor(matchDetail)
const matchDetailProvider = MatchDetailFamily();

/// Provider for match listing detail
///
/// Copied from [matchDetail].
class MatchDetailFamily extends Family<AsyncValue<MatchListing>> {
  /// Provider for match listing detail
  ///
  /// Copied from [matchDetail].
  const MatchDetailFamily();

  /// Provider for match listing detail
  ///
  /// Copied from [matchDetail].
  MatchDetailProvider call(String matchId) {
    return MatchDetailProvider(matchId);
  }

  @override
  MatchDetailProvider getProviderOverride(
    covariant MatchDetailProvider provider,
  ) {
    return call(provider.matchId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'matchDetailProvider';
}

/// Provider for match listing detail
///
/// Copied from [matchDetail].
class MatchDetailProvider extends AutoDisposeFutureProvider<MatchListing> {
  /// Provider for match listing detail
  ///
  /// Copied from [matchDetail].
  MatchDetailProvider(String matchId)
    : this._internal(
        (ref) => matchDetail(ref as MatchDetailRef, matchId),
        from: matchDetailProvider,
        name: r'matchDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$matchDetailHash,
        dependencies: MatchDetailFamily._dependencies,
        allTransitiveDependencies: MatchDetailFamily._allTransitiveDependencies,
        matchId: matchId,
      );

  MatchDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.matchId,
  }) : super.internal();

  final String matchId;

  @override
  Override overrideWith(
    FutureOr<MatchListing> Function(MatchDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MatchDetailProvider._internal(
        (ref) => create(ref as MatchDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        matchId: matchId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<MatchListing> createElement() {
    return _MatchDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MatchDetailProvider && other.matchId == matchId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, matchId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MatchDetailRef on AutoDisposeFutureProviderRef<MatchListing> {
  /// The parameter `matchId` of this provider.
  String get matchId;
}

class _MatchDetailProviderElement
    extends AutoDisposeFutureProviderElement<MatchListing>
    with MatchDetailRef {
  _MatchDetailProviderElement(super.provider);

  @override
  String get matchId => (origin as MatchDetailProvider).matchId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
