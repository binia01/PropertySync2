import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/features/auth/signup/data/dto/request/sign_up_request.dart';
import 'package:my_application/features/auth/signup/data/dto/response/sign_up_response.dart';

final signUpApiProvider = Provider<SignUpApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return SignUpApi(dio);
});

class SignUpApi {
  final Dio _dio;

  SignUpApi(this._dio);

  Future<SignUpResponse> signUp(SignUpRequest data) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/signup',
        data: data.toJson(),
      );

      return SignUpResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception('Failed to sign up: ${e.response?.data ?? e.message}');
    }
  }
}
