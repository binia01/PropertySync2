import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/data/dto/response/appointment_response.dart';
import 'package:my_application/features/appointment/data/dto/response/message_response/appointment_response_with_message.dart';
import 'package:my_application/features/appointment/data/repository/iappointment_repository.dart';
import 'package:my_application/features/appointment/data/source/remote/appointment_api.dart';

final appointmentRepositoryProvider = Provider<IAppointmentRepository>((ref) {
  final appointmentApi = ref.watch(appointmentApiProvider);
  return AppointmentRepository(appointmentApi);
});

final class AppointmentRepository implements IAppointmentRepository {
  final AppointmentApi _appointmentApi;
  AppointmentRepository(this._appointmentApi);

  @override
  Future<AppointmentWithMessageResponse> createAppointment(
    AppointmentRequest data,
  ) async {
    try {
      final response = await _appointmentApi.createAppointment(data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentResponse>> getUserAppointments() async {
    try {
      final response = await _appointmentApi.getUserAppointments();
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentResponse> getAppointmentById(int id) async {
    try {
      final response = await _appointmentApi.getAppointmentById(id);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentWithMessageResponse> editAppointment(
    AppointmentRequest data,
    int id,
  ) async {
    try {
      final response = await _appointmentApi.editAppointment(data, id);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentWithMessageResponse> updateAppointmentStatus(
    AppointmentRequest data,
    int id,
  ) async {
    try {
      final response = await _appointmentApi.updateAppointmentStatus(data, id);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentWithMessageResponse> deleteAppointment(int id) async {
    try {
      final response = await _appointmentApi.deleteAppointment(id);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
