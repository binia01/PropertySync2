import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';

part 'user_response_with_message.freezed.dart';
part 'user_response_with_message.g.dart';

@freezed
class UserWithMessageResponse with _$UserWithMessageResponse {
  const factory UserWithMessageResponse({String? message, UserResponse? user}) =
      _UserWithMessageResponse;

  factory UserWithMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$UserWithMessageResponseFromJson(json);
}
