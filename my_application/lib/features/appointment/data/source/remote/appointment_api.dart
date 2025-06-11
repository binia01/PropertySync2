import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/data/dto/response/appointment_response.dart';
import 'package:my_application/features/appointment/data/dto/response/message_response/appointment_response_with_message.dart';

final appointmentApiProvider = Provider<AppointmentApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  final tokenService = ref.watch(
    tokenServiceProvider(ref.watch(networkServiceProvider)),
  );
  return AppointmentApi(dio, tokenService);
});

class AppointmentApi {
  final Dio _dio;
  final ITokenService _tokenService;

  AppointmentApi(this._dio, this._tokenService);

  Future<AppointmentWithMessageResponse> createAppointment(
    AppointmentRequest data,
  ) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.post<Map<String, dynamic>>(
        "/appointment",
        data: data.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AppointmentWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to Create appointment: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<List<AppointmentResponse>> getUserAppointments() async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.get<List<dynamic>>(
        "/appointment",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data!
          .map(
            (json) =>
                AppointmentResponse.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Failed to get user appointment: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<AppointmentResponse> getAppointmentById(int id) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.get<Map<String, dynamic>>(
        '/appointment/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AppointmentResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to get appointment: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<AppointmentWithMessageResponse> editAppointment(
    AppointmentRequest data,
    int id,
  ) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.patch<Map<String, dynamic>>(
        "/appointment/$id",
        data: data.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AppointmentWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to edit appointment: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<AppointmentWithMessageResponse> updateAppointmentStatus(
    AppointmentRequest data,
    int id,
  ) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.patch<Map<String, dynamic>>(
        "/appointment/$id/status",
        data: data.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AppointmentWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to update appointment status: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<AppointmentWithMessageResponse> deleteAppointment(int id) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.delete<Map<String, dynamic>>(
        "/appointment/$id",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return AppointmentWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to delete appointment: ${e.response?.data ?? e.message}',
      );
    }
  }
}
