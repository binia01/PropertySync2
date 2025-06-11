// test/features/appointment/presentation/ui/widgets/appointment_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/domain/model/appointment_model.dart';
import 'package:my_application/features/appointment/presentation/controller/appointment_controller.dart';
import 'package:my_application/features/appointment/presentation/state/appointment_state.dart';
import 'package:my_application/features/appointment/presentation/ui/widgets/appointment_card.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';

class MockTokenService extends Mock implements ITokenService {}

class MockAppointmentController extends StateNotifier<AppointmentState>
    implements AppointmentController {
  MockAppointmentController() : super(const AppointmentState.initial());

  @override
  Future<void> editAppointment(AppointmentRequest request, int id) async {
    state = AppointmentState.updated(
      AppointmentModel(
        id: id,
        status: 'PENDING',
        propertyId: 1,
        date: request.date,
        startTime: request.startTime,
      ),
    );
  }

  @override
  Future<void> deleteAppointment(int id) async {
    state = AppointmentState.deleted(
      AppointmentModel(id: id, status: 'CANCELLED'),
    );
  }

  @override
  Future<void> createAppointment(AppointmentRequest request) async {
    // Mock implementation: just set state to updated with a dummy appointment
    state = AppointmentState.updated(
      AppointmentModel(
        id: 999,
        status: 'PENDING',
        propertyId: 1,
        date: request.date,
        startTime: request.startTime,
      ),
    );
  }

  @override
  Future<AppointmentModel?> getAppointmentById(int id) async {
    // Mock implementation: return a dummy appointment
    return AppointmentModel(
      id: id,
      status: 'PENDING',
      propertyId: 1,
      date: '2023-01-01T00:00:00Z',
      startTime: '2023-01-01T10:00:00Z',
    );
  }

  @override
  Future<List<AppointmentModel>> getUserAppointments() async {
    // Mock implementation: return a list with a dummy appointment
    return [
      AppointmentModel(
        id: 1,
        status: 'PENDING',
        propertyId: 1,
        date: '2023-01-01T00:00:00Z',
        startTime: '2023-01-01T10:00:00Z',
      ),
    ];
  }

  @override
  Future<void> updateAppointmentStatus(
    AppointmentRequest request,
    int id,
  ) async {
    // Mock implementation: update state with new status
    state = AppointmentState.updated(
      AppointmentModel(
        id: id,
        status: request.status ?? 'PENDING',
        propertyId: 1,
        date: request.date,
        startTime: request.startTime,
      ),
    );
  }
}

void main() {
  final mockTokenService = MockTokenService();
  final mockAppointmentController = MockAppointmentController();

  final testAppointment = AppointmentModel(
    id: 1,
    status: 'PENDING',
    propertyId: 1,
    date: '2023-01-01T00:00:00Z',
    startTime: '2023-01-01T10:00:00Z',
  );

  final testProperty = PropertyModel(
    id: 1,
    title: 'Test Property',
    location: 'Test Location',
  );

  setUpAll(() {
    // Setup network mock if needed
  });

  testWidgets('AppointmentCard displays correctly for buyer', (tester) async {
    // Arrange
    when(() => mockTokenService.getRole()).thenAnswer((_) async => 'BUYER');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
          appointmentControllerProvider.overrideWith(
            (ref) => mockAppointmentController,
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: AppointmentCard(
              appointment: testAppointment,
              property: testProperty,
            ),
          ),
        ),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.text('Test Property'), findsOneWidget);
    expect(find.text('PENDING'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  // testWidgets('AppointmentCard shows edit mode for buyer', (tester) async {
  //   // Arrange
  //   when(() => mockTokenService.getRole()).thenAnswer((_) async => 'BUYER');

  //   await tester.pumpWidget(
  //     ProviderScope(
  //       overrides: [
  //         tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
  //         appointmentControllerProvider.overrideWith(
  //           (ref) => mockAppointmentController,
  //         ),
  //       ],
  //       child: MaterialApp(
  //         home: Scaffold(
  //           body: AppointmentCard(
  //             appointment: testAppointment,
  //             property: testProperty,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

  //   // Act
  //   await tester.tap(find.text('Edit'));
  //   await tester.pump();

  //   // Assert
  //   expect(find.text('Save'), findsOneWidget);
  //   expect(find.text('Cancel'), findsOneWidget);
  // });

  testWidgets('AppointmentCard shows confirm/cancel for seller', (
    tester,
  ) async {
    // Arrange
    when(() => mockTokenService.getRole()).thenAnswer((_) async => 'SELLER');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenServiceProvider.overrideWith((ref, dio) => mockTokenService),
          appointmentControllerProvider.overrideWith(
            (ref) => mockAppointmentController,
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: AppointmentCard(
              appointment: testAppointment,
              property: testProperty,
            ),
          ),
        ),
      ),
    );

    // Act
    await tester.pump();

    // Assert
    expect(find.text('Confirm'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });
}
