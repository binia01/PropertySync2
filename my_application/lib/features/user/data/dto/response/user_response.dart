// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response.freezed.dart';
part 'user_response.g.dart';

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "role") String? role,
    @JsonKey(name: "bookedAppointments") List<dynamic>? bookedAppointments,
    @JsonKey(name: "sellingAppointments") List<dynamic>? sellingAppointments,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
