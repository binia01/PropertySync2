import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';

@freezed
class LoginModel with _$LoginModel {
  factory LoginModel({
    required String accessToken,
    required bool isLoginSuccess,
  }) = _LoginModel;
}
