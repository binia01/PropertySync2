import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';
import 'package:my_application/features/auth/login/domain/model/login_model.dart';

abstract interface class IloginModelMapper {
  LoginModel mapToLoginModel(LoginResponse data);
}
