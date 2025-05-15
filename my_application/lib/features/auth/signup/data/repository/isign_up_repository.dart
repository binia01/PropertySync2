import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/data/dto/response/sign_up_response.dart';

abstract interface class IsignUpRepository {
  Future<SignUpResponse> signUp(SignUpRequest data);
}
