import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/domain/model/login_model.dart';

abstract interface class IloginService {
  Future<LoginModel> login(LoginRequest data);
}
