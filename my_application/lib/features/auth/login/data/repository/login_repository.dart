import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';
import 'package:my_application/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:my_application/features/auth/login/data/source/remote/login_api.dart';

final loginRepositoryProvider = Provider<IloginRepository>((ref) {
  final loginApi = ref.watch(loginApiProvider);
  return LoginRepository(loginApi);
});

final class LoginRepository implements IloginRepository {
  final LoginApi _loginApi;

  LoginRepository(this._loginApi);

  @override
  Future<LoginResponse> login(LoginRequest data) async {
    try {
      final response = await _loginApi.login(data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
