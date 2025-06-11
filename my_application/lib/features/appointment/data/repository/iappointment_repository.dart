import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/data/dto/response/appointment_response.dart';
import 'package:my_application/features/appointment/data/dto/response/message_response/appointment_response_with_message.dart';

abstract interface class IAppointmentRepository {
  Future<AppointmentWithMessageResponse> createAppointment(
    AppointmentRequest data,
  );
  Future<List<AppointmentResponse>> getUserAppointments();
  Future<AppointmentResponse> getAppointmentById(int id);
  Future<AppointmentWithMessageResponse> editAppointment(
    AppointmentRequest data,
    int id,
  );
  Future<AppointmentWithMessageResponse> updateAppointmentStatus(
    AppointmentRequest data,
    int id,
  );
  Future<AppointmentWithMessageResponse> deleteAppointment(int id);
}
