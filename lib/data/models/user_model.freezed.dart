// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_verified_at')
  DateTime? get phoneVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'email_verified_at')
  DateTime? get emailVerifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_year')
  int? get birthYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'home_lat')
  double? get homeLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'home_lng')
  double? get homeLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_admin')
  bool get isAdmin => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_banned')
  bool get isBanned => throw _privateConstructorUsedError;
  @JsonKey(name: 'kvkk_accepted_at')
  DateTime? get kvkkAcceptedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call({
    String id,
    String phone,
    String? email,
    @JsonKey(name: 'phone_verified_at') DateTime? phoneVerifiedAt,
    @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'birth_year') int? birthYear,
    @JsonKey(name: 'home_lat') double? homeLat,
    @JsonKey(name: 'home_lng') double? homeLng,
    @JsonKey(name: 'is_admin') bool isAdmin,
    @JsonKey(name: 'is_banned') bool isBanned,
    @JsonKey(name: 'kvkk_accepted_at') DateTime? kvkkAcceptedAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? email = freezed,
    Object? phoneVerifiedAt = freezed,
    Object? emailVerifiedAt = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? birthYear = freezed,
    Object? homeLat = freezed,
    Object? homeLng = freezed,
    Object? isAdmin = null,
    Object? isBanned = null,
    Object? kvkkAcceptedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneVerifiedAt: freezed == phoneVerifiedAt
                ? _value.phoneVerifiedAt
                : phoneVerifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            emailVerifiedAt: freezed == emailVerifiedAt
                ? _value.emailVerifiedAt
                : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            birthYear: freezed == birthYear
                ? _value.birthYear
                : birthYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            homeLat: freezed == homeLat
                ? _value.homeLat
                : homeLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            homeLng: freezed == homeLng
                ? _value.homeLng
                : homeLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            isAdmin: null == isAdmin
                ? _value.isAdmin
                : isAdmin // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBanned: null == isBanned
                ? _value.isBanned
                : isBanned // ignore: cast_nullable_to_non_nullable
                      as bool,
            kvkkAcceptedAt: freezed == kvkkAcceptedAt
                ? _value.kvkkAcceptedAt
                : kvkkAcceptedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
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
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
    _$UserImpl value,
    $Res Function(_$UserImpl) then,
  ) = __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String phone,
    String? email,
    @JsonKey(name: 'phone_verified_at') DateTime? phoneVerifiedAt,
    @JsonKey(name: 'email_verified_at') DateTime? emailVerifiedAt,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'birth_year') int? birthYear,
    @JsonKey(name: 'home_lat') double? homeLat,
    @JsonKey(name: 'home_lng') double? homeLng,
    @JsonKey(name: 'is_admin') bool isAdmin,
    @JsonKey(name: 'is_banned') bool isBanned,
    @JsonKey(name: 'kvkk_accepted_at') DateTime? kvkkAcceptedAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
    : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phone = null,
    Object? email = freezed,
    Object? phoneVerifiedAt = freezed,
    Object? emailVerifiedAt = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? birthYear = freezed,
    Object? homeLat = freezed,
    Object? homeLng = freezed,
    Object? isAdmin = null,
    Object? isBanned = null,
    Object? kvkkAcceptedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneVerifiedAt: freezed == phoneVerifiedAt
            ? _value.phoneVerifiedAt
            : phoneVerifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        emailVerifiedAt: freezed == emailVerifiedAt
            ? _value.emailVerifiedAt
            : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        birthYear: freezed == birthYear
            ? _value.birthYear
            : birthYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        homeLat: freezed == homeLat
            ? _value.homeLat
            : homeLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        homeLng: freezed == homeLng
            ? _value.homeLng
            : homeLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        isAdmin: null == isAdmin
            ? _value.isAdmin
            : isAdmin // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBanned: null == isBanned
            ? _value.isBanned
            : isBanned // ignore: cast_nullable_to_non_nullable
                  as bool,
        kvkkAcceptedAt: freezed == kvkkAcceptedAt
            ? _value.kvkkAcceptedAt
            : kvkkAcceptedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
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
class _$UserImpl implements _User {
  const _$UserImpl({
    required this.id,
    required this.phone,
    this.email,
    @JsonKey(name: 'phone_verified_at') this.phoneVerifiedAt,
    @JsonKey(name: 'email_verified_at') this.emailVerifiedAt,
    @JsonKey(name: 'display_name') this.displayName,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'birth_year') this.birthYear,
    @JsonKey(name: 'home_lat') this.homeLat,
    @JsonKey(name: 'home_lng') this.homeLng,
    @JsonKey(name: 'is_admin') this.isAdmin = false,
    @JsonKey(name: 'is_banned') this.isBanned = false,
    @JsonKey(name: 'kvkk_accepted_at') this.kvkkAcceptedAt,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String phone;
  @override
  final String? email;
  @override
  @JsonKey(name: 'phone_verified_at')
  final DateTime? phoneVerifiedAt;
  @override
  @JsonKey(name: 'email_verified_at')
  final DateTime? emailVerifiedAt;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'birth_year')
  final int? birthYear;
  @override
  @JsonKey(name: 'home_lat')
  final double? homeLat;
  @override
  @JsonKey(name: 'home_lng')
  final double? homeLng;
  @override
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
  @override
  @JsonKey(name: 'is_banned')
  final bool isBanned;
  @override
  @JsonKey(name: 'kvkk_accepted_at')
  final DateTime? kvkkAcceptedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(id: $id, phone: $phone, email: $email, phoneVerifiedAt: $phoneVerifiedAt, emailVerifiedAt: $emailVerifiedAt, displayName: $displayName, avatarUrl: $avatarUrl, birthYear: $birthYear, homeLat: $homeLat, homeLng: $homeLng, isAdmin: $isAdmin, isBanned: $isBanned, kvkkAcceptedAt: $kvkkAcceptedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneVerifiedAt, phoneVerifiedAt) ||
                other.phoneVerifiedAt == phoneVerifiedAt) &&
            (identical(other.emailVerifiedAt, emailVerifiedAt) ||
                other.emailVerifiedAt == emailVerifiedAt) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.birthYear, birthYear) ||
                other.birthYear == birthYear) &&
            (identical(other.homeLat, homeLat) || other.homeLat == homeLat) &&
            (identical(other.homeLng, homeLng) || other.homeLng == homeLng) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isBanned, isBanned) ||
                other.isBanned == isBanned) &&
            (identical(other.kvkkAcceptedAt, kvkkAcceptedAt) ||
                other.kvkkAcceptedAt == kvkkAcceptedAt) &&
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
    phone,
    email,
    phoneVerifiedAt,
    emailVerifiedAt,
    displayName,
    avatarUrl,
    birthYear,
    homeLat,
    homeLng,
    isAdmin,
    isBanned,
    kvkkAcceptedAt,
    createdAt,
    updatedAt,
  );

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(this);
  }
}

