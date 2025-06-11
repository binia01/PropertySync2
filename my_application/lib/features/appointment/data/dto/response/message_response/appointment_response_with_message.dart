import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/appointment/data/dto/response/appointment_response.dart';

part 'appointment_response_with_message.freezed.dart';
part 'appointment_response_with_message.g.dart';

@freezed
class AppointmentWithMessageResponse with _$AppointmentWithMessageResponse {
  const factory AppointmentWithMessageResponse({
    String? message,
    AppointmentResponse? appointment,
  }) = _AppointmentWithMessageResponse;

  factory AppointmentWithMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentWithMessageResponseFromJson(json);
}
