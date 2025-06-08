import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/data/dto/response/message_response/property_response_with_message.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';

final propertyApiProvider = Provider<PropertyApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  final tokenService = ref.watch(
    tokenServiceProvider(ref.watch(networkServiceProvider)),
  );
  return PropertyApi(dio, tokenService);
});

class PropertyApi {
  final Dio _dio;
  final ITokenService _tokenService;

  PropertyApi(this._dio, this._tokenService);

  Future<PropertyWithMessageResponse> createProperty(
    PropertyRequest data,
  ) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.post<Map<String, dynamic>>(
        "/property",
        data: data.toJson(),
        options: Options(
            headers: {'Authorization': 'Bearer $token'}),
      );
      return PropertyWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to Create property: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<List<PropertyResponse>> getAllProperty() async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.get<List<dynamic>>(
        "/property",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data!
          .map(
            (json) => PropertyResponse.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Failed to get property: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<PropertyResponse> getPropertyById(int id) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.get<Map<String, dynamic>>(
        '/property/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return PropertyResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to get property: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<PropertyWithMessageResponse> editProperty(
    PropertyRequest data,
    int id,
  ) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.patch<Map<String, dynamic>>(
        "/property/$id",
        data: data.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return PropertyWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to edit property: ${e.response?.data ?? e.message}',
      );
    }
  }

  Future<PropertyWithMessageResponse> deleteProperty(int id) async {
    try {
      final token = await _tokenService.getAccessToken();
      final response = await _dio.delete<Map<String, dynamic>>(
        "/property/$id",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return PropertyWithMessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception(
        'Failed to delete property: ${e.response?.data ?? e.message}',
      );
    }
  }
}
