import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/property/application/property_service.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';
import 'package:my_application/features/property/presentation/state/property_state.dart';
import 'package:my_application/features/property/application/iproperty_service.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';

final propertyControllerProvider =
    StateNotifierProvider<PropertyController, PropertyState>((ref) {
      final propertyService = ref.watch(propertyServiceProvider);
      return PropertyController(propertyService);
    });

class PropertyController extends StateNotifier<PropertyState> {
  final IpropertyService _propertyService;

  PropertyController(this._propertyService)
    : super(const PropertyState.initial());

  Future<void> createProperty(PropertyRequest request) async {
    state = const PropertyState.loading();
    try {
      final property = await _propertyService.createProperty(request);
      state = PropertyState.created(property);
    } catch (e) {
      state = PropertyState.error(e.toString());
    }
  }

  Future<void> getPropertyById(int id) async {
    state = const PropertyState.loading();
    try {
      final property = await _propertyService.getPropertyById(id);
      state = PropertyState.loaded(property);
    } catch (e) {
      state = PropertyState.error(e.toString());
    }
  }

  Future<void> getAllProperties() async {
    state = const PropertyState.loading();
    try {
      final properties = await _propertyService.getAllProperty();
      state = PropertyState.allLoaded(properties);
    } catch (e) {
      state = PropertyState.error(e.toString());
    }
  }

  Future<void> editProperty(int id, PropertyRequest request) async {
    state = const PropertyState.loading();
    try {
      final edited = await _propertyService.editProperty(request, id);
      state = PropertyState.updated(edited);
    } catch (e) {
      state = PropertyState.error(e.toString());
    }
  }

  /// Delete a property
  Future<void> deleteProperty(int id) async {
    state = const PropertyState.loading();
    try {
      final deleted = await _propertyService.deleteProperty(id);
      state = PropertyState.deleted(deleted);
    } catch (e) {
      state = PropertyState.error(e.toString());
    }
  }
}

final propertyFormProvider =
    StateNotifierProvider.autoDispose<PropertyFormController, PropertyRequest>(
      (ref) => PropertyFormController(),
    );

class PropertyFormController extends StateNotifier<PropertyRequest> {
  PropertyFormController()
    : super(
        const PropertyRequest(
          title: '',
          description: '',
          price: null,
          location: '',
          beds: null,
          baths: null,
          area: null,
        ),
      );

  void setFromModel(PropertyModel model) {
    state = PropertyRequest(
      title: model.title ?? '',
      description: model.description ?? '',
      price: model.price,
      location: model.location,
      beds: model.beds,
      baths: model.baths,
      area: model.area,
    );
  }

  void updateTitle(String value) => state = state.copyWith(title: value);
  void updateDescription(String value) =>
      state = state.copyWith(description: value);
  void updatePrice(String value) =>
      state = state.copyWith(price: int.tryParse(value) ?? 0);
  void updateLocation(String value) => state = state.copyWith(location: value);
  void updateBeds(String value) =>
      state = state.copyWith(beds: int.tryParse(value) ?? 0);
  void updateBaths(String value) =>
      state = state.copyWith(baths: int.tryParse(value) ?? 0);
  void updateArea(String value) =>
      state = state.copyWith(area: int.tryParse(value) ?? 0);
}
