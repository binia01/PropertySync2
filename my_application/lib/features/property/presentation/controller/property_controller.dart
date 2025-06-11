
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/providers/user.role.provider.dart';
import 'package:my_application/core/providers/user_auth_data.dart';
import 'package:my_application/features/property/application/property_service.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';
import 'package:my_application/features/property/presentation/state/property_state.dart';
import 'package:my_application/features/property/application/iproperty_service.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/user/presentation/controller/user_controller.dart';

import '../../data/dto/response/property_response.dart';

final propertyControllerProvider =
StateNotifierProvider<PropertyController, PropertyState>((ref) {
  final propertyService = ref.watch(propertyServiceProvider);
  return PropertyController(propertyService, ref);
});

class PropertyController extends StateNotifier<PropertyState> {
  final IpropertyService _propertyService;
  final Ref _ref;

  PropertyController(this._propertyService, this._ref)
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
    debugPrint("PropertyController: getAllProperties called."); // Debug 1
    state = const PropertyState.loading();
    try {
      debugPrint("PropertyController: Calling _propertyService.getAllProperty()."); // Debug 2
      final properties = await _propertyService.getAllProperty();
      debugPrint("PropertyController: Received ${properties.length} properties from service."); // Debug 3

      final userRoleState = _ref.read(userRoleProvider);
      final currentUserState = _ref.read(userControllerProvider);
      final AsyncValue<UserAuthData?> asyncUserAuthData = _ref.read(userRoleProvider); // <--- Read UserAuthData


      String? currentUserId;
      bool isSeller = false;

      asyncUserAuthData.whenOrNull(
        data: (authData) {
          isSeller = authData?.role?.toUpperCase() == 'SELLER';
          // Now, currentUserId can come from UserAuthData directly IF it's loaded and present
          currentUserId = authData?.userId;
          debugPrint("PropertyController: From UserAuthData: isSeller=$isSeller, currentUserId=$currentUserId");
        },
        loading: () => debugPrint("PropertyController: User auth data (UserAuthData) is loading."),
        error: (e, st) => debugPrint("PropertyController: Error in userAuthData: $e"),
      );

      currentUserState.whenOrNull(
        loaded: (userModel) {
          currentUserId = userModel.id?.toString();
          debugPrint("PropertyController: Current user ID: $currentUserId (from user model ID: ${userModel.id})"); // Debug 7
        },
        loading: () => debugPrint("PropertyController: Current user state is loading."), // Debug 8
        initial: () => debugPrint("PropertyController: Current user state is initial (not yet loaded)."), // Debug 10
        loggedOut: () => debugPrint("PropertyController: Current user state is logged out."), // Debug 11
        deleted: () => debugPrint("PropertyController: Current user state is deleted."), // Debug 12
      );

      List<PropertyModel> filteredProperties = [];

      debugPrint("PropertyController: Filtering conditions: isSeller=$isSeller, currentUserId=$currentUserId");
      if (isSeller && currentUserId != null) {
        debugPrint("PropertyController: User is a SELLER with ID $currentUserId. Applying filter.");
        filteredProperties = properties.where((property) {
          final String? propertySellerId = property.sellerId?.toString();
          final bool matches = propertySellerId == currentUserId;
          debugPrint("PropertyController: Checking property ID ${property.id} (sellerId: $propertySellerId) against currentUserId ($currentUserId). Match: $matches");
          return matches;
        }).toList();
        debugPrint("PropertyController: Filtered list for seller has ${filteredProperties.length} properties.");
      } else {
        debugPrint("PropertyController: User is NOT a seller OR currentUserId is null. Displaying ALL properties.");
        filteredProperties = properties;
      }
      state = PropertyState.allLoaded(filteredProperties);
      debugPrint("PropertyController: State updated to allLoaded with ${filteredProperties.length} properties.");
    } catch (e) {
      debugPrint("PropertyController: ERROR in getAllProperties: $e");
      state = PropertyState.error(e.toString());
    }
  }
  //
  // Future<void> getAllProperties() async {
  //   state = const PropertyState.loading();
  //   try {
  //     final properties = await _propertyService.getAllProperty();
  //     final userRoleState = _ref.read(userRoleProvider);
  //     final currentUserState = _ref.read(userControllerProvider);
  //
  //     String? currentUserId;
  //     bool isSeller = false;
  //
  //     userRoleState.whenOrNull(
  //             data: (role) {
  //               isSeller = role?.toUpperCase() == 'SELLER';
  //               debugPrint("PropertyController: User role detected as Seller: $isSeller");
  //             },
  //           );
  //
  //     currentUserState.whenOrNull(
  //             loaded: (userModel) {
  //               currentUserId = userModel.id?.toString();
  //               debugPrint("PropertyController: Current user ID: $currentUserId");
  //             },
  //           );
  //     List<PropertyModel> filteredProperties = [];
  //
  //     if (isSeller && currentUserId != null) {
  //             filteredProperties = properties.where((property) {
  //               final bool matches = property.sellerId?.toString() == currentUserId;
  //               return matches;
  //             }).toList();
  //           } else {
  //             filteredProperties = properties;
  //           }
  //     state = PropertyState.allLoaded(filteredProperties);
  //   } catch (e) {
  //     state = PropertyState.error(e.toString());
  //   }
  // }


  Future<void> editProperty(int id, PropertyRequest request) async {
    state = const PropertyState.loading();
    try {
      await _propertyService.editProperty(request, id);
      final properties = await getAllProperties();
      // state = PropertyState.allLoaded(properties);
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
      await getAllProperties();
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

