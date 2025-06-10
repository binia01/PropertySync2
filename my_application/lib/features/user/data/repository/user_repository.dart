import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/data/dto/response/message_response/user_response_with_message.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';
import 'package:my_application/features/user/data/repository/iuser_repository.dart';
import 'package:my_application/features/user/data/source/remote/user_api.dart';

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  final userApi = ref.watch(userApiProvider);
  return UserRepository(userApi);
});

final class UserRepository implements IUserRepository {
  final UserApi _userApi;

  UserRepository(this._userApi);
  @override
  Future<UserResponse> getUser() async {
    try {
      final response = await _userApi.getUser();
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserWithMessageResponse> editUser(UserRequest data) async {
    try {
      final response = await _userApi.editUser(data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserWithMessageResponse> deleteUser() async {
    try {
      final response = _userApi.deleteUser();
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
