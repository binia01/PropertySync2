import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';
import 'package:my_application/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:my_application/features/auth/login/data/source/remote/login_api.dart';

final loginRepositoryProvider = Provider<IloginRepository>((ref) {
  final loginApi = ref.watch(loginApiProvider);
  final tokenService = ref.watch(
    tokenServiceProvider(ref.watch(networkServiceProvider)),
  );
  return LoginRepository(loginApi, tokenService);
});

final class LoginRepository implements IloginRepository {
  final LoginApi _loginApi;
  final ITokenService _tokenService;

  LoginRepository(this._loginApi, this._tokenService);

  @override
  Future<LoginResponse> login(LoginRequest data) async {
    try {
      final response = await _loginApi.login(data);
      await _tokenService.saveToken(response.accessToken);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
