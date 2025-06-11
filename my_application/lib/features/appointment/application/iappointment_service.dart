import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/domain/model/appointment_model.dart';

abstract interface class IappointmentService {
  Future<AppointmentModel> createAppointment(AppointmentRequest data);
  Future<List<AppointmentModel>> getUserAppointments();
  Future<AppointmentModel> getAppointmentById(int id);
  Future<AppointmentModel> editAppointment(AppointmentRequest data, int id);
  Future<AppointmentModel> updateAppointmentStatus(
    AppointmentRequest data,
    int id,
  );
  Future<AppointmentModel> deleteAppointment(int id);
}
