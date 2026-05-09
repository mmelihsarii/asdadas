// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlayerListing _$PlayerListingFromJson(Map<String, dynamic> json) {
  return _PlayerListing.fromJson(json);
}

/// @nodoc
mixin _$PlayerListing {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_id')
  String get playerId => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'center_lat')
  double get centerLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'center_lng')
  double get centerLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'radius_km')
  int get radiusKm => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_start')
  DateTime get availableStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_end')
  DateTime get availableEnd => throw _privateConstructorUsedError;
  List<PositionType> get positions => throw _privateConstructorUsedError;
  @JsonKey(name: 'skill_level')
  SkillLevel get skillLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'preferred_formats')
  List<MatchFormat> get preferredFormats => throw _privateConstructorUsedError;
  @JsonKey(name: 'ask_price')
  int get askPrice => throw _privateConstructorUsedError;
  ListingStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PlayerListing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerListingCopyWith<PlayerListing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerListingCopyWith<$Res> {
  factory $PlayerListingCopyWith(
    PlayerListing value,
    $Res Function(PlayerListing) then,
  ) = _$PlayerListingCopyWithImpl<$Res, PlayerListing>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'player_id') String playerId,
    String? notes,
    @JsonKey(name: 'center_lat') double centerLat,
    @JsonKey(name: 'center_lng') double centerLng,
    @JsonKey(name: 'radius_km') int radiusKm,
    @JsonKey(name: 'available_start') DateTime availableStart,
    @JsonKey(name: 'available_end') DateTime availableEnd,
    List<PositionType> positions,
    @JsonKey(name: 'skill_level') SkillLevel skillLevel,
    @JsonKey(name: 'preferred_formats') List<MatchFormat> preferredFormats,
    @JsonKey(name: 'ask_price') int askPrice,
    ListingStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$PlayerListingCopyWithImpl<$Res, $Val extends PlayerListing>
    implements $PlayerListingCopyWith<$Res> {
  _$PlayerListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? notes = freezed,
    Object? centerLat = null,
    Object? centerLng = null,
    Object? radiusKm = null,
    Object? availableStart = null,
    Object? availableEnd = null,
    Object? positions = null,
    Object? skillLevel = null,
    Object? preferredFormats = null,
    Object? askPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            centerLat: null == centerLat
                ? _value.centerLat
                : centerLat // ignore: cast_nullable_to_non_nullable
                      as double,
            centerLng: null == centerLng
                ? _value.centerLng
                : centerLng // ignore: cast_nullable_to_non_nullable
                      as double,
            radiusKm: null == radiusKm
                ? _value.radiusKm
                : radiusKm // ignore: cast_nullable_to_non_nullable
                      as int,
            availableStart: null == availableStart
                ? _value.availableStart
                : availableStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            availableEnd: null == availableEnd
                ? _value.availableEnd
                : availableEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            positions: null == positions
                ? _value.positions
                : positions // ignore: cast_nullable_to_non_nullable
                      as List<PositionType>,
            skillLevel: null == skillLevel
                ? _value.skillLevel
                : skillLevel // ignore: cast_nullable_to_non_nullable
                      as SkillLevel,
            preferredFormats: null == preferredFormats
                ? _value.preferredFormats
                : preferredFormats // ignore: cast_nullable_to_non_nullable
                      as List<MatchFormat>,
            askPrice: null == askPrice
                ? _value.askPrice
                : askPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ListingStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlayerListingImplCopyWith<$Res>
    implements $PlayerListingCopyWith<$Res> {
  factory _$$PlayerListingImplCopyWith(
    _$PlayerListingImpl value,
    $Res Function(_$PlayerListingImpl) then,
  ) = __$$PlayerListingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'player_id') String playerId,
    String? notes,
    @JsonKey(name: 'center_lat') double centerLat,
    @JsonKey(name: 'center_lng') double centerLng,
    @JsonKey(name: 'radius_km') int radiusKm,
    @JsonKey(name: 'available_start') DateTime availableStart,
    @JsonKey(name: 'available_end') DateTime availableEnd,
    List<PositionType> positions,
    @JsonKey(name: 'skill_level') SkillLevel skillLevel,
    @JsonKey(name: 'preferred_formats') List<MatchFormat> preferredFormats,
    @JsonKey(name: 'ask_price') int askPrice,
    ListingStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$PlayerListingImplCopyWithImpl<$Res>
    extends _$PlayerListingCopyWithImpl<$Res, _$PlayerListingImpl>
    implements _$$PlayerListingImplCopyWith<$Res> {
  __$$PlayerListingImplCopyWithImpl(
    _$PlayerListingImpl _value,
    $Res Function(_$PlayerListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? notes = freezed,
    Object? centerLat = null,
    Object? centerLng = null,
    Object? radiusKm = null,
    Object? availableStart = null,
    Object? availableEnd = null,
    Object? positions = null,
    Object? skillLevel = null,
    Object? preferredFormats = null,
    Object? askPrice = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$PlayerListingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        centerLat: null == centerLat
            ? _value.centerLat
            : centerLat // ignore: cast_nullable_to_non_nullable
                  as double,
        centerLng: null == centerLng
            ? _value.centerLng
            : centerLng // ignore: cast_nullable_to_non_nullable
                  as double,
        radiusKm: null == radiusKm
            ? _value.radiusKm
            : radiusKm // ignore: cast_nullable_to_non_nullable
                  as int,
        availableStart: null == availableStart
            ? _value.availableStart
            : availableStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        availableEnd: null == availableEnd
            ? _value.availableEnd
            : availableEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        positions: null == positions
            ? _value._positions
            : positions // ignore: cast_nullable_to_non_nullable
                  as List<PositionType>,
        skillLevel: null == skillLevel
            ? _value.skillLevel
            : skillLevel // ignore: cast_nullable_to_non_nullable
                  as SkillLevel,
        preferredFormats: null == preferredFormats
            ? _value._preferredFormats
            : preferredFormats // ignore: cast_nullable_to_non_nullable
                  as List<MatchFormat>,
        askPrice: null == askPrice
            ? _value.askPrice
            : askPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ListingStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerListingImpl implements _PlayerListing {
  const _$PlayerListingImpl({
    required this.id,
    @JsonKey(name: 'player_id') required this.playerId,
    this.notes,
    @JsonKey(name: 'center_lat') required this.centerLat,
    @JsonKey(name: 'center_lng') required this.centerLng,
    @JsonKey(name: 'radius_km') this.radiusKm = 10,
    @JsonKey(name: 'available_start') required this.availableStart,
    @JsonKey(name: 'available_end') required this.availableEnd,
    final List<PositionType> positions = const [],
    @JsonKey(name: 'skill_level') required this.skillLevel,
    @JsonKey(name: 'preferred_formats')
    final List<MatchFormat> preferredFormats = const [],
    @JsonKey(name: 'ask_price') this.askPrice = 0,
    this.status = ListingStatus.open,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _positions = positions,
       _preferredFormats = preferredFormats;

  factory _$PlayerListingImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerListingImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'player_id')
  final String playerId;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'center_lat')
  final double centerLat;
  @override
  @JsonKey(name: 'center_lng')
  final double centerLng;
  @override
  @JsonKey(name: 'radius_km')
  final int radiusKm;
  @override
  @JsonKey(name: 'available_start')
  final DateTime availableStart;
  @override
  @JsonKey(name: 'available_end')
  final DateTime availableEnd;
  final List<PositionType> _positions;
  @override
  @JsonKey()
  List<PositionType> get positions {
    if (_positions is EqualUnmodifiableListView) return _positions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_positions);
  }

  @override
  @JsonKey(name: 'skill_level')
  final SkillLevel skillLevel;
  final List<MatchFormat> _preferredFormats;
  @override
  @JsonKey(name: 'preferred_formats')
  List<MatchFormat> get preferredFormats {
    if (_preferredFormats is EqualUnmodifiableListView)
      return _preferredFormats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredFormats);
  }

  @override
  @JsonKey(name: 'ask_price')
  final int askPrice;
  @override
  @JsonKey()
  final ListingStatus status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PlayerListing(id: $id, playerId: $playerId, notes: $notes, centerLat: $centerLat, centerLng: $centerLng, radiusKm: $radiusKm, availableStart: $availableStart, availableEnd: $availableEnd, positions: $positions, skillLevel: $skillLevel, preferredFormats: $preferredFormats, askPrice: $askPrice, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerListingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.centerLat, centerLat) ||
                other.centerLat == centerLat) &&
            (identical(other.centerLng, centerLng) ||
                other.centerLng == centerLng) &&
            (identical(other.radiusKm, radiusKm) ||
                other.radiusKm == radiusKm) &&
            (identical(other.availableStart, availableStart) ||
                other.availableStart == availableStart) &&
            (identical(other.availableEnd, availableEnd) ||
                other.availableEnd == availableEnd) &&
            const DeepCollectionEquality().equals(
              other._positions,
              _positions,
            ) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            const DeepCollectionEquality().equals(
              other._preferredFormats,
              _preferredFormats,
            ) &&
            (identical(other.askPrice, askPrice) ||
                other.askPrice == askPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    playerId,
    notes,
    centerLat,
    centerLng,
    radiusKm,
    availableStart,
    availableEnd,
    const DeepCollectionEquality().hash(_positions),
    skillLevel,
    const DeepCollectionEquality().hash(_preferredFormats),
    askPrice,
    status,
    createdAt,
    updatedAt,
  );

  /// Create a copy of PlayerListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerListingImplCopyWith<_$PlayerListingImpl> get copyWith =>
      __$$PlayerListingImplCopyWithImpl<_$PlayerListingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerListingImplToJson(this);
  }
}

