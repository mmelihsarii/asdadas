// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'skill_level')
  SkillLevel get skillLevel => throw _privateConstructorUsedError;
  List<PositionType> get positions => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'matches_played_count')
  int get matchesPlayedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_avg')
  double get ratingAvg => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating_count')
  int get ratingCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'no_show_count')
  int get noShowCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'skill_level') SkillLevel skillLevel,
    List<PositionType> positions,
    String? bio,
    @JsonKey(name: 'matches_played_count') int matchesPlayedCount,
    @JsonKey(name: 'rating_avg') double ratingAvg,
    @JsonKey(name: 'rating_count') int ratingCount,
    @JsonKey(name: 'no_show_count') int noShowCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? skillLevel = null,
    Object? positions = null,
    Object? bio = freezed,
    Object? matchesPlayedCount = null,
    Object? ratingAvg = null,
    Object? ratingCount = null,
    Object? noShowCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            skillLevel: null == skillLevel
                ? _value.skillLevel
                : skillLevel // ignore: cast_nullable_to_non_nullable
                      as SkillLevel,
            positions: null == positions
                ? _value.positions
                : positions // ignore: cast_nullable_to_non_nullable
                      as List<PositionType>,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            matchesPlayedCount: null == matchesPlayedCount
                ? _value.matchesPlayedCount
                : matchesPlayedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            ratingAvg: null == ratingAvg
                ? _value.ratingAvg
                : ratingAvg // ignore: cast_nullable_to_non_nullable
                      as double,
            ratingCount: null == ratingCount
                ? _value.ratingCount
                : ratingCount // ignore: cast_nullable_to_non_nullable
                      as int,
            noShowCount: null == noShowCount
                ? _value.noShowCount
                : noShowCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'skill_level') SkillLevel skillLevel,
    List<PositionType> positions,
    String? bio,
    @JsonKey(name: 'matches_played_count') int matchesPlayedCount,
    @JsonKey(name: 'rating_avg') double ratingAvg,
    @JsonKey(name: 'rating_count') int ratingCount,
    @JsonKey(name: 'no_show_count') int noShowCount,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? skillLevel = null,
    Object? positions = null,
    Object? bio = freezed,
    Object? matchesPlayedCount = null,
    Object? ratingAvg = null,
    Object? ratingCount = null,
    Object? noShowCount = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        skillLevel: null == skillLevel
            ? _value.skillLevel
            : skillLevel // ignore: cast_nullable_to_non_nullable
                  as SkillLevel,
        positions: null == positions
            ? _value._positions
            : positions // ignore: cast_nullable_to_non_nullable
                  as List<PositionType>,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        matchesPlayedCount: null == matchesPlayedCount
            ? _value.matchesPlayedCount
            : matchesPlayedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        ratingAvg: null == ratingAvg
            ? _value.ratingAvg
            : ratingAvg // ignore: cast_nullable_to_non_nullable
                  as double,
        ratingCount: null == ratingCount
            ? _value.ratingCount
            : ratingCount // ignore: cast_nullable_to_non_nullable
                  as int,
        noShowCount: null == noShowCount
            ? _value.noShowCount
            : noShowCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'skill_level') this.skillLevel = SkillLevel.beginner,
    final List<PositionType> positions = const [],
    this.bio,
    @JsonKey(name: 'matches_played_count') this.matchesPlayedCount = 0,
    @JsonKey(name: 'rating_avg') this.ratingAvg = 0.0,
    @JsonKey(name: 'rating_count') this.ratingCount = 0,
    @JsonKey(name: 'no_show_count') this.noShowCount = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _positions = positions;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'skill_level')
  final SkillLevel skillLevel;
  final List<PositionType> _positions;
  @override
  @JsonKey()
  List<PositionType> get positions {
    if (_positions is EqualUnmodifiableListView) return _positions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_positions);
  }

  @override
  final String? bio;
  @override
  @JsonKey(name: 'matches_played_count')
  final int matchesPlayedCount;
  @override
  @JsonKey(name: 'rating_avg')
  final double ratingAvg;
  @override
  @JsonKey(name: 'rating_count')
  final int ratingCount;
  @override
  @JsonKey(name: 'no_show_count')
  final int noShowCount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserProfile(id: $id, userId: $userId, skillLevel: $skillLevel, positions: $positions, bio: $bio, matchesPlayedCount: $matchesPlayedCount, ratingAvg: $ratingAvg, ratingCount: $ratingCount, noShowCount: $noShowCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            const DeepCollectionEquality().equals(
              other._positions,
              _positions,
            ) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.matchesPlayedCount, matchesPlayedCount) ||
                other.matchesPlayedCount == matchesPlayedCount) &&
            (identical(other.ratingAvg, ratingAvg) ||
                other.ratingAvg == ratingAvg) &&
            (identical(other.ratingCount, ratingCount) ||
                other.ratingCount == ratingCount) &&
            (identical(other.noShowCount, noShowCount) ||
                other.noShowCount == noShowCount) &&
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
    userId,
    skillLevel,
    const DeepCollectionEquality().hash(_positions),
    bio,
    matchesPlayedCount,
    ratingAvg,
    ratingCount,
    noShowCount,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'skill_level') final SkillLevel skillLevel,
    final List<PositionType> positions,
    final String? bio,
    @JsonKey(name: 'matches_played_count') final int matchesPlayedCount,
    @JsonKey(name: 'rating_avg') final double ratingAvg,
    @JsonKey(name: 'rating_count') final int ratingCount,
    @JsonKey(name: 'no_show_count') final int noShowCount,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'skill_level')
  SkillLevel get skillLevel;
  @override
  List<PositionType> get positions;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'matches_played_count')
  int get matchesPlayedCount;
  @override
  @JsonKey(name: 'rating_avg')
  double get ratingAvg;
  @override
  @JsonKey(name: 'rating_count')
  int get ratingCount;
  @override
  @JsonKey(name: 'no_show_count')
  int get noShowCount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
