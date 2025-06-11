import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/appointment/application/appointment_service.dart';
import 'package:my_application/features/appointment/application/iappointment_service.dart';
import 'package:my_application/features/appointment/presentation/state/appointment_state.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';

final appointmentControllerProvider =
    StateNotifierProvider<AppointmentController, AppointmentState>((ref) {
      final service = ref.watch(appointmentServiceProvider);
      return AppointmentController(service);
    });

class AppointmentController extends StateNotifier<AppointmentState> {
  final IappointmentService _appointmentService;

  AppointmentController(this._appointmentService)
    : super(const AppointmentState.initial());

  Future<void> createAppointment(AppointmentRequest request) async {
    state = const AppointmentState.loading();
    try {
      final appointment = await _appointmentService.createAppointment(request);
      state = AppointmentState.created(appointment);
    } catch (e) {
      state = AppointmentState.error(e.toString());
    }
  }

  Future<void> getUserAppointments() async {
    state = const AppointmentState.loading();
    try {
      final appointments = await _appointmentService.getUserAppointments();
      state = AppointmentState.allLoaded(appointments);
    } catch (e) {
      state = AppointmentState.error(e.toString());
    }
  }

  Future<void> getAppointmentById(int id) async {
    state = const AppointmentState.loading();
    try {
      final appointment = await _appointmentService.getAppointmentById(id);
      state = AppointmentState.loaded(appointment);
    } catch (e) {
      state = AppointmentState.error(e.toString());
    }
  }

  Future<void> editAppointment(AppointmentRequest request, int id) async {
    state = const AppointmentState.loading();
    try {
      final updated = await _appointmentService.editAppointment(request, id);
      state = AppointmentState.updated(updated);
    } catch (e) {
      state = AppointmentState.error(e.toString());
    }
  }

  Future<void> updateAppointmentStatus(
    AppointmentRequest request,
    int id,
  ) async {
    state = const AppointmentState.loading();
    try {
      final updated = await _appointmentService.updateAppointmentStatus(
        request,
        id,
      );
      state = AppointmentState.updated(updated);
    } catch (e) {
      state = AppointmentState.error(e.toString());
    }
  }

  Future<void> deleteAppointment(int id) async {
    state = const AppointmentState.loading();
    try {
      final deleted = await _appointmentService.deleteAppointment(id);
      state = AppointmentState.deleted(deleted);
    } catch (e) {
      state = AppointmentState.error(e.toString());
    }
  }
}
