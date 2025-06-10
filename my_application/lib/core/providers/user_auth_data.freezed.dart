// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_auth_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserAuthData _$UserAuthDataFromJson(Map<String, dynamic> json) {
  return _UserAuthData.fromJson(json);
}

/// @nodoc
mixin _$UserAuthData {
  String? get role => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;

  /// Serializes this UserAuthData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAuthDataCopyWith<UserAuthData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAuthDataCopyWith<$Res> {
  factory $UserAuthDataCopyWith(
    UserAuthData value,
    $Res Function(UserAuthData) then,
  ) = _$UserAuthDataCopyWithImpl<$Res, UserAuthData>;
  @useResult
  $Res call({String? role, String? userId});
}

/// @nodoc
class _$UserAuthDataCopyWithImpl<$Res, $Val extends UserAuthData>
    implements $UserAuthDataCopyWith<$Res> {
  _$UserAuthDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = freezed, Object? userId = freezed}) {
    return _then(
      _value.copyWith(
            role:
                freezed == role
                    ? _value.role
                    : role // ignore: cast_nullable_to_non_nullable
                        as String?,
            userId:
                freezed == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAuthDataImplCopyWith<$Res>
    implements $UserAuthDataCopyWith<$Res> {
  factory _$$UserAuthDataImplCopyWith(
    _$UserAuthDataImpl value,
    $Res Function(_$UserAuthDataImpl) then,
  ) = __$$UserAuthDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? role, String? userId});
}

/// @nodoc
class __$$UserAuthDataImplCopyWithImpl<$Res>
    extends _$UserAuthDataCopyWithImpl<$Res, _$UserAuthDataImpl>
    implements _$$UserAuthDataImplCopyWith<$Res> {
  __$$UserAuthDataImplCopyWithImpl(
    _$UserAuthDataImpl _value,
    $Res Function(_$UserAuthDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAuthData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = freezed, Object? userId = freezed}) {
    return _then(
      _$UserAuthDataImpl(
        role:
            freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                    as String?,
        userId:
            freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAuthDataImpl implements _UserAuthData {
  const _$UserAuthDataImpl({this.role, this.userId});

  factory _$UserAuthDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAuthDataImplFromJson(json);

  @override
  final String? role;
  @override
  final String? userId;

  @override
  String toString() {
    return 'UserAuthData(role: $role, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAuthDataImpl &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, userId);

  /// Create a copy of UserAuthData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAuthDataImplCopyWith<_$UserAuthDataImpl> get copyWith =>
      __$$UserAuthDataImplCopyWithImpl<_$UserAuthDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAuthDataImplToJson(this);
  }
}

abstract class _UserAuthData implements UserAuthData {
  const factory _UserAuthData({final String? role, final String? userId}) =
      _$UserAuthDataImpl;

  factory _UserAuthData.fromJson(Map<String, dynamic> json) =
      _$UserAuthDataImpl.fromJson;

  @override
  String? get role;
  @override
  String? get userId;

  /// Create a copy of UserAuthData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAuthDataImplCopyWith<_$UserAuthDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
