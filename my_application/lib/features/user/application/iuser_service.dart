import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/domain/model/user_model.dart';

abstract interface class IuserService {
  Future<UserModel> getUser();
  Future<UserModel> editUser(UserRequest data);
  Future<UserModel> deleteUser();
}
