// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_response_with_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentWithMessageResponse _$AppointmentWithMessageResponseFromJson(
  Map<String, dynamic> json,
) {
  return _AppointmentWithMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$AppointmentWithMessageResponse {
  String? get message => throw _privateConstructorUsedError;
  AppointmentResponse? get appointment => throw _privateConstructorUsedError;

  /// Serializes this AppointmentWithMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentWithMessageResponseCopyWith<AppointmentWithMessageResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentWithMessageResponseCopyWith<$Res> {
  factory $AppointmentWithMessageResponseCopyWith(
    AppointmentWithMessageResponse value,
    $Res Function(AppointmentWithMessageResponse) then,
  ) =
      _$AppointmentWithMessageResponseCopyWithImpl<
        $Res,
        AppointmentWithMessageResponse
      >;
  @useResult
  $Res call({String? message, AppointmentResponse? appointment});

  $AppointmentResponseCopyWith<$Res>? get appointment;
}

/// @nodoc
class _$AppointmentWithMessageResponseCopyWithImpl<
  $Res,
  $Val extends AppointmentWithMessageResponse
>
    implements $AppointmentWithMessageResponseCopyWith<$Res> {
  _$AppointmentWithMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? appointment = freezed}) {
    return _then(
      _value.copyWith(
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            appointment:
                freezed == appointment
                    ? _value.appointment
                    : appointment // ignore: cast_nullable_to_non_nullable
                        as AppointmentResponse?,
          )
          as $Val,
    );
  }

  /// Create a copy of AppointmentWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppointmentResponseCopyWith<$Res>? get appointment {
    if (_value.appointment == null) {
      return null;
    }

    return $AppointmentResponseCopyWith<$Res>(_value.appointment!, (value) {
      return _then(_value.copyWith(appointment: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppointmentWithMessageResponseImplCopyWith<$Res>
    implements $AppointmentWithMessageResponseCopyWith<$Res> {
  factory _$$AppointmentWithMessageResponseImplCopyWith(
    _$AppointmentWithMessageResponseImpl value,
    $Res Function(_$AppointmentWithMessageResponseImpl) then,
  ) = __$$AppointmentWithMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, AppointmentResponse? appointment});

  @override
  $AppointmentResponseCopyWith<$Res>? get appointment;
}

/// @nodoc
class __$$AppointmentWithMessageResponseImplCopyWithImpl<$Res>
    extends
        _$AppointmentWithMessageResponseCopyWithImpl<
          $Res,
          _$AppointmentWithMessageResponseImpl
        >
    implements _$$AppointmentWithMessageResponseImplCopyWith<$Res> {
  __$$AppointmentWithMessageResponseImplCopyWithImpl(
    _$AppointmentWithMessageResponseImpl _value,
    $Res Function(_$AppointmentWithMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? appointment = freezed}) {
    return _then(
      _$AppointmentWithMessageResponseImpl(
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        appointment:
            freezed == appointment
                ? _value.appointment
                : appointment // ignore: cast_nullable_to_non_nullable
                    as AppointmentResponse?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentWithMessageResponseImpl
    implements _AppointmentWithMessageResponse {
  const _$AppointmentWithMessageResponseImpl({this.message, this.appointment});

  factory _$AppointmentWithMessageResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AppointmentWithMessageResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final AppointmentResponse? appointment;

  @override
  String toString() {
    return 'AppointmentWithMessageResponse(message: $message, appointment: $appointment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentWithMessageResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.appointment, appointment) ||
                other.appointment == appointment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, appointment);

  /// Create a copy of AppointmentWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentWithMessageResponseImplCopyWith<
    _$AppointmentWithMessageResponseImpl
  >
  get copyWith => __$$AppointmentWithMessageResponseImplCopyWithImpl<
    _$AppointmentWithMessageResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentWithMessageResponseImplToJson(this);
  }
}

abstract class _AppointmentWithMessageResponse
    implements AppointmentWithMessageResponse {
  const factory _AppointmentWithMessageResponse({
    final String? message,
    final AppointmentResponse? appointment,
  }) = _$AppointmentWithMessageResponseImpl;

  factory _AppointmentWithMessageResponse.fromJson(Map<String, dynamic> json) =
      _$AppointmentWithMessageResponseImpl.fromJson;

  @override
  String? get message;
  @override
  AppointmentResponse? get appointment;

  /// Create a copy of AppointmentWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentWithMessageResponseImplCopyWith<
    _$AppointmentWithMessageResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
