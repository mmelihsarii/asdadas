// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lastMessageHash() => r'693d5deb28f11c746dc907096685e6e374ee51b6';

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

/// See also [lastMessage].
@ProviderFor(lastMessage)
const lastMessageProvider = LastMessageFamily();

/// See also [lastMessage].
class LastMessageFamily extends Family<AsyncValue<Message?>> {
  /// See also [lastMessage].
  const LastMessageFamily();

  /// See also [lastMessage].
  LastMessageProvider call(String chatId) {
    return LastMessageProvider(chatId);
  }

  @override
  LastMessageProvider getProviderOverride(
    covariant LastMessageProvider provider,
  ) {
    return call(provider.chatId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lastMessageProvider';
}

/// See also [lastMessage].
class LastMessageProvider extends AutoDisposeFutureProvider<Message?> {
  /// See also [lastMessage].
  LastMessageProvider(String chatId)
    : this._internal(
        (ref) => lastMessage(ref as LastMessageRef, chatId),
        from: lastMessageProvider,
        name: r'lastMessageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$lastMessageHash,
        dependencies: LastMessageFamily._dependencies,
        allTransitiveDependencies: LastMessageFamily._allTransitiveDependencies,
        chatId: chatId,
      );

  LastMessageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  Override overrideWith(
    FutureOr<Message?> Function(LastMessageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LastMessageProvider._internal(
        (ref) => create(ref as LastMessageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Message?> createElement() {
    return _LastMessageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LastMessageProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LastMessageRef on AutoDisposeFutureProviderRef<Message?> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _LastMessageProviderElement
    extends AutoDisposeFutureProviderElement<Message?>
    with LastMessageRef {
  _LastMessageProviderElement(super.provider);

  @override
  String get chatId => (origin as LastMessageProvider).chatId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
