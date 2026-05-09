// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return _Offer.fromJson(json);
}

/// @nodoc
mixin _$Offer {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_user_id')
  String get fromUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_user_id')
  String get toUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'match_listing_id')
  String? get matchListingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_listing_id')
  String? get playerListingId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  OfferStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'counter_count')
  int get counterCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Offer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfferCopyWith<Offer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferCopyWith<$Res> {
  factory $OfferCopyWith(Offer value, $Res Function(Offer) then) =
      _$OfferCopyWithImpl<$Res, Offer>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'from_user_id') String fromUserId,
    @JsonKey(name: 'to_user_id') String toUserId,
    @JsonKey(name: 'match_listing_id') String? matchListingId,
    @JsonKey(name: 'player_listing_id') String? playerListingId,
    int amount,
    OfferStatus status,
    @JsonKey(name: 'counter_count') int counterCount,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$OfferCopyWithImpl<$Res, $Val extends Offer>
    implements $OfferCopyWith<$Res> {
  _$OfferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? matchListingId = freezed,
    Object? playerListingId = freezed,
    Object? amount = null,
    Object? status = null,
    Object? counterCount = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fromUserId: null == fromUserId
                ? _value.fromUserId
                : fromUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            toUserId: null == toUserId
                ? _value.toUserId
                : toUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            matchListingId: freezed == matchListingId
                ? _value.matchListingId
                : matchListingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            playerListingId: freezed == playerListingId
                ? _value.playerListingId
                : playerListingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OfferStatus,
            counterCount: null == counterCount
                ? _value.counterCount
                : counterCount // ignore: cast_nullable_to_non_nullable
                      as int,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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
abstract class _$$OfferImplCopyWith<$Res> implements $OfferCopyWith<$Res> {
  factory _$$OfferImplCopyWith(
    _$OfferImpl value,
    $Res Function(_$OfferImpl) then,
  ) = __$$OfferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'from_user_id') String fromUserId,
    @JsonKey(name: 'to_user_id') String toUserId,
    @JsonKey(name: 'match_listing_id') String? matchListingId,
    @JsonKey(name: 'player_listing_id') String? playerListingId,
    int amount,
    OfferStatus status,
    @JsonKey(name: 'counter_count') int counterCount,
    @JsonKey(name: 'expires_at') DateTime expiresAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$OfferImplCopyWithImpl<$Res>
    extends _$OfferCopyWithImpl<$Res, _$OfferImpl>
    implements _$$OfferImplCopyWith<$Res> {
  __$$OfferImplCopyWithImpl(
    _$OfferImpl _value,
    $Res Function(_$OfferImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? matchListingId = freezed,
    Object? playerListingId = freezed,
    Object? amount = null,
    Object? status = null,
    Object? counterCount = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$OfferImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fromUserId: null == fromUserId
            ? _value.fromUserId
            : fromUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        toUserId: null == toUserId
            ? _value.toUserId
            : toUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        matchListingId: freezed == matchListingId
            ? _value.matchListingId
            : matchListingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        playerListingId: freezed == playerListingId
            ? _value.playerListingId
            : playerListingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OfferStatus,
        counterCount: null == counterCount
            ? _value.counterCount
            : counterCount // ignore: cast_nullable_to_non_nullable
                  as int,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$OfferImpl implements _Offer {
  const _$OfferImpl({
    required this.id,
    @JsonKey(name: 'from_user_id') required this.fromUserId,
    @JsonKey(name: 'to_user_id') required this.toUserId,
    @JsonKey(name: 'match_listing_id') this.matchListingId,
    @JsonKey(name: 'player_listing_id') this.playerListingId,
    required this.amount,
    this.status = OfferStatus.sent,
    @JsonKey(name: 'counter_count') this.counterCount = 0,
    @JsonKey(name: 'expires_at') required this.expiresAt,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$OfferImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfferImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'from_user_id')
  final String fromUserId;
  @override
  @JsonKey(name: 'to_user_id')
  final String toUserId;
  @override
  @JsonKey(name: 'match_listing_id')
  final String? matchListingId;
  @override
  @JsonKey(name: 'player_listing_id')
  final String? playerListingId;
  @override
  final int amount;
  @override
  @JsonKey()
  final OfferStatus status;
  @override
  @JsonKey(name: 'counter_count')
  final int counterCount;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Offer(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, matchListingId: $matchListingId, playerListingId: $playerListingId, amount: $amount, status: $status, counterCount: $counterCount, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.matchListingId, matchListingId) ||
                other.matchListingId == matchListingId) &&
            (identical(other.playerListingId, playerListingId) ||
                other.playerListingId == playerListingId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.counterCount, counterCount) ||
                other.counterCount == counterCount) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
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
    fromUserId,
    toUserId,
    matchListingId,
    playerListingId,
    amount,
    status,
    counterCount,
    expiresAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferImplCopyWith<_$OfferImpl> get copyWith =>
      __$$OfferImplCopyWithImpl<_$OfferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfferImplToJson(this);
  }
}

abstract class _Offer implements Offer {
  const factory _Offer({
    required final String id,
    @JsonKey(name: 'from_user_id') required final String fromUserId,
    @JsonKey(name: 'to_user_id') required final String toUserId,
    @JsonKey(name: 'match_listing_id') final String? matchListingId,
    @JsonKey(name: 'player_listing_id') final String? playerListingId,
    required final int amount,
    final OfferStatus status,
    @JsonKey(name: 'counter_count') final int counterCount,
    @JsonKey(name: 'expires_at') required final DateTime expiresAt,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$OfferImpl;

  factory _Offer.fromJson(Map<String, dynamic> json) = _$OfferImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'from_user_id')
  String get fromUserId;
  @override
  @JsonKey(name: 'to_user_id')
  String get toUserId;
  @override
  @JsonKey(name: 'match_listing_id')
  String? get matchListingId;
  @override
  @JsonKey(name: 'player_listing_id')
  String? get playerListingId;
  @override
  int get amount;
  @override
  OfferStatus get status;
  @override
  @JsonKey(name: 'counter_count')
  int get counterCount;
  @override
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferImplCopyWith<_$OfferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
