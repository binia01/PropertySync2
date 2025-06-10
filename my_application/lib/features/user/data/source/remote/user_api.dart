import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/data/dto/response/message_response/user_response_with_message.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';

final userApiProvider = Provider<UserApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  final tokenService = ref.watch(
    tokenServiceProvider(ref.watch(networkServiceProvider)),
  );
  return UserApi(dio, tokenService);
});

class UserApi {
  final Dio _dio;
  final ITokenService _tokenService;

  UserApi(this._dio, this._tokenService);

  Future<UserResponse> getUser() async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.get<Map<String, dynamic>>(
        '/users/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final user = UserResponse.fromJson(response.data!);
      await _tokenService.saveRole(user.role ?? '');
      return user;
    } on DioException catch (e) {
      throw Exception('Failed to Get user: ${e.response?.data ?? e.message}');
    }
  }

  Future<UserWithMessageResponse> editUser(UserRequest data) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.patch<Map<String, dynamic>>(
        'users/profile',
        data: data.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return UserWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception('Failed to Edit user: ${e.response?.data ?? e.message}');
    }
  }

  Future<UserWithMessageResponse> deleteUser() async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.delete<Map<String, dynamic>>(
        '/users/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return UserWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to Delete user: ${e.response?.data ?? e.message}',
      );
    }
  }
}
