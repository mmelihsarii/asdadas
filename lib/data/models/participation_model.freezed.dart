// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Participation _$ParticipationFromJson(Map<String, dynamic> json) {
  return _Participation.fromJson(json);
}

/// @nodoc
mixin _$Participation {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'match_id')
  String get matchId => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_id')
  String get playerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'agreed_amount')
  int get agreedAmount => throw _privateConstructorUsedError;
  ParticipationStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Participation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Participation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParticipationCopyWith<Participation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParticipationCopyWith<$Res> {
  factory $ParticipationCopyWith(
    Participation value,
    $Res Function(Participation) then,
  ) = _$ParticipationCopyWithImpl<$Res, Participation>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'match_id') String matchId,
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'agreed_amount') int agreedAmount,
    ParticipationStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$ParticipationCopyWithImpl<$Res, $Val extends Participation>
    implements $ParticipationCopyWith<$Res> {
  _$ParticipationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Participation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? playerId = null,
    Object? agreedAmount = null,
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
            matchId: null == matchId
                ? _value.matchId
                : matchId // ignore: cast_nullable_to_non_nullable
                      as String,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            agreedAmount: null == agreedAmount
                ? _value.agreedAmount
                : agreedAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ParticipationStatus,
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
abstract class _$$ParticipationImplCopyWith<$Res>
    implements $ParticipationCopyWith<$Res> {
  factory _$$ParticipationImplCopyWith(
    _$ParticipationImpl value,
    $Res Function(_$ParticipationImpl) then,
  ) = __$$ParticipationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'match_id') String matchId,
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'agreed_amount') int agreedAmount,
    ParticipationStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$ParticipationImplCopyWithImpl<$Res>
    extends _$ParticipationCopyWithImpl<$Res, _$ParticipationImpl>
    implements _$$ParticipationImplCopyWith<$Res> {
  __$$ParticipationImplCopyWithImpl(
    _$ParticipationImpl _value,
    $Res Function(_$ParticipationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Participation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? playerId = null,
    Object? agreedAmount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ParticipationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        matchId: null == matchId
            ? _value.matchId
            : matchId // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        agreedAmount: null == agreedAmount
            ? _value.agreedAmount
            : agreedAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ParticipationStatus,
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
class _$ParticipationImpl implements _Participation {
  const _$ParticipationImpl({
    required this.id,
    @JsonKey(name: 'match_id') required this.matchId,
    @JsonKey(name: 'player_id') required this.playerId,
    @JsonKey(name: 'agreed_amount') required this.agreedAmount,
    this.status = ParticipationStatus.accepted,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$ParticipationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParticipationImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'match_id')
  final String matchId;
  @override
  @JsonKey(name: 'player_id')
  final String playerId;
  @override
  @JsonKey(name: 'agreed_amount')
  final int agreedAmount;
  @override
  @JsonKey()
  final ParticipationStatus status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Participation(id: $id, matchId: $matchId, playerId: $playerId, agreedAmount: $agreedAmount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParticipationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.agreedAmount, agreedAmount) ||
                other.agreedAmount == agreedAmount) &&
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
    matchId,
    playerId,
    agreedAmount,
    status,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Participation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParticipationImplCopyWith<_$ParticipationImpl> get copyWith =>
      __$$ParticipationImplCopyWithImpl<_$ParticipationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParticipationImplToJson(this);
  }
}

abstract class _Participation implements Participation {
  const factory _Participation({
    required final String id,
    @JsonKey(name: 'match_id') required final String matchId,
    @JsonKey(name: 'player_id') required final String playerId,
    @JsonKey(name: 'agreed_amount') required final int agreedAmount,
    final ParticipationStatus status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$ParticipationImpl;

  factory _Participation.fromJson(Map<String, dynamic> json) =
      _$ParticipationImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'match_id')
  String get matchId;
  @override
  @JsonKey(name: 'player_id')
  String get playerId;
  @override
  @JsonKey(name: 'agreed_amount')
  int get agreedAmount;
  @override
  ParticipationStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Participation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParticipationImplCopyWith<_$ParticipationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
