// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SignUpModel {
  String get accessToken => throw _privateConstructorUsedError;
  bool get isSignUpSuccess => throw _privateConstructorUsedError;

  /// Create a copy of SignUpModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpModelCopyWith<SignUpModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpModelCopyWith<$Res> {
  factory $SignUpModelCopyWith(
    SignUpModel value,
    $Res Function(SignUpModel) then,
  ) = _$SignUpModelCopyWithImpl<$Res, SignUpModel>;
  @useResult
  $Res call({String accessToken, bool isSignUpSuccess});
}

/// @nodoc
class _$SignUpModelCopyWithImpl<$Res, $Val extends SignUpModel>
    implements $SignUpModelCopyWith<$Res> {
  _$SignUpModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = null, Object? isSignUpSuccess = null}) {
    return _then(
      _value.copyWith(
            accessToken:
                null == accessToken
                    ? _value.accessToken
                    : accessToken // ignore: cast_nullable_to_non_nullable
                        as String,
            isSignUpSuccess:
                null == isSignUpSuccess
                    ? _value.isSignUpSuccess
                    : isSignUpSuccess // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignUpModelImplCopyWith<$Res>
    implements $SignUpModelCopyWith<$Res> {
  factory _$$SignUpModelImplCopyWith(
    _$SignUpModelImpl value,
    $Res Function(_$SignUpModelImpl) then,
  ) = __$$SignUpModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, bool isSignUpSuccess});
}

/// @nodoc
class __$$SignUpModelImplCopyWithImpl<$Res>
    extends _$SignUpModelCopyWithImpl<$Res, _$SignUpModelImpl>
    implements _$$SignUpModelImplCopyWith<$Res> {
  __$$SignUpModelImplCopyWithImpl(
    _$SignUpModelImpl _value,
    $Res Function(_$SignUpModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignUpModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = null, Object? isSignUpSuccess = null}) {
    return _then(
      _$SignUpModelImpl(
        accessToken:
            null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                    as String,
        isSignUpSuccess:
            null == isSignUpSuccess
                ? _value.isSignUpSuccess
                : isSignUpSuccess // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$SignUpModelImpl implements _SignUpModel {
  _$SignUpModelImpl({required this.accessToken, required this.isSignUpSuccess});

  @override
  final String accessToken;
  @override
  final bool isSignUpSuccess;

  @override
  String toString() {
    return 'SignUpModel(accessToken: $accessToken, isSignUpSuccess: $isSignUpSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.isSignUpSuccess, isSignUpSuccess) ||
                other.isSignUpSuccess == isSignUpSuccess));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken, isSignUpSuccess);

  /// Create a copy of SignUpModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpModelImplCopyWith<_$SignUpModelImpl> get copyWith =>
      __$$SignUpModelImplCopyWithImpl<_$SignUpModelImpl>(this, _$identity);
}

abstract class _SignUpModel implements SignUpModel {
  factory _SignUpModel({
    required final String accessToken,
    required final bool isSignUpSuccess,
  }) = _$SignUpModelImpl;

  @override
  String get accessToken;
  @override
  bool get isSignUpSuccess;

  /// Create a copy of SignUpModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpModelImplCopyWith<_$SignUpModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
