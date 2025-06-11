import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_application/features/appointment/domain/model/appointment_model.dart';

part 'appointment_state.freezed.dart';

@freezed
class AppointmentState with _$AppointmentState {
  const factory AppointmentState.initial() = _Initial;
  const factory AppointmentState.loading() = _Loading;
  const factory AppointmentState.created(AppointmentModel appointment) =
      _Created;
  const factory AppointmentState.loaded(AppointmentModel appointment) = _Loaded;
  const factory AppointmentState.allLoaded(
    List<AppointmentModel> appointments,
  ) = _AllLoaded;
  const factory AppointmentState.updated(AppointmentModel appointment) =
      _Updated;
  const factory AppointmentState.deleted(AppointmentModel appointment) =
      _Deleted;
  const factory AppointmentState.error(String message) = _Error;
}
