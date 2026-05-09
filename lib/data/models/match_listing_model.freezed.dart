// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MatchListing _$MatchListingFromJson(Map<String, dynamic> json) {
  return _MatchListing.fromJson(json);
}

/// @nodoc
mixin _$MatchListing {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'organizer_id')
  String get organizerId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'pitch_name')
  String get pitchName => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  @JsonKey(name: 'starts_at')
  DateTime get startsAt => throw _privateConstructorUsedError;
  MatchFormat get format => throw _privateConstructorUsedError;
  @JsonKey(name: 'needed_count')
  int get neededCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'needed_positions')
  List<PositionType> get neededPositions => throw _privateConstructorUsedError;
  @JsonKey(name: 'skill_level')
  SkillLevel get skillLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_type')
  PriceType get priceType => throw _privateConstructorUsedError;
  @JsonKey(name: 'base_price')
  int get basePrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'negotiation_enabled')
  bool get negotiationEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancel_window_hours')
  int get cancelWindowHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'late_tolerance_min')
  int get lateToleranceMin => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method')
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_quality_score')
  double get minQualityScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancellation_level')
  CancellationLevel get cancellationLevel => throw _privateConstructorUsedError;
  ListingStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MatchListing to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchListingCopyWith<MatchListing> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchListingCopyWith<$Res> {
  factory $MatchListingCopyWith(
    MatchListing value,
    $Res Function(MatchListing) then,
  ) = _$MatchListingCopyWithImpl<$Res, MatchListing>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'organizer_id') String organizerId,
    String title,
    String? description,
    @JsonKey(name: 'pitch_name') String pitchName,
    double lat,
    double lng,
    @JsonKey(name: 'starts_at') DateTime startsAt,
    MatchFormat format,
    @JsonKey(name: 'needed_count') int neededCount,
    @JsonKey(name: 'needed_positions') List<PositionType> neededPositions,
    @JsonKey(name: 'skill_level') SkillLevel skillLevel,
    @JsonKey(name: 'price_type') PriceType priceType,
    @JsonKey(name: 'base_price') int basePrice,
    @JsonKey(name: 'negotiation_enabled') bool negotiationEnabled,
    @JsonKey(name: 'cancel_window_hours') int cancelWindowHours,
    @JsonKey(name: 'late_tolerance_min') int lateToleranceMin,
    @JsonKey(name: 'payment_method') PaymentMethod paymentMethod,
    @JsonKey(name: 'min_quality_score') double minQualityScore,
    @JsonKey(name: 'cancellation_level') CancellationLevel cancellationLevel,
    ListingStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$MatchListingCopyWithImpl<$Res, $Val extends MatchListing>
    implements $MatchListingCopyWith<$Res> {
  _$MatchListingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizerId = null,
    Object? title = null,
    Object? description = freezed,
    Object? pitchName = null,
    Object? lat = null,
    Object? lng = null,
    Object? startsAt = null,
    Object? format = null,
    Object? neededCount = null,
    Object? neededPositions = null,
    Object? skillLevel = null,
    Object? priceType = null,
    Object? basePrice = null,
    Object? negotiationEnabled = null,
    Object? cancelWindowHours = null,
    Object? lateToleranceMin = null,
    Object? paymentMethod = null,
    Object? minQualityScore = null,
    Object? cancellationLevel = null,
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
            organizerId: null == organizerId
                ? _value.organizerId
                : organizerId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            pitchName: null == pitchName
                ? _value.pitchName
                : pitchName // ignore: cast_nullable_to_non_nullable
                      as String,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            startsAt: null == startsAt
                ? _value.startsAt
                : startsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            format: null == format
                ? _value.format
                : format // ignore: cast_nullable_to_non_nullable
                      as MatchFormat,
            neededCount: null == neededCount
                ? _value.neededCount
                : neededCount // ignore: cast_nullable_to_non_nullable
                      as int,
            neededPositions: null == neededPositions
                ? _value.neededPositions
                : neededPositions // ignore: cast_nullable_to_non_nullable
                      as List<PositionType>,
            skillLevel: null == skillLevel
                ? _value.skillLevel
                : skillLevel // ignore: cast_nullable_to_non_nullable
                      as SkillLevel,
            priceType: null == priceType
                ? _value.priceType
                : priceType // ignore: cast_nullable_to_non_nullable
                      as PriceType,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as int,
            negotiationEnabled: null == negotiationEnabled
                ? _value.negotiationEnabled
                : negotiationEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            cancelWindowHours: null == cancelWindowHours
                ? _value.cancelWindowHours
                : cancelWindowHours // ignore: cast_nullable_to_non_nullable
                      as int,
            lateToleranceMin: null == lateToleranceMin
                ? _value.lateToleranceMin
                : lateToleranceMin // ignore: cast_nullable_to_non_nullable
                      as int,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            minQualityScore: null == minQualityScore
                ? _value.minQualityScore
                : minQualityScore // ignore: cast_nullable_to_non_nullable
                      as double,
            cancellationLevel: null == cancellationLevel
                ? _value.cancellationLevel
                : cancellationLevel // ignore: cast_nullable_to_non_nullable
                      as CancellationLevel,
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
abstract class _$$MatchListingImplCopyWith<$Res>
    implements $MatchListingCopyWith<$Res> {
  factory _$$MatchListingImplCopyWith(
    _$MatchListingImpl value,
    $Res Function(_$MatchListingImpl) then,
  ) = __$$MatchListingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'organizer_id') String organizerId,
    String title,
    String? description,
    @JsonKey(name: 'pitch_name') String pitchName,
    double lat,
    double lng,
    @JsonKey(name: 'starts_at') DateTime startsAt,
    MatchFormat format,
    @JsonKey(name: 'needed_count') int neededCount,
    @JsonKey(name: 'needed_positions') List<PositionType> neededPositions,
    @JsonKey(name: 'skill_level') SkillLevel skillLevel,
    @JsonKey(name: 'price_type') PriceType priceType,
    @JsonKey(name: 'base_price') int basePrice,
    @JsonKey(name: 'negotiation_enabled') bool negotiationEnabled,
    @JsonKey(name: 'cancel_window_hours') int cancelWindowHours,
    @JsonKey(name: 'late_tolerance_min') int lateToleranceMin,
    @JsonKey(name: 'payment_method') PaymentMethod paymentMethod,
    @JsonKey(name: 'min_quality_score') double minQualityScore,
    @JsonKey(name: 'cancellation_level') CancellationLevel cancellationLevel,
    ListingStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$MatchListingImplCopyWithImpl<$Res>
    extends _$MatchListingCopyWithImpl<$Res, _$MatchListingImpl>
    implements _$$MatchListingImplCopyWith<$Res> {
  __$$MatchListingImplCopyWithImpl(
    _$MatchListingImpl _value,
    $Res Function(_$MatchListingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MatchListing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizerId = null,
    Object? title = null,
    Object? description = freezed,
    Object? pitchName = null,
    Object? lat = null,
    Object? lng = null,
    Object? startsAt = null,
    Object? format = null,
    Object? neededCount = null,
    Object? neededPositions = null,
    Object? skillLevel = null,
    Object? priceType = null,
    Object? basePrice = null,
    Object? negotiationEnabled = null,
    Object? cancelWindowHours = null,
    Object? lateToleranceMin = null,
    Object? paymentMethod = null,
    Object? minQualityScore = null,
    Object? cancellationLevel = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$MatchListingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        organizerId: null == organizerId
            ? _value.organizerId
            : organizerId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        pitchName: null == pitchName
            ? _value.pitchName
            : pitchName // ignore: cast_nullable_to_non_nullable
                  as String,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        startsAt: null == startsAt
            ? _value.startsAt
            : startsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        format: null == format
            ? _value.format
            : format // ignore: cast_nullable_to_non_nullable
                  as MatchFormat,
        neededCount: null == neededCount
            ? _value.neededCount
            : neededCount // ignore: cast_nullable_to_non_nullable
                  as int,
        neededPositions: null == neededPositions
            ? _value._neededPositions
            : neededPositions // ignore: cast_nullable_to_non_nullable
                  as List<PositionType>,
        skillLevel: null == skillLevel
            ? _value.skillLevel
            : skillLevel // ignore: cast_nullable_to_non_nullable
                  as SkillLevel,
        priceType: null == priceType
            ? _value.priceType
            : priceType // ignore: cast_nullable_to_non_nullable
                  as PriceType,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as int,
        negotiationEnabled: null == negotiationEnabled
            ? _value.negotiationEnabled
            : negotiationEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        cancelWindowHours: null == cancelWindowHours
            ? _value.cancelWindowHours
            : cancelWindowHours // ignore: cast_nullable_to_non_nullable
                  as int,
        lateToleranceMin: null == lateToleranceMin
            ? _value.lateToleranceMin
            : lateToleranceMin // ignore: cast_nullable_to_non_nullable
                  as int,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        minQualityScore: null == minQualityScore
            ? _value.minQualityScore
            : minQualityScore // ignore: cast_nullable_to_non_nullable
                  as double,
        cancellationLevel: null == cancellationLevel
            ? _value.cancellationLevel
            : cancellationLevel // ignore: cast_nullable_to_non_nullable
                  as CancellationLevel,
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
class _$MatchListingImpl implements _MatchListing {
  const _$MatchListingImpl({
    required this.id,
    @JsonKey(name: 'organizer_id') required this.organizerId,
    required this.title,
    this.description,
    @JsonKey(name: 'pitch_name') required this.pitchName,
    required this.lat,
    required this.lng,
    @JsonKey(name: 'starts_at') required this.startsAt,
    required this.format,
    @JsonKey(name: 'needed_count') required this.neededCount,
    @JsonKey(name: 'needed_positions')
    final List<PositionType> neededPositions = const [],
    @JsonKey(name: 'skill_level') required this.skillLevel,
    @JsonKey(name: 'price_type') required this.priceType,
    @JsonKey(name: 'base_price') this.basePrice = 0,
    @JsonKey(name: 'negotiation_enabled') this.negotiationEnabled = false,
    @JsonKey(name: 'cancel_window_hours') this.cancelWindowHours = 2,
    @JsonKey(name: 'late_tolerance_min') this.lateToleranceMin = 15,
    @JsonKey(name: 'payment_method') this.paymentMethod = PaymentMethod.cash,
    @JsonKey(name: 'min_quality_score') this.minQualityScore = 0.0,
    @JsonKey(name: 'cancellation_level')
    this.cancellationLevel = CancellationLevel.medium,
    this.status = ListingStatus.open,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : _neededPositions = neededPositions;

  factory _$MatchListingImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchListingImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'organizer_id')
  final String organizerId;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'pitch_name')
  final String pitchName;
  @override
  final double lat;
  @override
  final double lng;
  @override
  @JsonKey(name: 'starts_at')
  final DateTime startsAt;
  @override
  final MatchFormat format;
  @override
  @JsonKey(name: 'needed_count')
  final int neededCount;
  final List<PositionType> _neededPositions;
  @override
  @JsonKey(name: 'needed_positions')
  List<PositionType> get neededPositions {
    if (_neededPositions is EqualUnmodifiableListView) return _neededPositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_neededPositions);
  }

  @override
  @JsonKey(name: 'skill_level')
  final SkillLevel skillLevel;
  @override
  @JsonKey(name: 'price_type')
  final PriceType priceType;
  @override
  @JsonKey(name: 'base_price')
  final int basePrice;
  @override
  @JsonKey(name: 'negotiation_enabled')
  final bool negotiationEnabled;
  @override
  @JsonKey(name: 'cancel_window_hours')
  final int cancelWindowHours;
  @override
  @JsonKey(name: 'late_tolerance_min')
  final int lateToleranceMin;
  @override
  @JsonKey(name: 'payment_method')
  final PaymentMethod paymentMethod;
  @override
  @JsonKey(name: 'min_quality_score')
  final double minQualityScore;
  @override
  @JsonKey(name: 'cancellation_level')
  final CancellationLevel cancellationLevel;
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
    return 'MatchListing(id: $id, organizerId: $organizerId, title: $title, description: $description, pitchName: $pitchName, lat: $lat, lng: $lng, startsAt: $startsAt, format: $format, neededCount: $neededCount, neededPositions: $neededPositions, skillLevel: $skillLevel, priceType: $priceType, basePrice: $basePrice, negotiationEnabled: $negotiationEnabled, cancelWindowHours: $cancelWindowHours, lateToleranceMin: $lateToleranceMin, paymentMethod: $paymentMethod, minQualityScore: $minQualityScore, cancellationLevel: $cancellationLevel, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchListingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.pitchName, pitchName) ||
                other.pitchName == pitchName) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.startsAt, startsAt) ||
                other.startsAt == startsAt) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.neededCount, neededCount) ||
                other.neededCount == neededCount) &&
            const DeepCollectionEquality().equals(
              other._neededPositions,
              _neededPositions,
            ) &&
            (identical(other.skillLevel, skillLevel) ||
                other.skillLevel == skillLevel) &&
            (identical(other.priceType, priceType) ||
                other.priceType == priceType) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.negotiationEnabled, negotiationEnabled) ||
                other.negotiationEnabled == negotiationEnabled) &&
            (identical(other.cancelWindowHours, cancelWindowHours) ||
                other.cancelWindowHours == cancelWindowHours) &&
            (identical(other.lateToleranceMin, lateToleranceMin) ||
                other.lateToleranceMin == lateToleranceMin) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.minQualityScore, minQualityScore) ||
                other.minQualityScore == minQualityScore) &&
            (identical(other.cancellationLevel, cancellationLevel) ||
                other.cancellationLevel == cancellationLevel) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    organizerId,
    title,
    description,
    pitchName,
    lat,
    lng,
    startsAt,
    format,
    neededCount,
    const DeepCollectionEquality().hash(_neededPositions),
    skillLevel,
    priceType,
    basePrice,
    negotiationEnabled,
    cancelWindowHours,
    lateToleranceMin,
    paymentMethod,
    minQualityScore,
    cancellationLevel,
    status,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of MatchListing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchListingImplCopyWith<_$MatchListingImpl> get copyWith =>
      __$$MatchListingImplCopyWithImpl<_$MatchListingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchListingImplToJson(this);
  }
}

