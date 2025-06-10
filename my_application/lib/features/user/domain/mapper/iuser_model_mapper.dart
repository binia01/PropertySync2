import 'package:my_application/features/user/data/dto/response/user_response.dart';
import 'package:my_application/features/user/domain/model/user_model.dart';

abstract interface class IuserModelMapper {
  UserModel mapToUserModel(UserResponse data);
}