abstract class _PlayerListing implements PlayerListing {
  const factory _PlayerListing({
    required final String id,
    @JsonKey(name: 'player_id') required final String playerId,
    final String? notes,
    @JsonKey(name: 'center_lat') required final double centerLat,
    @JsonKey(name: 'center_lng') required final double centerLng,
    @JsonKey(name: 'radius_km') final int radiusKm,
    @JsonKey(name: 'available_start') required final DateTime availableStart,
    @JsonKey(name: 'available_end') required final DateTime availableEnd,
    final List<PositionType> positions,
    @JsonKey(name: 'skill_level') required final SkillLevel skillLevel,
    @JsonKey(name: 'preferred_formats')
    final List<MatchFormat> preferredFormats,
    @JsonKey(name: 'ask_price') final int askPrice,
    final ListingStatus status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$PlayerListingImpl;

  factory _PlayerListing.fromJson(Map<String, dynamic> json) =
      _$PlayerListingImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'player_id')
  String get playerId;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'center_lat')
  double get centerLat;
  @override
  @JsonKey(name: 'center_lng')
  double get centerLng;
  @override
  @JsonKey(name: 'radius_km')
  int get radiusKm;
  @override
  @JsonKey(name: 'available_start')
  DateTime get availableStart;
  @override
  @JsonKey(name: 'available_end')
  DateTime get availableEnd;
  @override
  List<PositionType> get positions;
  @override
  @JsonKey(name: 'skill_level')
  SkillLevel get skillLevel;
  @override
  @JsonKey(name: 'preferred_formats')
  List<MatchFormat> get preferredFormats;
  @override
  @JsonKey(name: 'ask_price')
  int get askPrice;
  @override
  ListingStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of PlayerListing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerListingImplCopyWith<_$PlayerListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
