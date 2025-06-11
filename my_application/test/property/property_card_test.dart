// test/features/property/presentation/ui/widgets/property_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/property/application/iproperty_service.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';
import 'package:my_application/features/property/presentation/controller/property_controller.dart';
// import 'package:my_application/features/property/presentation/state/property_state.dart';
import 'package:my_application/features/property/presentation/ui/widget/property_card.dart';
import 'package:my_application/features/property/presentation/ui/edit_property.dart';
import 'package:my_application/features/property/presentation/ui/property_detail_screen.dart';
// import 'package:my_application/core/providers/user_auth_data.dart'; // Still needed for UserAuthData
import 'package:my_application/core/providers/user_role_provider.dart'; // Import userRoleProvider
import 'package:my_application/features/user/presentation/controller/user_controller.dart';
import 'package:my_application/features/user/domain/model/user_model.dart';
import 'package:my_application/features/user/application/iuser_service.dart';
import 'package:my_application/features/user/presentation/state/user_state.dart';
import 'package:my_application/features/property/application/property_service.dart';
import 'package:my_application/features/user/application/user_service.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:dio/dio.dart';
import 'dart:async';

// Mock classes for dependencies
class MockTokenService extends Mock implements ITokenService {}

class MockPropertyService extends Mock implements IpropertyService {}

class MockUserService extends Mock implements IuserService {}

// Custom Test AsyncNotifier which now implements UserRoleNotifier from your project
class TestUserRoleAsyncNotifier extends UserRoleNotifier {
  String? _testRole;

  @override
  Future<String?> build() async {
    // Return the initial state. This method is called by Riverpod once.
    // Simulating an async operation here.
    return Future.value(_testRole);
  }

  // Method to update the state from outside the notifier (e.g., from tests)
  void updateForTest(String? role) {
    _testRole = role;
    state = AsyncData(role);
  }
}

// A concrete implementation of StateNotifier to mock UserController for its provider
class MockUserController extends StateNotifier<UserState>
    implements UserController {
  MockUserController(super.state) : super();

  @override
  Future<void> getUser() async {
    state = UserState.loaded(
      UserModel(
        id: 101,
        name: 'Mock User',
        email: 'mock@example.com',
        role: 'SELLER',
      ),
    );
  }

  @override
  Future<void> deleteUser() async {}
  @override
  Future<void> editUser(request) async {}
  @override
  Future<void> logout() async {}
}

