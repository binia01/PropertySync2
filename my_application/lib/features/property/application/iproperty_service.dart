import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

abstract interface class IpropertyService {
  Future<PropertyModel> createProperty(PropertyRequest data);
  Future<List<PropertyModel>> getAllProperty();
  Future<PropertyModel> getPropertyById(int id);
  Future<PropertyModel> editProperty(PropertyRequest data, int id);
  Future<PropertyModel> deleteProperty(int id);
}
