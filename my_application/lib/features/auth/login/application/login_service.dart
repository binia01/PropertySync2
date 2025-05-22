import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/auth/login/application/ilogin_service.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';
import 'package:my_application/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:my_application/features/auth/login/data/repository/login_repository.dart';
import 'package:my_application/features/auth/login/domain/mapper/ilogin_model_mapper.dart';
import 'package:my_application/features/auth/login/domain/model/login_model.dart';

final loginServiceProvider = Provider<IloginService>((ref) {
  final loginRepository = ref.watch(loginRepositoryProvider);
  return LoginService(loginRepository);
});

final class LoginService implements IloginService, IloginModelMapper {
  final IloginRepository _loginRepository;

  LoginService(this._loginRepository);

  @override
  Future<LoginModel> login(LoginRequest data) async {
    try {
      final response = await _loginRepository.login(data);
      final model = mapToLoginModel(response);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  LoginModel mapToLoginModel(LoginResponse response) {
    return LoginModel(accessToken: response.accessToken, isLoginSuccess: true);
  }
}
