// test/features/appointment/application/appointment_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_application/features/appointment/application/appointment_service.dart';
import 'package:my_application/features/appointment/data/dto/request/appointment_request.dart';
import 'package:my_application/features/appointment/data/dto/response/appointment_response.dart';
import 'package:my_application/features/appointment/data/dto/response/message_response/appointment_response_with_message.dart';
import 'package:my_application/features/appointment/data/repository/iappointment_repository.dart';

class MockAppointmentRepository extends Mock
    implements IAppointmentRepository {}

void main() {
  late AppointmentService appointmentService;
  late MockAppointmentRepository mockRepository;

  setUp(() {
    mockRepository = MockAppointmentRepository();
    appointmentService = AppointmentService(mockRepository);
  });

  group('AppointmentService', () {
    final testAppointmentResponse = AppointmentResponse(
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

    test('createAppointment should return mapped AppointmentModel', () async {
      // Arrange
      when(() => mockRepository.createAppointment(testRequest)).thenAnswer(
        (_) async => AppointmentWithMessageResponse(
          appointment: testAppointmentResponse,
          message: 'Created',
        ),
      );

      // Act
      final result = await appointmentService.createAppointment(testRequest);

      // Assert
      expect(result.id, testAppointmentResponse.id);
      expect(result.propertyId, testAppointmentResponse.propertyId);
      verify(() => mockRepository.createAppointment(testRequest)).called(1);
    });

    test(
      'getUserAppointments should return list of AppointmentModel',
      () async {
        // Arrange
        when(
          () => mockRepository.getUserAppointments(),
        ).thenAnswer((_) async => [testAppointmentResponse]);

        // Act
        final result = await appointmentService.getUserAppointments();

        // Assert
        expect(result.length, 1);
        expect(result.first.id, testAppointmentResponse.id);
        verify(() => mockRepository.getUserAppointments()).called(1);
      },
    );

    test('editAppointment should return updated AppointmentModel', () async {
      // Arrange
      when(() => mockRepository.editAppointment(testRequest, 1)).thenAnswer(
        (_) async => AppointmentWithMessageResponse(
          appointment: testAppointmentResponse,
          message: 'Updated',
        ),
      );

      // Act
      final result = await appointmentService.editAppointment(testRequest, 1);

      // Assert
      expect(result.id, testAppointmentResponse.id);
      verify(() => mockRepository.editAppointment(testRequest, 1)).called(1);
    });

    test('should handle errors from repository', () async {
      // Arrange
      when(
        () => mockRepository.getUserAppointments(),
      ).thenThrow(Exception('Failed to fetch'));

      // Act & Assert
      expect(
        () => appointmentService.getUserAppointments(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
