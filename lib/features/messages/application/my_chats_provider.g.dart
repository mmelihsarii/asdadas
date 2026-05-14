// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_chats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myChatsHash() => r'34d5a6d42f475b8f161c301bb280b46b32e5f933';

/// Provider for current user's chats (realtime stream)
///
/// Copied from [myChats].
@ProviderFor(myChats)
final myChatsProvider = AutoDisposeStreamProvider<List<Chat>>.internal(
  myChats,
  name: r'myChatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myChatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyChatsRef = AutoDisposeStreamProviderRef<List<Chat>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
