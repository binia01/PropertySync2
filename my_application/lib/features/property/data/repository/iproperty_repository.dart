import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/data/dto/response/message_response/property_response_with_message.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';

abstract interface class IpropertyRepository {
  Future<PropertyWithMessageResponse> createProperty(PropertyRequest data);
  Future<List<PropertyResponse>> getAllProperty();
  Future<PropertyResponse> getPropertyById(int id);
  Future<PropertyWithMessageResponse> editProperty(
    PropertyRequest data,
    int id,
  );
  Future<PropertyWithMessageResponse> deleteProperty(int id);
}
