// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentResponse _$AppointmentResponseFromJson(Map<String, dynamic> json) {
  return _AppointmentResponse.fromJson(json);
}

/// @nodoc
mixin _$AppointmentResponse {
  @JsonKey(name: "id")
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: "createdAt")
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updatedAt")
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "startTime")
  DateTime? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: "Date")
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: "propertyId")
  int? get propertyId => throw _privateConstructorUsedError;
  @JsonKey(name: "buyerId")
  int? get buyerId => throw _privateConstructorUsedError;
  @JsonKey(name: "sellerId")
  int? get sellerId => throw _privateConstructorUsedError;
  @JsonKey(name: "status")
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this AppointmentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentResponseCopyWith<AppointmentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentResponseCopyWith<$Res> {
  factory $AppointmentResponseCopyWith(
    AppointmentResponse value,
    $Res Function(AppointmentResponse) then,
  ) = _$AppointmentResponseCopyWithImpl<$Res, AppointmentResponse>;
  @useResult
  $Res call({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @JsonKey(name: "startTime") DateTime? startTime,
    @JsonKey(name: "Date") DateTime? date,
    @JsonKey(name: "propertyId") int? propertyId,
    @JsonKey(name: "buyerId") int? buyerId,
    @JsonKey(name: "sellerId") int? sellerId,
    @JsonKey(name: "status") String? status,
  });
}

/// @nodoc
class _$AppointmentResponseCopyWithImpl<$Res, $Val extends AppointmentResponse>
    implements $AppointmentResponseCopyWith<$Res> {
  _$AppointmentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? startTime = freezed,
    Object? date = freezed,
    Object? propertyId = freezed,
    Object? buyerId = freezed,
    Object? sellerId = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            startTime:
                freezed == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            date:
                freezed == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            propertyId:
                freezed == propertyId
                    ? _value.propertyId
                    : propertyId // ignore: cast_nullable_to_non_nullable
                        as int?,
            buyerId:
                freezed == buyerId
                    ? _value.buyerId
                    : buyerId // ignore: cast_nullable_to_non_nullable
                        as int?,
            sellerId:
                freezed == sellerId
                    ? _value.sellerId
                    : sellerId // ignore: cast_nullable_to_non_nullable
                        as int?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentResponseImplCopyWith<$Res>
    implements $AppointmentResponseCopyWith<$Res> {
  factory _$$AppointmentResponseImplCopyWith(
    _$AppointmentResponseImpl value,
    $Res Function(_$AppointmentResponseImpl) then,
  ) = __$$AppointmentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @JsonKey(name: "startTime") DateTime? startTime,
    @JsonKey(name: "Date") DateTime? date,
    @JsonKey(name: "propertyId") int? propertyId,
    @JsonKey(name: "buyerId") int? buyerId,
    @JsonKey(name: "sellerId") int? sellerId,
    @JsonKey(name: "status") String? status,
  });
}

/// @nodoc
class __$$AppointmentResponseImplCopyWithImpl<$Res>
    extends _$AppointmentResponseCopyWithImpl<$Res, _$AppointmentResponseImpl>
    implements _$$AppointmentResponseImplCopyWith<$Res> {
  __$$AppointmentResponseImplCopyWithImpl(
    _$AppointmentResponseImpl _value,
    $Res Function(_$AppointmentResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? startTime = freezed,
    Object? date = freezed,
    Object? propertyId = freezed,
    Object? buyerId = freezed,
    Object? sellerId = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$AppointmentResponseImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        startTime:
            freezed == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        date:
            freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        propertyId:
            freezed == propertyId
                ? _value.propertyId
                : propertyId // ignore: cast_nullable_to_non_nullable
                    as int?,
        buyerId:
            freezed == buyerId
                ? _value.buyerId
                : buyerId // ignore: cast_nullable_to_non_nullable
                    as int?,
        sellerId:
            freezed == sellerId
                ? _value.sellerId
                : sellerId // ignore: cast_nullable_to_non_nullable
                    as int?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentResponseImpl implements _AppointmentResponse {
  const _$AppointmentResponseImpl({
    @JsonKey(name: "id") this.id,
    @JsonKey(name: "createdAt") this.createdAt,
    @JsonKey(name: "updatedAt") this.updatedAt,
    @JsonKey(name: "startTime") this.startTime,
    @JsonKey(name: "Date") this.date,
    @JsonKey(name: "propertyId") this.propertyId,
    @JsonKey(name: "buyerId") this.buyerId,
    @JsonKey(name: "sellerId") this.sellerId,
    @JsonKey(name: "status") this.status,
  });

  factory _$AppointmentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentResponseImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @override
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @override
  @JsonKey(name: "startTime")
  final DateTime? startTime;
  @override
  @JsonKey(name: "Date")
  final DateTime? date;
  @override
  @JsonKey(name: "propertyId")
  final int? propertyId;
  @override
  @JsonKey(name: "buyerId")
  final int? buyerId;
  @override
  @JsonKey(name: "sellerId")
  final int? sellerId;
  @override
  @JsonKey(name: "status")
  final String? status;

  @override
  String toString() {
    return 'AppointmentResponse(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, startTime: $startTime, date: $date, propertyId: $propertyId, buyerId: $buyerId, sellerId: $sellerId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.propertyId, propertyId) ||
                other.propertyId == propertyId) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    createdAt,
    updatedAt,
    startTime,
    date,
    propertyId,
    buyerId,
    sellerId,
    status,
  );

  /// Create a copy of AppointmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentResponseImplCopyWith<_$AppointmentResponseImpl> get copyWith =>
      __$$AppointmentResponseImplCopyWithImpl<_$AppointmentResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentResponseImplToJson(this);
  }
}

abstract class _AppointmentResponse implements AppointmentResponse {
  const factory _AppointmentResponse({
    @JsonKey(name: "id") final int? id,
    @JsonKey(name: "createdAt") final DateTime? createdAt,
    @JsonKey(name: "updatedAt") final DateTime? updatedAt,
    @JsonKey(name: "startTime") final DateTime? startTime,
    @JsonKey(name: "Date") final DateTime? date,
    @JsonKey(name: "propertyId") final int? propertyId,
    @JsonKey(name: "buyerId") final int? buyerId,
    @JsonKey(name: "sellerId") final int? sellerId,
    @JsonKey(name: "status") final String? status,
  }) = _$AppointmentResponseImpl;

  factory _AppointmentResponse.fromJson(Map<String, dynamic> json) =
      _$AppointmentResponseImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int? get id;
  @override
  @JsonKey(name: "createdAt")
  DateTime? get createdAt;
  @override
  @JsonKey(name: "updatedAt")
  DateTime? get updatedAt;
  @override
  @JsonKey(name: "startTime")
  DateTime? get startTime;
  @override
  @JsonKey(name: "Date")
  DateTime? get date;
  @override
  @JsonKey(name: "propertyId")
  int? get propertyId;
  @override
  @JsonKey(name: "buyerId")
  int? get buyerId;
  @override
  @JsonKey(name: "sellerId")
  int? get sellerId;
  @override
  @JsonKey(name: "status")
  String? get status;

  /// Create a copy of AppointmentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentResponseImplCopyWith<_$AppointmentResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
