import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_application/features/appointment/application/iappointment_service.dart';
import 'package:my_application/features/appointment/domain/model/appointment_model.dart';
import 'package:my_application/features/appointment/presentation/controller/appointment_controller.dart';
import 'package:my_application/features/appointment/presentation/state/appointment_state.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';

class MockAppointmentService extends Mock implements IappointmentService {}

void main() {
  late AppointmentController controller;
  late MockAppointmentService mockService;

  setUp(() {
    mockService = MockAppointmentService();
    controller = AppointmentController(mockService);
  });

  group('AppointmentController', () {
    final testAppointment = AppointmentModel(
      id: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      startTime: '2023-01-01T10:00:00Z',
      date: '2023-01-01',
      propertyId: 1,
      buyerId: 1,
      sellerId: 2,
      status: 'PENDING',
    );

    final testRequest = AppointmentRequest(
      propertyId: 1,
      date: '2023-01-01',
      startTime: '10:00',
      status: 'PENDING',
    );

    test('initial state is AppointmentState.initial', () {
      expect(controller.state, const AppointmentState.initial());
    });

    test('getUserAppointments should update state correctly', () async {
      // Arrange
      when(
        () => mockService.getUserAppointments(),
      ).thenAnswer((_) async => [testAppointment]);

      // Act
      await controller.getUserAppointments();

      // Assert
      expect(controller.state, isA<AppointmentState>());
      controller.state.when(
        initial: () => fail('Should not be initial'),
        loading: () => fail('Should not be loading'),
        created: (_) => fail('Should not be created'),
        loaded: (_) => fail('Should not be loaded'),
        allLoaded: (appointments) {
          expect(appointments.length, 1);
          expect(appointments.first.id, testAppointment.id);
        },
        updated: (_) => fail('Should not be updated'),
        deleted: (_) => fail('Should not be deleted'),
        error: (_) => fail('Should not be error'),
      );
    });

    // test('should handle error state', () async {
    //   // Arrange
    //   when(
    //     () => mockService.getUserAppointments(),
    //   ).thenThrow(Exception('Failed'));

    //   // Act
    //   await controller.getUserAppointments();

    //   // Assert
    //   expect(controller.state, isA<AppointmentState>());
    //   controller.state.when(
    //     initial: () => fail('Should not be initial'),
    //     loading: () => fail('Should not be loading'),
    //     created: (_) => fail('Should not be created'),
    //     loaded: (_) => fail('Should not be loaded'),
    //     allLoaded: (_) => fail('Should not be allLoaded'),
    //     updated: (_) => fail('Should not be updated'),
    //     deleted: (_) => fail('Should not be deleted'),
    //     error: (message) => expect(message, 'Failed'),
    //   );
    // });

    test('createAppointment should update state correctly', () async {
      // Arrange
      when(
        () => mockService.createAppointment(testRequest),
      ).thenAnswer((_) async => testAppointment);

      // Act
      await controller.createAppointment(testRequest);

      // Assert
      expect(controller.state, isA<AppointmentState>());
      controller.state.when(
        initial: () => fail('Should not be initial'),
        loading: () => fail('Should not be loading'),
        created: (appointment) {
          expect(appointment.id, testAppointment.id);
        },
        loaded: (_) => fail('Should not be loaded'),
        allLoaded: (_) => fail('Should not be allLoaded'),
        updated: (_) => fail('Should not be updated'),
        deleted: (_) => fail('Should not be deleted'),
        error: (_) => fail('Should not be error'),
      );
    });

    test('editAppointment should update state correctly', () async {
      // Arrange
      when(
        () => mockService.editAppointment(testRequest, 1),
      ).thenAnswer((_) async => testAppointment);

      // Act
      await controller.editAppointment(testRequest, 1);

      // Assert
      expect(controller.state, isA<AppointmentState>());
      controller.state.when(
        initial: () => fail('Should not be initial'),
        loading: () => fail('Should not be loading'),
        created: (_) => fail('Should not be created'),
        loaded: (_) => fail('Should not be loaded'),
        allLoaded: (_) => fail('Should not be allLoaded'),
        updated: (appointment) {
          expect(appointment.id, testAppointment.id);
        },
        deleted: (_) => fail('Should not be deleted'),
        error: (_) => fail('Should not be error'),
      );
    });
  });
}
