import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/core/providers/user.role.provider.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';
import 'package:my_application/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:my_application/features/auth/login/data/source/remote/login_api.dart';
import 'package:my_application/features/user/data/repository/iuser_repository.dart';
import 'package:my_application/features/user/data/repository/user_repository.dart';

final loginRepositoryProvider = Provider<IloginRepository>((ref) {
  final loginApi = ref.watch(loginApiProvider);
  final tokenService = ref.watch(
    tokenServiceProvider(ref.watch(networkServiceProvider)),
  );
  final userRepository = ref.watch(userRepositoryProvider);
  return LoginRepository(loginApi, tokenService, userRepository, ref);
});

final class LoginRepository implements IloginRepository {
  final LoginApi _loginApi;
  final ITokenService _tokenService;
  final IUserRepository _userRepository;
  final Ref _ref;

  LoginRepository(this._loginApi, this._tokenService, this._userRepository, this._ref);

  @override
  Future<LoginResponse> login(LoginRequest data) async {
    try {
      final response = await _loginApi.login(data);
      await _tokenService.saveToken(response.accessToken);

      final userDetails = await _userRepository.getUser();

      final String? userRole = userDetails.role;
      final String? userId = userDetails.id?.toString();

      if (userRole != null && userRole.isNotEmpty) {
        await _ref.read(userRoleProvider.notifier).updateAuthData(role: userRole, userId: userDetails.id.toString());

      } else {
        await _ref.read(userRoleProvider.notifier).clearRole();
      }
      return response;
    } on DioException catch (e) {
      await _tokenService.clearToken();
      await _ref.read(userRoleProvider.notifier).clearRole();
      rethrow;
    } catch (e) {
      await _tokenService.clearToken();
      await _ref.read(userRoleProvider.notifier).clearRole();
      rethrow;
    }
  }
}