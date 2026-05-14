// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_offers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myOffersHash() => r'163e2670a2785a2d614932dc027919069267b807';

/// Provider for current user's offers (sent and received)
///
/// Copied from [myOffers].
@ProviderFor(myOffers)
final myOffersProvider =
    AutoDisposeFutureProvider<Map<String, List<Offer>>>.internal(
      myOffers,
      name: r'myOffersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myOffersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyOffersRef = AutoDisposeFutureProviderRef<Map<String, List<Offer>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
