import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/property/application/iproperty_service.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';
import 'package:my_application/features/property/data/repository/iproperty_repository.dart';
import 'package:my_application/features/property/data/repository/property_repository.dart';
import 'package:my_application/features/property/domain/mapper/iproperty_model_mapper.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

final propertyServiceProvider = Provider<IpropertyService>((ref) {
  final propertyRepository = ref.watch(propertyRepositoryProvider);
  return PropertyService(propertyRepository);
});

final class PropertyService implements IpropertyService, IpropertyModelMapper {
  final IpropertyRepository _propertyRepository;

  PropertyService(this._propertyRepository);

  @override
  Future<PropertyModel> createProperty(PropertyRequest data) async {
    try {
      final response = await _propertyRepository.createProperty(data);
      final model = mapToPropertyModel(response.property!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PropertyModel>> getAllProperty() async {
    try {
      final response = await _propertyRepository.getAllProperty();
      final model = response.map(mapToPropertyModel).toList();
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<PropertyModel> getPropertyById(int id) async {
    try {
      final response = await _propertyRepository.getPropertyById(id);
      final model = mapToPropertyModel(response);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<PropertyModel> editProperty(PropertyRequest data, int id) async {
    try {
      final response = await _propertyRepository.editProperty(data, id);
      final model = mapToPropertyModel(response.property!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  Future<PropertyModel> deleteProperty(int id) async {
    try {
      final response = await _propertyRepository.deleteProperty(id);
      final model = mapToPropertyModel(response.property!);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  @override
  PropertyModel mapToPropertyModel(PropertyResponse response) {
    return PropertyModel(
      id: response.id ?? 0,
      createdAt: response.createdAt,
      updatedAt: response.updatedAt,
      title: response.title ?? '',
      description: response.description ?? '',
      price: response.price ?? 0,
      location: response.location ?? '',
      beds: response.beds ?? 0,
      baths: response.baths ?? 0,
      area: response.area ?? 0,
      status: response.status ?? '',
      sellerId: response.sellerId ?? 0,
    );
  }
}
