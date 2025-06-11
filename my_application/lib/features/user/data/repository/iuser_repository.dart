import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/data/dto/response/message_response/user_response_with_message.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';

abstract interface class IUserRepository {
  Future<UserResponse> getUser();
  Future<UserWithMessageResponse> editUser(UserRequest data);
  Future<UserWithMessageResponse> deleteUser();
}
