import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';

abstract interface class IloginRepository {
  Future<LoginResponse> login(LoginRequest data);
}
