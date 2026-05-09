// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatMember _$ChatMemberFromJson(Map<String, dynamic> json) {
  return _ChatMember.fromJson(json);
}

/// @nodoc
mixin _$ChatMember {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_id')
  String get chatId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMemberCopyWith<ChatMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMemberCopyWith<$Res> {
  factory $ChatMemberCopyWith(
    ChatMember value,
    $Res Function(ChatMember) then,
  ) = _$ChatMemberCopyWithImpl<$Res, ChatMember>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'chat_id') String chatId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'joined_at') DateTime joinedAt,
  });
}

/// @nodoc
class _$ChatMemberCopyWithImpl<$Res, $Val extends ChatMember>
    implements $ChatMemberCopyWith<$Res> {
  _$ChatMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? userId = null,
    Object? joinedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            chatId: null == chatId
                ? _value.chatId
                : chatId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            joinedAt: null == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMemberImplCopyWith<$Res>
    implements $ChatMemberCopyWith<$Res> {
  factory _$$ChatMemberImplCopyWith(
    _$ChatMemberImpl value,
    $Res Function(_$ChatMemberImpl) then,
  ) = __$$ChatMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'chat_id') String chatId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'joined_at') DateTime joinedAt,
  });
}

/// @nodoc
class __$$ChatMemberImplCopyWithImpl<$Res>
    extends _$ChatMemberCopyWithImpl<$Res, _$ChatMemberImpl>
    implements _$$ChatMemberImplCopyWith<$Res> {
  __$$ChatMemberImplCopyWithImpl(
    _$ChatMemberImpl _value,
    $Res Function(_$ChatMemberImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? userId = null,
    Object? joinedAt = null,
  }) {
    return _then(
      _$ChatMemberImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        chatId: null == chatId
            ? _value.chatId
            : chatId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        joinedAt: null == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMemberImpl implements _ChatMember {
  const _$ChatMemberImpl({
    required this.id,
    @JsonKey(name: 'chat_id') required this.chatId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'joined_at') required this.joinedAt,
  });

  factory _$ChatMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMemberImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'chat_id')
  final String chatId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'joined_at')
  final DateTime joinedAt;

  @override
  String toString() {
    return 'ChatMember(id: $id, chatId: $chatId, userId: $userId, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, chatId, userId, joinedAt);

  /// Create a copy of ChatMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMemberImplCopyWith<_$ChatMemberImpl> get copyWith =>
      __$$ChatMemberImplCopyWithImpl<_$ChatMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMemberImplToJson(this);
  }
}

abstract class _ChatMember implements ChatMember {
  const factory _ChatMember({
    required final String id,
    @JsonKey(name: 'chat_id') required final String chatId,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'joined_at') required final DateTime joinedAt,
  }) = _$ChatMemberImpl;

  factory _ChatMember.fromJson(Map<String, dynamic> json) =
      _$ChatMemberImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'chat_id')
  String get chatId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'joined_at')
  DateTime get joinedAt;

  /// Create a copy of ChatMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMemberImplCopyWith<_$ChatMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
