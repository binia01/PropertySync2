// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.freezed.dart';
part 'user_request.g.dart';

@freezed
class UserRequest with _$UserRequest {
  const factory UserRequest({
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "role") String? role,
    @JsonKey(name: "bookedAppointments") List<dynamic>? bookedAppointments,
    @JsonKey(name: "sellingAppointments") List<dynamic>? sellingAppointments,
  }) = _UserRequest;

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);
}
