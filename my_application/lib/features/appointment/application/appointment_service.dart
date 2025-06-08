import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/appointment/application/iappointment_service.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/data/dto/response/appointment_response.dart';
import 'package:my_application/features/appointment/data/repository/appointment_repository.dart';
import 'package:my_application/features/appointment/data/repository/iappointment_repository.dart';
import 'package:my_application/features/appointment/domain/mapper/appointment_model_mapper.dart';
import 'package:my_application/features/appointment/domain/model/appointment_model.dart';

final appointmentServiceProvider = Provider<IappointmentService>((ref) {
  final appointmentRepository = ref.watch(appointmentRepositoryProvider);
  return AppointmentService(appointmentRepository);
});

final class AppointmentService
    implements IappointmentService, IAppointmentModelMapper {
  final IAppointmentRepository _appointmentRepository;

  AppointmentService(this._appointmentRepository);

  @override
  Future<AppointmentModel> createAppointment(AppointmentRequest data) async {
    try {
      final response = await _appointmentRepository.createAppointment(data);
      final model = mapToAppointmentModel(response.appointment!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<AppointmentModel>> getUserAppointments() async {
    try {
      final response = await _appointmentRepository.getUserAppointments();
      final model = response.map(mapToAppointmentModel).toList();
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentModel> getAppointmentById(int id) async {
    try {
      final response = await _appointmentRepository.getAppointmentById(id);
      final model = mapToAppointmentModel(response);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentModel> editAppointment(
    AppointmentRequest data,
    int id,
  ) async {
    try {
      final response = await _appointmentRepository.editAppointment(data, id);
      final model = mapToAppointmentModel(response.appointment!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentModel> updateAppointmentStatus(
    AppointmentRequest data,
    int id,
  ) async {
    try {
      final response = await _appointmentRepository.updateAppointmentStatus(
        data,
        id,
      );
      final model = mapToAppointmentModel(response.appointment!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<AppointmentModel> deleteAppointment(int id) async {
    try {
      final response = await _appointmentRepository.deleteAppointment(id);
      final model = mapToAppointmentModel(response.appointment!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  AppointmentModel mapToAppointmentModel(AppointmentResponse response) {
    return AppointmentModel(
      id: response.id,
      createdAt: response.createdAt,
      updatedAt: response.updatedAt,
      startTime: response.startTime,
      date: response.date,
      propertyId: response.propertyId,
      buyerId: response.buyerId,
      sellerId: response.sellerId,
      status: response.status ?? '',
    );
  }
}
