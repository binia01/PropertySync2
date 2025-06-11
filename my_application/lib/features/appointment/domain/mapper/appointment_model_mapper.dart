import 'package:my_application/features/appointment/data/dto/response/appointment_response.dart';
import 'package:my_application/features/appointment/domain/model/appointment_model.dart';

abstract interface class IAppointmentModelMapper {
  AppointmentModel mapToAppointmentModel(AppointmentResponse data);
}
