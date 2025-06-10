// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "role") String? role,
    @JsonKey(name: "bookedAppointments") List<dynamic>? bookedAppointments,
    @JsonKey(name: "sellingAppointments") List<dynamic>? sellingAppointments,
  }) = _UserModel;
}