abstract class _User implements User {
  const factory _User({
    required final String id,
    required final String phone,
    final String? email,
    @JsonKey(name: 'phone_verified_at') final DateTime? phoneVerifiedAt,
    @JsonKey(name: 'email_verified_at') final DateTime? emailVerifiedAt,
    @JsonKey(name: 'display_name') final String? displayName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'birth_year') final int? birthYear,
    @JsonKey(name: 'home_lat') final double? homeLat,
    @JsonKey(name: 'home_lng') final double? homeLng,
    @JsonKey(name: 'is_admin') final bool isAdmin,
    @JsonKey(name: 'is_banned') final bool isBanned,
    @JsonKey(name: 'kvkk_accepted_at') final DateTime? kvkkAcceptedAt,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get phone;
  @override
  String? get email;
  @override
  @JsonKey(name: 'phone_verified_at')
  DateTime? get phoneVerifiedAt;
  @override
  @JsonKey(name: 'email_verified_at')
  DateTime? get emailVerifiedAt;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'birth_year')
  int? get birthYear;
  @override
  @JsonKey(name: 'home_lat')
  double? get homeLat;
  @override
  @JsonKey(name: 'home_lng')
  double? get homeLng;
  @override
  @JsonKey(name: 'is_admin')
  bool get isAdmin;
  @override
  @JsonKey(name: 'is_banned')
  bool get isBanned;
  @override
  @JsonKey(name: 'kvkk_accepted_at')
  DateTime? get kvkkAcceptedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
