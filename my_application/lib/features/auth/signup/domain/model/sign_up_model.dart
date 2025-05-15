import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_model.freezed.dart';

@freezed
class SignUpModel with _$SignUpModel {
  factory SignUpModel({
    required String accessToken,
    required bool isSignUpSuccess,
  }) = _SignUpModel;
}
