// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_response.freezed.dart';
part 'appointment_response.g.dart';

@freezed
class AppointmentResponse with _$AppointmentResponse {
  const factory AppointmentResponse({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "createdAt") DateTime? createdAt,
    @JsonKey(name: "updatedAt") DateTime? updatedAt,
    @JsonKey(name: "startTime") DateTime? startTime,
    @JsonKey(name: "Date") DateTime? date,
    @JsonKey(name: "propertyId") int? propertyId,
    @JsonKey(name: "buyerId") int? buyerId,
    @JsonKey(name: "sellerId") int? sellerId,
    @JsonKey(name: "status") String? status,
  }) = _AppointmentResponse;

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentResponseFromJson(json);
}
