// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentRequest _$AppointmentRequestFromJson(Map<String, dynamic> json) {
  return _AppointmentRequest.fromJson(json);
}

/// @nodoc
mixin _$AppointmentRequest {
  @JsonKey(name: "propertyId")
  int? get propertyId => throw _privateConstructorUsedError;
  @JsonKey(name: "Date")
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: "startTime")
  DateTime? get startTime => throw _privateConstructorUsedError;

  /// Serializes this AppointmentRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentRequestCopyWith<AppointmentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentRequestCopyWith<$Res> {
  factory $AppointmentRequestCopyWith(
    AppointmentRequest value,
    $Res Function(AppointmentRequest) then,
  ) = _$AppointmentRequestCopyWithImpl<$Res, AppointmentRequest>;
  @useResult
  $Res call({
    @JsonKey(name: "propertyId") int? propertyId,
    @JsonKey(name: "Date") DateTime? date,
    @JsonKey(name: "startTime") DateTime? startTime,
  });
}

/// @nodoc
class _$AppointmentRequestCopyWithImpl<$Res, $Val extends AppointmentRequest>
    implements $AppointmentRequestCopyWith<$Res> {
  _$AppointmentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyId = freezed,
    Object? date = freezed,
    Object? startTime = freezed,
  }) {
    return _then(
      _value.copyWith(
            propertyId:
                freezed == propertyId
                    ? _value.propertyId
                    : propertyId // ignore: cast_nullable_to_non_nullable
                        as int?,
            date:
                freezed == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            startTime:
                freezed == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentRequestImplCopyWith<$Res>
    implements $AppointmentRequestCopyWith<$Res> {
  factory _$$AppointmentRequestImplCopyWith(
    _$AppointmentRequestImpl value,
    $Res Function(_$AppointmentRequestImpl) then,
  ) = __$$AppointmentRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: "propertyId") int? propertyId,
    @JsonKey(name: "Date") DateTime? date,
    @JsonKey(name: "startTime") DateTime? startTime,
  });
}

/// @nodoc
class __$$AppointmentRequestImplCopyWithImpl<$Res>
    extends _$AppointmentRequestCopyWithImpl<$Res, _$AppointmentRequestImpl>
    implements _$$AppointmentRequestImplCopyWith<$Res> {
  __$$AppointmentRequestImplCopyWithImpl(
    _$AppointmentRequestImpl _value,
    $Res Function(_$AppointmentRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyId = freezed,
    Object? date = freezed,
    Object? startTime = freezed,
  }) {
    return _then(
      _$AppointmentRequestImpl(
        propertyId:
            freezed == propertyId
                ? _value.propertyId
                : propertyId // ignore: cast_nullable_to_non_nullable
                    as int?,
        date:
            freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        startTime:
            freezed == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentRequestImpl implements _AppointmentRequest {
  const _$AppointmentRequestImpl({
    @JsonKey(name: "propertyId") this.propertyId,
    @JsonKey(name: "Date") this.date,
    @JsonKey(name: "startTime") this.startTime,
  });

  factory _$AppointmentRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentRequestImplFromJson(json);

  @override
  @JsonKey(name: "propertyId")
  final int? propertyId;
  @override
  @JsonKey(name: "Date")
  final DateTime? date;
  @override
  @JsonKey(name: "startTime")
  final DateTime? startTime;

  @override
  String toString() {
    return 'AppointmentRequest(propertyId: $propertyId, date: $date, startTime: $startTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentRequestImpl &&
            (identical(other.propertyId, propertyId) ||
                other.propertyId == propertyId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, propertyId, date, startTime);

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentRequestImplCopyWith<_$AppointmentRequestImpl> get copyWith =>
      __$$AppointmentRequestImplCopyWithImpl<_$AppointmentRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentRequestImplToJson(this);
  }
}

abstract class _AppointmentRequest implements AppointmentRequest {
  const factory _AppointmentRequest({
    @JsonKey(name: "propertyId") final int? propertyId,
    @JsonKey(name: "Date") final DateTime? date,
    @JsonKey(name: "startTime") final DateTime? startTime,
  }) = _$AppointmentRequestImpl;

  factory _AppointmentRequest.fromJson(Map<String, dynamic> json) =
      _$AppointmentRequestImpl.fromJson;

  @override
  @JsonKey(name: "propertyId")
  int? get propertyId;
  @override
  @JsonKey(name: "Date")
  DateTime? get date;
  @override
  @JsonKey(name: "startTime")
  DateTime? get startTime;

  /// Create a copy of AppointmentRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentRequestImplCopyWith<_$AppointmentRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
