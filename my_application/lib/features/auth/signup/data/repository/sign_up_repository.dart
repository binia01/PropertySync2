import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/data/dto/response/sign_up_response.dart';
import 'package:my_application/features/auth/signup/data/repository/isign_up_repository.dart';
import 'package:my_application/features/auth/signup/data/source/remote/signup_api.dart';

final signUpRepositoryProvider = Provider<IsignUpRepository>((ref) {
  final signUpApi = ref.watch(signUpApiProvider);
  return SignUpRepository(signUpApi);
});

final class SignUpRepository implements IsignUpRepository {
  final SignUpApi _signUpApi;

  SignUpRepository(this._signUpApi);
  @override
  Future<SignUpResponse> signUp(SignUpRequest data) async {
    try {
      final response = await _signUpApi.signUp(data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
