import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/domain/model/sign_up_model.dart';

abstract interface class IsignUpService {
  Future<SignUpModel> signUp(SignUpRequest data);
}
