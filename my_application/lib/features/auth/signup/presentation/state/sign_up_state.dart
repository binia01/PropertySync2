import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/auth/signup/domain/model/sign_up_model.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  factory SignUpState({
    SignUpModel? signUpModel,
    @Default(false) bool isLoading,
    bool? isSignUpSuccess,
    String? errorMessage,
    @Default({}) Map<String, dynamic> signUpform,
  }) = _SignUpState;
}
