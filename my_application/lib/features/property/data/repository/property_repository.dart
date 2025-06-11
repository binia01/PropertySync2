import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/property/data/repository/iproperty_repository.dart';
import 'package:my_application/features/property/data/source/remote/property_api.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/data/dto/response/message_response/property_response_with_message.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';

final propertyRepositoryProvider = Provider<IpropertyRepository>((ref) {
  final propertyApi = ref.watch(propertyApiProvider);
  return PropertyRepository(propertyApi);
});

final class PropertyRepository implements IpropertyRepository {
  final PropertyApi _propertyApi;
  PropertyRepository(this._propertyApi);
  @override
  Future<PropertyWithMessageResponse> createProperty(
    PropertyRequest data,
  ) async {
    try {
      final response = await _propertyApi.createProperty(data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PropertyResponse>> getAllProperty() async {
    try {
      final response = await _propertyApi.getAllProperty();
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<PropertyResponse> getPropertyById(int id) async {
    try {
      final response = await _propertyApi.getPropertyById(id);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<PropertyWithMessageResponse> editProperty(
    PropertyRequest data,
    int id,
  ) async {
    try {
      final response = await _propertyApi.editProperty(data, id);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<PropertyWithMessageResponse> deleteProperty(int id) async {
    try {
      final response = await _propertyApi.deleteProperty(id);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
