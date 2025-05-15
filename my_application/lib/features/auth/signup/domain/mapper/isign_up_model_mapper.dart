import 'package:my_application/features/auth/signup/data/dto/response/sign_up_response.dart';
import 'package:my_application/features/auth/signup/domain/model/sign_up_model.dart';

abstract interface class ISignUpModelMapper {
  SignUpModel mapToSignUpModel(SignUpResponse data);
}
