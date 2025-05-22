import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/auth/login/domain/model/login_model.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    LoginModel? loginModel,
    @Default(false) bool isLoading,
    bool? isLoginSuccess,
    String? errorMessage,
    @Default({}) Map<String, dynamic> loginform,
  }) = _LoginState;
}
