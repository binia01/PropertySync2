import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/user/application/iuser_service.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';
import 'package:my_application/features/user/data/repository/iuser_repository.dart';
import 'package:my_application/features/user/data/repository/user_repository.dart';
import 'package:my_application/features/user/domain/mapper/iuser_model_mapper.dart';
import 'package:my_application/features/user/domain/model/user_model.dart';

final userServiceProvider = Provider<IuserService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(userRepository);
});

final class UserService implements IuserService, IuserModelMapper {
  final IUserRepository _userRepository;

  UserService(this._userRepository);
  @override
  Future<UserModel> getUser() async {
    try {
      final response = await _userRepository.getUser();
      final model = mapToUserModel(response);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> editUser(UserRequest data) async {
    try {
      final response = await _userRepository.editUser(data);
      if (response.user == null) {
        throw Exception('User response is null');
      }
      final model = mapToUserModel(response.user!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<UserModel> deleteUser() async {
    try {
      final response = await _userRepository.deleteUser();
      if (response.user == null) {
        throw Exception('User response is null');
      }
      final model = mapToUserModel(response.user!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  UserModel mapToUserModel(UserResponse response) {
    return UserModel(
      id: response.id ?? 0,
      email: response.email ?? '',
      name: response.name ?? '',
      role: response.role ?? '',
      properties: response.properties ?? [],
      bookedAppointments: response.bookedAppointments ?? [],
      sellingAppointments: response.sellingAppointments ?? [],
    );
  }
}