void main() {
  // These mocks can be declared here to be reset before each test
  // by initializing them in the test's `setUp` function.
  // This avoids conflicts with `late` keywords and global state.
  late MockTokenService mockTokenService;
  late MockPropertyService mockPropertyService;
  late MockUserService mockUserService;
  late TestUserRoleAsyncNotifier testUserRoleAsyncNotifier;

  // Sample PropertyModel for testing
  final testProperty = PropertyModel(
    id: 1,
    title: 'Cozy Family Home',
    description: 'A beautiful place to live.',
    price: 250000,
    location: 'Suburbia',
    beds: 3,
    baths: 2,
    area: 1500,
    status: 'AVAILABLE',
    sellerId: 101,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // Register fallback values for mocktail once globally
  setUpAll(() {
    registerFallbackValue(Dio());
    registerFallbackValue(const PropertyRequest());
    registerFallbackValue(const UserRequest());
  });

  group('PropertyCard Widget Tests', () {
    // Initialize mocks within each test or in setUp to ensure fresh state
    // `late` variables are re-initialized for each `testWidgets` run.

    // Test case: PropertyCard displays correctly for a BUYER
    testWidgets('PropertyCard displays correctly for BUYER role', (
      tester,
    ) async {
      mockTokenService = MockTokenService();
      mockPropertyService = MockPropertyService();
      mockUserService = MockUserService();
      testUserRoleAsyncNotifier = TestUserRoleAsyncNotifier();

      final container = ProviderContainer(
        overrides: [
          propertyServiceProvider.overrideWith((ref) => mockPropertyService),
          tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
          userServiceProvider.overrideWith((ref) => mockUserService),
          userControllerProvider.overrideWith(
            (ref) => MockUserController(const UserState.initial()),
          ),
          userRoleProvider.overrideWith(() => testUserRoleAsyncNotifier),
        ],
      );

      // Ensure `userRoleProvider`'s build method is called and completes.
      // Await its future to guarantee it's initialized before interacting.
      await container.read(userRoleProvider.future);
      final realPropertyController = container.read(
        propertyControllerProvider.notifier,
      );

      // Arrange: Mock the token service to return 'BUYER' role
      when(() => mockTokenService.getRole()).thenAnswer((_) async => 'BUYER');

      // Set the state of the userRoleProvider via our test notifier to reflect a buyer
      testUserRoleAsyncNotifier.updateForTest('BUYER');
      // Ensure the mock user service returns buyer data when requested by UserController
      when(() => mockUserService.getUser()).thenAnswer(
        (_) async => UserModel(
          id: 102,
          name: 'Buyer User',
          email: 'buyer@example.com',
          role: 'BUYER',
        ),
      );
      // Mock getAllProperty for the initial load of PropertyListScreen (when PropertyCard is rendered)
      when(
        () => mockPropertyService.getAllProperty(),
      ).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          overrides: [
            propertyControllerProvider.overrideWith(
              (ref) => realPropertyController,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(body: PropertyCard(property: testProperty)),
          ),
        ),
      );

      // Flush all initial async operations and frames after the widget tree is built.
      await tester.pumpAndSettle();

      // Assert: Verify expected text and widgets for a BUYER
      expect(find.text('Cozy Family Home'), findsOneWidget);
      expect(find.text('Suburbia'), findsOneWidget);
      expect(find.text('3 Beds'), findsOneWidget);
      expect(find.text('2 Baths'), findsOneWidget);
      expect(find.text('1500 sqft'), findsOneWidget);
      expect(find.text('${testProperty.price}'), findsOneWidget);

      // For a buyer, 'Edit' and 'Delete' buttons should NOT be present.
      expect(find.text('Edit'), findsNothing);
      expect(find.text('Delete'), findsNothing);

      // Verify that the card itself is an InkWell for navigation (only for buyers)
      expect(find.byType(InkWell), findsOneWidget);

      // Dispose container after each test to prevent pending timers/resources.
      // This is crucial for isolated tests.
      container.dispose();
    });

    // Test case: PropertyCard displays correctly for a SELLER
    testWidgets('PropertyCard displays correctly for SELLER role', (
      tester,
    ) async {
      mockTokenService = MockTokenService();
      mockPropertyService = MockPropertyService();
      mockUserService = MockUserService();
      testUserRoleAsyncNotifier = TestUserRoleAsyncNotifier();

      final container = ProviderContainer(
        overrides: [
          propertyServiceProvider.overrideWith((ref) => mockPropertyService),
          tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
          userServiceProvider.overrideWith((ref) => mockUserService),
          userControllerProvider.overrideWith(
            (ref) => MockUserController(const UserState.initial()),
          ),
          userRoleProvider.overrideWith(() => testUserRoleAsyncNotifier),
        ],
      );

      await container.read(userRoleProvider.future);
      final realPropertyController = container.read(
        propertyControllerProvider.notifier,
      );

      // Arrange: Mock the token service to return 'SELLER' role
      when(() => mockTokenService.getRole()).thenAnswer((_) async => 'SELLER');

      // Set the state of the userRoleProvider via our test notifier to reflect a seller
      testUserRoleAsyncNotifier.updateForTest('SELLER');
      // Ensure the mock user service returns seller data when requested by UserController
      when(() => mockUserService.getUser()).thenAnswer(
        (_) async => UserModel(
          id: 101,
          name: 'Seller User',
          email: 'seller@example.com',
          role: 'SELLER',
        ),
      );
      when(
        () => mockPropertyService.getAllProperty(),
      ).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          overrides: [
            propertyControllerProvider.overrideWith(
              (ref) => realPropertyController,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(body: PropertyCard(property: testProperty)),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert: Verify expected text and widgets for a SELLER
      expect(find.text('Cozy Family Home'), findsOneWidget);
      expect(find.text('Suburbia'), findsOneWidget);
      expect(find.text('3 Beds'), findsOneWidget);
      expect(find.text('2 Baths'), findsOneWidget);
      expect(find.text('1500 sqft'), findsOneWidget);
      expect(find.text('${testProperty.price}'), findsOneWidget);

      // For a seller, 'Edit' and 'Delete' buttons should be present.
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);

      container.dispose();
    });

    // // Test case: Tapping 'Edit' button navigates to EditPropertyPage (for SELLER)
    // testWidgets(
    //   'Tapping Edit button navigates to EditPropertyPage for SELLER',
    //   (tester) async {
    //     mockTokenService = MockTokenService();
    //     mockPropertyService = MockPropertyService();
    //     mockUserService = MockUserService();
    //     testUserRoleAsyncNotifier = TestUserRoleAsyncNotifier();

    //     final container = ProviderContainer(
    //       overrides: [
    //         propertyServiceProvider.overrideWith((ref) => mockPropertyService),
    //         tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
    //         userServiceProvider.overrideWith((ref) => mockUserService),
    //         userControllerProvider.overrideWith(
    //           (ref) => MockUserController(const UserState.initial()),
    //         ),
    //         userRoleProvider.overrideWith(() => testUserRoleAsyncNotifier),
    //       ],
    //     );

    //     await container.read(userRoleProvider.future);
    //     final realPropertyController = container.read(
    //       propertyControllerProvider.notifier,
    //     );

    //     // Arrange
    //     when(
    //       () => mockTokenService.getRole(),
    //     ).thenAnswer((_) async => 'SELLER');
    //     testUserRoleAsyncNotifier.updateForTest('SELLER');
    //     when(() => mockUserService.getUser()).thenAnswer(
    //       (_) async => UserModel(
    //         id: 101,
    //         name: 'Seller User',
    //         email: 'seller@example.com',
    //         role: 'SELLER',
    //       ),
    //     );
    //     when(
    //       () => mockPropertyService.getAllProperty(),
    //     ).thenAnswer((_) async => []);

    //     await tester.pumpWidget(
    //       ProviderScope(
    //         parent: container,
    //         overrides: [
    //           propertyControllerProvider.overrideWith(
    //             (ref) => realPropertyController,
    //           ),
    //         ],
    //         child: MaterialApp(
    //           home: Scaffold(body: PropertyCard(property: testProperty)),
    //         ),
    //       ),
    //     );
    //     await tester.pumpAndSettle();

    //     // Act: Tap the 'Edit' button
    //     await tester.tap(find.text('Edit'));
    //     await tester.pumpAndSettle();

    //     // Assert: Verify that EditPropertyPage is displayed
    //     expect(find.byType(EditPropertyPage), findsOneWidget);
    //     expect(find.text('Edit Property'), findsOneWidget);

    //     container.dispose();
    //   },
    // );

    // // Test case: Tapping 'Delete' button calls deleteProperty on controller (for SELLER)
    // testWidgets('Tapping Delete button calls deleteProperty on controller for SELLER', (
    //   tester,
    // ) async {
    //   mockTokenService = MockTokenService();
    //   mockPropertyService = MockPropertyService();
    //   mockUserService = MockUserService();
    //   testUserRoleAsyncNotifier = TestUserRoleAsyncNotifier();

    //   final container = ProviderContainer(
    //     overrides: [
    //       propertyServiceProvider.overrideWith((ref) => mockPropertyService),
    //       tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
    //       userServiceProvider.overrideWith((ref) => mockUserService),
    //       userControllerProvider.overrideWith(
    //         (ref) => MockUserController(const UserState.initial()),
    //       ),
    //       userRoleProvider.overrideWith(() => testUserRoleAsyncNotifier),
    //     ],
    //   );

    //   await container.read(userRoleProvider.future);
    //   final realPropertyController = container.read(
    //     propertyControllerProvider.notifier,
    //   );

    //   // Arrange
    //   when(() => mockTokenService.getRole()).thenAnswer((_) async => 'SELLER');
    //   testUserRoleAsyncNotifier.updateForTest('SELLER');
    //   when(() => mockUserService.getUser()).thenAnswer(
    //     (_) async => UserModel(
    //       id: 101,
    //       name: 'Seller User',
    //       email: 'seller@example.com',
    //       role: 'SELLER',
    //     ),
    //   );

    //   // Mock the underlying service method.
    //   when(
    //     () => mockPropertyService.deleteProperty(testProperty.id!),
    //   ).thenAnswer(
    //     (_) async => PropertyModel(
    //       id: testProperty.id,
    //       status: 'DELETED',
    //       title: testProperty.title,
    //     ),
    //   );
    //   // Mock getAllProperties for the controller's post-delete refresh AND initial load
    //   // The initial load in PropertyListScreen will cause a call to getAllProperties,
    //   // and the deleteProperty method itself calls getAllProperties again.
    //   when(
    //     () => mockPropertyService.getAllProperty(),
    //   ).thenAnswer((_) async => []);

    //   await tester.pumpWidget(
    //     ProviderScope(
    //       parent: container,
    //       overrides: [
    //         propertyControllerProvider.overrideWith(
    //           (ref) => realPropertyController,
    //         ),
    //       ],
    //       child: MaterialApp(
    //         home: Scaffold(body: PropertyCard(property: testProperty)),
    //       ),
    //     ),
    //   );
    //   await tester.pumpAndSettle();

    //   // Act: Tap the 'Delete' button
    //   await tester.tap(find.text('Delete'));
    //   await tester.pumpAndSettle();

    //   // Assert: Verify that deleteProperty was called on the mock service
    //   verify(
    //     () => mockPropertyService.deleteProperty(testProperty.id!),
    //   ).called(1);
    //   // Verify that getAllProperties was called twice (initial load + post-delete refresh)
    //   // This count needs to be carefully determined based on actual calls within the widget/controller.
    //   // If PropertyListScreen's initState calls it once, and PropertyController.deleteProperty calls it once, then it's twice.
    //   verify(() => mockPropertyService.getAllProperty()).called(2);

    //   container.dispose();
    // });

    // Test case: Tapping on the card (as BUYER) navigates to PropertyDetailsScreen
    testWidgets(
      'Tapping on PropertyCard navigates to PropertyDetailsScreen for BUYER',
      (tester) async {
        mockTokenService = MockTokenService();
        mockPropertyService = MockPropertyService();
        mockUserService = MockUserService();
        testUserRoleAsyncNotifier = TestUserRoleAsyncNotifier();

        final container = ProviderContainer(
          overrides: [
            propertyServiceProvider.overrideWith((ref) => mockPropertyService),
            tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
            userServiceProvider.overrideWith((ref) => mockUserService),
            userControllerProvider.overrideWith(
              (ref) => MockUserController(const UserState.initial()),
            ),
            userRoleProvider.overrideWith(() => testUserRoleAsyncNotifier),
          ],
        );

        await container.read(userRoleProvider.future);
        final realPropertyController = container.read(
          propertyControllerProvider.notifier,
        );

        // Arrange
        when(() => mockTokenService.getRole()).thenAnswer((_) async => 'BUYER');
        testUserRoleAsyncNotifier.updateForTest('BUYER');
        when(() => mockUserService.getUser()).thenAnswer(
          (_) async => UserModel(
            id: 102,
            name: 'Buyer User',
            email: 'buyer@example.com',
            role: 'BUYER',
          ),
        );
        when(
          () => mockPropertyService.getAllProperty(),
        ).thenAnswer((_) async => []);

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            overrides: [
              propertyControllerProvider.overrideWith(
                (ref) => realPropertyController,
              ),
            ],
            child: MaterialApp(
              home: Scaffold(body: PropertyCard(property: testProperty)),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Act: Tap on the card content (the InkWell)
        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();

        // Assert: Verify that PropertyDetailsScreen is displayed
        expect(find.byType(PropertyDetailsScreen), findsOneWidget);
        expect(find.text('Property Details'), findsOneWidget);

        container.dispose();
      },
    );
  });
}
