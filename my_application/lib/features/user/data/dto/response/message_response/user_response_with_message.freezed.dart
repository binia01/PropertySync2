// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_response_with_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserWithMessageResponse _$UserWithMessageResponseFromJson(
  Map<String, dynamic> json,
) {
  return _UserWithMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$UserWithMessageResponse {
  String? get message => throw _privateConstructorUsedError;
  UserResponse? get user => throw _privateConstructorUsedError;

  /// Serializes this UserWithMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserWithMessageResponseCopyWith<UserWithMessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWithMessageResponseCopyWith<$Res> {
  factory $UserWithMessageResponseCopyWith(
    UserWithMessageResponse value,
    $Res Function(UserWithMessageResponse) then,
  ) = _$UserWithMessageResponseCopyWithImpl<$Res, UserWithMessageResponse>;
  @useResult
  $Res call({String? message, UserResponse? user});

  $UserResponseCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserWithMessageResponseCopyWithImpl<
  $Res,
  $Val extends UserWithMessageResponse
>
    implements $UserWithMessageResponseCopyWith<$Res> {
  _$UserWithMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? user = freezed}) {
    return _then(
      _value.copyWith(
            message:
                freezed == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String?,
            user:
                freezed == user
                    ? _value.user
                    : user // ignore: cast_nullable_to_non_nullable
                        as UserResponse?,
          )
          as $Val,
    );
  }

  /// Create a copy of UserWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserResponseCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserResponseCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserWithMessageResponseImplCopyWith<$Res>
    implements $UserWithMessageResponseCopyWith<$Res> {
  factory _$$UserWithMessageResponseImplCopyWith(
    _$UserWithMessageResponseImpl value,
    $Res Function(_$UserWithMessageResponseImpl) then,
  ) = __$$UserWithMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, UserResponse? user});

  @override
  $UserResponseCopyWith<$Res>? get user;
}

/// @nodoc
class __$$UserWithMessageResponseImplCopyWithImpl<$Res>
    extends
        _$UserWithMessageResponseCopyWithImpl<
          $Res,
          _$UserWithMessageResponseImpl
        >
    implements _$$UserWithMessageResponseImplCopyWith<$Res> {
  __$$UserWithMessageResponseImplCopyWithImpl(
    _$UserWithMessageResponseImpl _value,
    $Res Function(_$UserWithMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? user = freezed}) {
    return _then(
      _$UserWithMessageResponseImpl(
        message:
            freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String?,
        user:
            freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                    as UserResponse?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserWithMessageResponseImpl implements _UserWithMessageResponse {
  const _$UserWithMessageResponseImpl({this.message, this.user});

  factory _$UserWithMessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserWithMessageResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final UserResponse? user;

  @override
  String toString() {
    return 'UserWithMessageResponse(message: $message, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserWithMessageResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, user);

  /// Create a copy of UserWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserWithMessageResponseImplCopyWith<_$UserWithMessageResponseImpl>
  get copyWith => __$$UserWithMessageResponseImplCopyWithImpl<
    _$UserWithMessageResponseImpl
  >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserWithMessageResponseImplToJson(this);
  }
}

abstract class _UserWithMessageResponse implements UserWithMessageResponse {
  const factory _UserWithMessageResponse({
    final String? message,
    final UserResponse? user,
  }) = _$UserWithMessageResponseImpl;

  factory _UserWithMessageResponse.fromJson(Map<String, dynamic> json) =
      _$UserWithMessageResponseImpl.fromJson;

  @override
  String? get message;
  @override
  UserResponse? get user;

  /// Create a copy of UserWithMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserWithMessageResponseImplCopyWith<_$UserWithMessageResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
