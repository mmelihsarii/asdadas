// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExploreState {
  List<MatchListing> get matchListings => throw _privateConstructorUsedError;
  List<PlayerListing> get playerListings => throw _privateConstructorUsedError;
  ExploreViewMode get viewMode => throw _privateConstructorUsedError;
  ExploreListingType get listingType => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  double? get userLat => throw _privateConstructorUsedError;
  double? get userLng => throw _privateConstructorUsedError;
  double get radiusKm => throw _privateConstructorUsedError;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExploreStateCopyWith<ExploreState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreStateCopyWith<$Res> {
  factory $ExploreStateCopyWith(
    ExploreState value,
    $Res Function(ExploreState) then,
  ) = _$ExploreStateCopyWithImpl<$Res, ExploreState>;
  @useResult
  $Res call({
    List<MatchListing> matchListings,
    List<PlayerListing> playerListings,
    ExploreViewMode viewMode,
    ExploreListingType listingType,
    bool isLoading,
    String? error,
    double? userLat,
    double? userLng,
    double radiusKm,
  });
}

/// @nodoc
class _$ExploreStateCopyWithImpl<$Res, $Val extends ExploreState>
    implements $ExploreStateCopyWith<$Res> {
  _$ExploreStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchListings = null,
    Object? playerListings = null,
    Object? viewMode = null,
    Object? listingType = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? userLat = freezed,
    Object? userLng = freezed,
    Object? radiusKm = null,
  }) {
    return _then(
      _value.copyWith(
            matchListings: null == matchListings
                ? _value.matchListings
                : matchListings // ignore: cast_nullable_to_non_nullable
                      as List<MatchListing>,
            playerListings: null == playerListings
                ? _value.playerListings
                : playerListings // ignore: cast_nullable_to_non_nullable
                      as List<PlayerListing>,
            viewMode: null == viewMode
                ? _value.viewMode
                : viewMode // ignore: cast_nullable_to_non_nullable
                      as ExploreViewMode,
            listingType: null == listingType
                ? _value.listingType
                : listingType // ignore: cast_nullable_to_non_nullable
                      as ExploreListingType,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            userLat: freezed == userLat
                ? _value.userLat
                : userLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            userLng: freezed == userLng
                ? _value.userLng
                : userLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            radiusKm: null == radiusKm
                ? _value.radiusKm
                : radiusKm // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExploreStateImplCopyWith<$Res>
    implements $ExploreStateCopyWith<$Res> {
  factory _$$ExploreStateImplCopyWith(
    _$ExploreStateImpl value,
    $Res Function(_$ExploreStateImpl) then,
  ) = __$$ExploreStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MatchListing> matchListings,
    List<PlayerListing> playerListings,
    ExploreViewMode viewMode,
    ExploreListingType listingType,
    bool isLoading,
    String? error,
    double? userLat,
    double? userLng,
    double radiusKm,
  });
}

/// @nodoc
class __$$ExploreStateImplCopyWithImpl<$Res>
    extends _$ExploreStateCopyWithImpl<$Res, _$ExploreStateImpl>
    implements _$$ExploreStateImplCopyWith<$Res> {
  __$$ExploreStateImplCopyWithImpl(
    _$ExploreStateImpl _value,
    $Res Function(_$ExploreStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchListings = null,
    Object? playerListings = null,
    Object? viewMode = null,
    Object? listingType = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? userLat = freezed,
    Object? userLng = freezed,
    Object? radiusKm = null,
  }) {
    return _then(
      _$ExploreStateImpl(
        matchListings: null == matchListings
            ? _value._matchListings
            : matchListings // ignore: cast_nullable_to_non_nullable
                  as List<MatchListing>,
        playerListings: null == playerListings
            ? _value._playerListings
            : playerListings // ignore: cast_nullable_to_non_nullable
                  as List<PlayerListing>,
        viewMode: null == viewMode
            ? _value.viewMode
            : viewMode // ignore: cast_nullable_to_non_nullable
                  as ExploreViewMode,
        listingType: null == listingType
            ? _value.listingType
            : listingType // ignore: cast_nullable_to_non_nullable
                  as ExploreListingType,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        userLat: freezed == userLat
            ? _value.userLat
            : userLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        userLng: freezed == userLng
            ? _value.userLng
            : userLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        radiusKm: null == radiusKm
            ? _value.radiusKm
            : radiusKm // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$ExploreStateImpl implements _ExploreState {
  const _$ExploreStateImpl({
    final List<MatchListing> matchListings = const [],
    final List<PlayerListing> playerListings = const [],
    this.viewMode = ExploreViewMode.map,
    this.listingType = ExploreListingType.all,
    this.isLoading = false,
    this.error,
    this.userLat,
    this.userLng,
    this.radiusKm = 10.0,
  }) : _matchListings = matchListings,
       _playerListings = playerListings;

  final List<MatchListing> _matchListings;
  @override
  @JsonKey()
  List<MatchListing> get matchListings {
    if (_matchListings is EqualUnmodifiableListView) return _matchListings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matchListings);
  }

  final List<PlayerListing> _playerListings;
  @override
  @JsonKey()
  List<PlayerListing> get playerListings {
    if (_playerListings is EqualUnmodifiableListView) return _playerListings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerListings);
  }

  @override
  @JsonKey()
  final ExploreViewMode viewMode;
  @override
  @JsonKey()
  final ExploreListingType listingType;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final double? userLat;
  @override
  final double? userLng;
  @override
  @JsonKey()
  final double radiusKm;

  @override
  String toString() {
    return 'ExploreState(matchListings: $matchListings, playerListings: $playerListings, viewMode: $viewMode, listingType: $listingType, isLoading: $isLoading, error: $error, userLat: $userLat, userLng: $userLng, radiusKm: $radiusKm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreStateImpl &&
            const DeepCollectionEquality().equals(
              other._matchListings,
              _matchListings,
            ) &&
            const DeepCollectionEquality().equals(
              other._playerListings,
              _playerListings,
            ) &&
            (identical(other.viewMode, viewMode) ||
                other.viewMode == viewMode) &&
            (identical(other.listingType, listingType) ||
                other.listingType == listingType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.userLat, userLat) || other.userLat == userLat) &&
            (identical(other.userLng, userLng) || other.userLng == userLng) &&
            (identical(other.radiusKm, radiusKm) ||
                other.radiusKm == radiusKm));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_matchListings),
    const DeepCollectionEquality().hash(_playerListings),
    viewMode,
    listingType,
    isLoading,
    error,
    userLat,
    userLng,
    radiusKm,
  );

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExploreStateImplCopyWith<_$ExploreStateImpl> get copyWith =>
      __$$ExploreStateImplCopyWithImpl<_$ExploreStateImpl>(this, _$identity);
}

abstract class _ExploreState implements ExploreState {
  const factory _ExploreState({
    final List<MatchListing> matchListings,
    final List<PlayerListing> playerListings,
    final ExploreViewMode viewMode,
    final ExploreListingType listingType,
    final bool isLoading,
    final String? error,
    final double? userLat,
    final double? userLng,
    final double radiusKm,
  }) = _$ExploreStateImpl;

  @override
  List<MatchListing> get matchListings;
  @override
  List<PlayerListing> get playerListings;
  @override
  ExploreViewMode get viewMode;
  @override
  ExploreListingType get listingType;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  double? get userLat;
  @override
  double? get userLng;
  @override
  double get radiusKm;

  /// Create a copy of ExploreState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExploreStateImplCopyWith<_$ExploreStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
