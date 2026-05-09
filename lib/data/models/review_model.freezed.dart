// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'match_id')
  String get matchId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewer_id')
  String get reviewerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewee_id')
  String get revieweeId => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'match_id') String matchId,
    @JsonKey(name: 'reviewer_id') String reviewerId,
    @JsonKey(name: 'reviewee_id') String revieweeId,
    int stars,
    List<String> tags,
    String? comment,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? reviewerId = null,
    Object? revieweeId = null,
    Object? stars = null,
    Object? tags = null,
    Object? comment = freezed,
    Object? createdAt = null,
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
            reviewerId: null == reviewerId
                ? _value.reviewerId
                : reviewerId // ignore: cast_nullable_to_non_nullable
                      as String,
            revieweeId: null == revieweeId
                ? _value.revieweeId
                : revieweeId // ignore: cast_nullable_to_non_nullable
                      as String,
            stars: null == stars
                ? _value.stars
                : stars // ignore: cast_nullable_to_non_nullable
                      as int,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
    _$ReviewImpl value,
    $Res Function(_$ReviewImpl) then,
  ) = __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'match_id') String matchId,
    @JsonKey(name: 'reviewer_id') String reviewerId,
    @JsonKey(name: 'reviewee_id') String revieweeId,
    int stars,
    List<String> tags,
    String? comment,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
    _$ReviewImpl _value,
    $Res Function(_$ReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? matchId = null,
    Object? reviewerId = null,
    Object? revieweeId = null,
    Object? stars = null,
    Object? tags = null,
    Object? comment = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$ReviewImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        matchId: null == matchId
            ? _value.matchId
            : matchId // ignore: cast_nullable_to_non_nullable
                  as String,
        reviewerId: null == reviewerId
            ? _value.reviewerId
            : reviewerId // ignore: cast_nullable_to_non_nullable
                  as String,
        revieweeId: null == revieweeId
            ? _value.revieweeId
            : revieweeId // ignore: cast_nullable_to_non_nullable
                  as String,
        stars: null == stars
            ? _value.stars
            : stars // ignore: cast_nullable_to_non_nullable
                  as int,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl implements _Review {
  const _$ReviewImpl({
    required this.id,
    @JsonKey(name: 'match_id') required this.matchId,
    @JsonKey(name: 'reviewer_id') required this.reviewerId,
    @JsonKey(name: 'reviewee_id') required this.revieweeId,
    required this.stars,
    final List<String> tags = const [],
    this.comment,
    @JsonKey(name: 'created_at') required this.createdAt,
  }) : _tags = tags;

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'match_id')
  final String matchId;
  @override
  @JsonKey(name: 'reviewer_id')
  final String reviewerId;
  @override
  @JsonKey(name: 'reviewee_id')
  final String revieweeId;
  @override
  final int stars;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? comment;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Review(id: $id, matchId: $matchId, reviewerId: $reviewerId, revieweeId: $revieweeId, stars: $stars, tags: $tags, comment: $comment, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.reviewerId, reviewerId) ||
                other.reviewerId == reviewerId) &&
            (identical(other.revieweeId, revieweeId) ||
                other.revieweeId == revieweeId) &&
            (identical(other.stars, stars) || other.stars == stars) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    matchId,
    reviewerId,
    revieweeId,
    stars,
    const DeepCollectionEquality().hash(_tags),
    comment,
    createdAt,
  );

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(this);
  }
}

abstract class _Review implements Review {
  const factory _Review({
    required final String id,
    @JsonKey(name: 'match_id') required final String matchId,
    @JsonKey(name: 'reviewer_id') required final String reviewerId,
    @JsonKey(name: 'reviewee_id') required final String revieweeId,
    required final int stars,
    final List<String> tags,
    final String? comment,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$ReviewImpl;

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'match_id')
  String get matchId;
  @override
  @JsonKey(name: 'reviewer_id')
  String get reviewerId;
  @override
  @JsonKey(name: 'reviewee_id')
  String get revieweeId;
  @override
  int get stars;
  @override
  List<String> get tags;
  @override
  String? get comment;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
