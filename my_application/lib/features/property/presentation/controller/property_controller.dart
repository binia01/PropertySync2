import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/features/property/application/property_service.dart';
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
      final property = await _propertyService.editProperty(request, id);
      state = PropertyState.updated(property);
    } catch (e) {
      state = PropertyState.error(e.toString());
    }
  }

  /// Delete a property
  Future<void> deleteProperty(int id) async {
    state = const PropertyState.loading();
    try {
      final property = await _propertyService.deleteProperty(id);
      state = PropertyState.deleted(property);
    } catch (e) {
      state = PropertyState.error(e.toString());
    }
  }

  /// (Optional) Reset state back to initial
  void reset() {
    state = const PropertyState.initial();
  }
}
