import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/data/dto/response/sign_up_response.dart';
import 'package:my_application/features/auth/signup/data/repository/isign_up_repository.dart';
import 'package:my_application/features/auth/signup/data/source/remote/signup_api.dart';

final signUpRepositoryProvider = Provider<IsignUpRepository>((ref) {
  final signUpApi = ref.watch(signUpApiProvider);
  final tokenService = ref.watch(
    tokenServiceProvider(ref.watch(networkServiceProvider)),
  );
  return SignUpRepository(signUpApi, tokenService);
});

final class SignUpRepository implements IsignUpRepository {
  final SignUpApi _signUpApi;
  final ITokenService _tokenService;

  SignUpRepository(this._signUpApi, this._tokenService);
  @override
  Future<SignUpResponse> signUp(SignUpRequest data) async {
    try {
      final response = await _signUpApi.signUp(data);
      await _tokenService.saveToken(response.accessToken);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
