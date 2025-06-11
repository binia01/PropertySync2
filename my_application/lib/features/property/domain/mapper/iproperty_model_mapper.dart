import 'package:my_application/features/property/data/dto/response/property_response.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

abstract interface class IpropertyModelMapper {
  PropertyModel mapToPropertyModel(PropertyResponse data);
}
