// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_request.freezed.dart';
part 'appointment_request.g.dart';

@freezed
class AppointmentRequest with _$AppointmentRequest {
  const factory AppointmentRequest({
    @JsonKey(name: "propertyId") int? propertyId,
    @JsonKey(name: "Date") DateTime? date,
    @JsonKey(name: "startTime") DateTime? startTime,
  }) = _AppointmentRequest;

  factory AppointmentRequest.fromJson(Map<String, dynamic> json) =>
      _$AppointmentRequestFromJson(json);
}