abstract class _MatchListing implements MatchListing {
  const factory _MatchListing({
    required final String id,
    @JsonKey(name: 'organizer_id') required final String organizerId,
    required final String title,
    final String? description,
    @JsonKey(name: 'pitch_name') required final String pitchName,
    required final double lat,
    required final double lng,
    @JsonKey(name: 'starts_at') required final DateTime startsAt,
    required final MatchFormat format,
    @JsonKey(name: 'needed_count') required final int neededCount,
    @JsonKey(name: 'needed_positions') final List<PositionType> neededPositions,
    @JsonKey(name: 'skill_level') required final SkillLevel skillLevel,
    @JsonKey(name: 'price_type') required final PriceType priceType,
    @JsonKey(name: 'base_price') final int basePrice,
    @JsonKey(name: 'negotiation_enabled') final bool negotiationEnabled,
    @JsonKey(name: 'cancel_window_hours') final int cancelWindowHours,
    @JsonKey(name: 'late_tolerance_min') final int lateToleranceMin,
    @JsonKey(name: 'payment_method') final PaymentMethod paymentMethod,
    @JsonKey(name: 'min_quality_score') final double minQualityScore,
    @JsonKey(name: 'cancellation_level')
    final CancellationLevel cancellationLevel,
    final ListingStatus status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$MatchListingImpl;

  factory _MatchListing.fromJson(Map<String, dynamic> json) =
      _$MatchListingImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'organizer_id')
  String get organizerId;
  @override
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'pitch_name')
  String get pitchName;
  @override
  double get lat;
  @override
  double get lng;
  @override
  @JsonKey(name: 'starts_at')
  DateTime get startsAt;
  @override
  MatchFormat get format;
  @override
  @JsonKey(name: 'needed_count')
  int get neededCount;
  @override
  @JsonKey(name: 'needed_positions')
  List<PositionType> get neededPositions;
  @override
  @JsonKey(name: 'skill_level')
  SkillLevel get skillLevel;
  @override
  @JsonKey(name: 'price_type')
  PriceType get priceType;
  @override
  @JsonKey(name: 'base_price')
  int get basePrice;
  @override
  @JsonKey(name: 'negotiation_enabled')
  bool get negotiationEnabled;
  @override
  @JsonKey(name: 'cancel_window_hours')
  int get cancelWindowHours;
  @override
  @JsonKey(name: 'late_tolerance_min')
  int get lateToleranceMin;
  @override
  @JsonKey(name: 'payment_method')
  PaymentMethod get paymentMethod;
  @override
  @JsonKey(name: 'min_quality_score')
  double get minQualityScore;
  @override
  @JsonKey(name: 'cancellation_level')
  CancellationLevel get cancellationLevel;
  @override
  ListingStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of MatchListing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchListingImplCopyWith<_$MatchListingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
