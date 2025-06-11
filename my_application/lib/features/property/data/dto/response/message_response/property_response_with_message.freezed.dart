// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_response_with_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PropertyWithMessageResponse _$PropertyWithMessageResponseFromJson(
  Map<String, dynamic> json,
) {
  return _PropertyWithMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$PropertyWithMessageResponse {
  String? get message => throw _privateConstructorUsedError;
  PropertyResponse? get property => throw _privateConstructorUsedError;

  /// Serializes this PropertyWithMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PropertyWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertyWithMessageResponseCopyWith<PropertyWithMessageResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyWithMessageResponseCopyWith<$Res> {
  factory $PropertyWithMessageResponseCopyWith(
    PropertyWithMessageResponse value,
    $Res Function(PropertyWithMessageResponse) then,
  ) =
      _$PropertyWithMessageResponseCopyWithImpl<
        $Res,
        PropertyWithMessageResponse
      >;
  @useResult
  $Res call({String? message, PropertyResponse? property});

  $PropertyResponseCopyWith<$Res>? get property;
}

/// @nodoc
class _$PropertyWithMessageResponseCopyWithImpl<
  $Res,
  $Val extends PropertyWithMessageResponse
>
    implements $PropertyWithMessageResponseCopyWith<$Res> {
  _$PropertyWithMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PropertyWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? property = freezed}) {
    return _then(
      _value.copyWith(
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            property:
                freezed == property
                    ? _value.property
                    : property // ignore: cast_nullable_to_non_nullable
                        as PropertyResponse?,
          )
          as $Val,
    );
  }

  /// Create a copy of PropertyWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PropertyResponseCopyWith<$Res>? get property {
    if (_value.property == null) {
      return null;
    }

    return $PropertyResponseCopyWith<$Res>(_value.property!, (value) {
      return _then(_value.copyWith(property: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PropertyWithMessageResponseImplCopyWith<$Res>
    implements $PropertyWithMessageResponseCopyWith<$Res> {
  factory _$$PropertyWithMessageResponseImplCopyWith(
    _$PropertyWithMessageResponseImpl value,
    $Res Function(_$PropertyWithMessageResponseImpl) then,
  ) = __$$PropertyWithMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, PropertyResponse? property});

  @override
  $PropertyResponseCopyWith<$Res>? get property;
}

/// @nodoc
class __$$PropertyWithMessageResponseImplCopyWithImpl<$Res>
    extends
        _$PropertyWithMessageResponseCopyWithImpl<
          $Res,
          _$PropertyWithMessageResponseImpl
        >
    implements _$$PropertyWithMessageResponseImplCopyWith<$Res> {
  __$$PropertyWithMessageResponseImplCopyWithImpl(
    _$PropertyWithMessageResponseImpl _value,
    $Res Function(_$PropertyWithMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PropertyWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? property = freezed}) {
    return _then(
      _$PropertyWithMessageResponseImpl(
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        property:
            freezed == property
                ? _value.property
                : property // ignore: cast_nullable_to_non_nullable
                    as PropertyResponse?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PropertyWithMessageResponseImpl
    implements _PropertyWithMessageResponse {
  const _$PropertyWithMessageResponseImpl({this.message, this.property});

  factory _$PropertyWithMessageResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PropertyWithMessageResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final PropertyResponse? property;

  @override
  String toString() {
    return 'PropertyWithMessageResponse(message: $message, property: $property)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropertyWithMessageResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.property, property) ||
                other.property == property));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, property);

  /// Create a copy of PropertyWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PropertyWithMessageResponseImplCopyWith<_$PropertyWithMessageResponseImpl>
  get copyWith => __$$PropertyWithMessageResponseImplCopyWithImpl<
    _$PropertyWithMessageResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PropertyWithMessageResponseImplToJson(this);
  }
}

abstract class _PropertyWithMessageResponse
    implements PropertyWithMessageResponse {
  const factory _PropertyWithMessageResponse({
    final String? message,
    final PropertyResponse? property,
  }) = _$PropertyWithMessageResponseImpl;

  factory _PropertyWithMessageResponse.fromJson(Map<String, dynamic> json) =
      _$PropertyWithMessageResponseImpl.fromJson;

  @override
  String? get message;
  @override
  PropertyResponse? get property;

  /// Create a copy of PropertyWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PropertyWithMessageResponseImplCopyWith<_$PropertyWithMessageResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
