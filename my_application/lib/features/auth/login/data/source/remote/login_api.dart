import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';

final loginApiProvider = Provider<LoginApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return LoginApi(dio);
});

class LoginApi {
  final Dio _dio;

  LoginApi(this._dio);

  Future<LoginResponse> login(LoginRequest data) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/signin',
        data: data.toJson(),
      );
      return LoginResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception('Failed to login: ${e.response?.data ?? e.message}');
    }
  }
}
