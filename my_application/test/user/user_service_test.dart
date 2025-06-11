import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_application/features/user/application/user_service.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';
import 'package:my_application/features/user/data/dto/response/message_response/user_response_with_message.dart';
import 'package:my_application/features/user/data/repository/iuser_repository.dart';
import 'package:my_application/features/user/domain/model/user_model.dart';
import 'package:dio/dio.dart';

// Mock the IUserRepository
class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late UserService userService;
  late MockUserRepository mockUserRepository;

  // Set up mocks before each test
  setUp(() {
    mockUserRepository = MockUserRepository();
    userService = UserService(mockUserRepository);

    // Register fallbacks for mocktail
    registerFallbackValue(UserRequest());
  });

  group('UserService', () {
    // Define a sample UserResponse for consistent testing
    final testUserResponse = UserResponse(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      role: 'BUYER',
      properties: [],
      bookedAppointments: [],
      sellingAppointments: [],
    );

    // Define a sample UserRequest for consistent testing
    final testUserRequest = UserRequest(
      firstname: 'Updated',
      lastname: 'User',
      email: 'updated@example.com',
    );

    // Test case for getUser
    test('getUser should return mapped UserModel on success', () async {
      // Arrange: When the repository's getUser is called, return a success response
      when(
        () => mockUserRepository.getUser(),
      ).thenAnswer((_) async => testUserResponse);

      // Act: Call the service method
      final result = await userService.getUser();

      // Assert: Verify the result and mock interactions
      expect(result, isA<UserModel>());
      expect(result.id, testUserResponse.id);
      expect(result.email, testUserResponse.email);
      expect(result.name, testUserResponse.name);
      expect(result.role, testUserResponse.role);
      // Verify that the repository method was called exactly once
      verify(() => mockUserRepository.getUser()).called(1);
    });

    // Test case for getUser with DioException
    test('getUser should rethrow DioException on failure', () async {
      // Arrange: When the repository's getUser is called, throw a DioException
      when(() => mockUserRepository.getUser()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/users/profile')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(() => userService.getUser(), throwsA(isA<DioException>()));
      // Verify that the repository method was called exactly once
      verify(() => mockUserRepository.getUser()).called(1);
    });

    // Test case for editUser
    test('editUser should return mapped UserModel on success', () async {
      // Arrange: When the repository's editUser is called, return a success response
      when(() => mockUserRepository.editUser(testUserRequest)).thenAnswer(
        (_) async => UserWithMessageResponse(
          user: testUserResponse.copyWith(
            name: 'Updated User',
            email: 'updated@example.com',
          ),
          message: 'User updated successfully',
        ),
      );

      // Act: Call the service method
      final result = await userService.editUser(testUserRequest);

      // Assert: Verify the result and mock interactions
      expect(result, isA<UserModel>());
      expect(result.name, 'Updated User');
      expect(result.email, 'updated@example.com');
      // Verify that the repository method was called exactly once
      verify(() => mockUserRepository.editUser(testUserRequest)).called(1);
    });

    // Test case for editUser with DioException
    test('editUser should rethrow DioException on failure', () async {
      // Arrange: When the repository's editUser is called, throw a DioException
      when(() => mockUserRepository.editUser(testUserRequest)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/users/profile')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(
        () => userService.editUser(testUserRequest),
        throwsA(isA<DioException>()),
      );
      // Verify that the repository method was called exactly once
      verify(() => mockUserRepository.editUser(testUserRequest)).called(1);
    });

    // Test case for editUser when user response is null
    test('editUser should throw exception if user response is null', () async {
      // Arrange
      when(() => mockUserRepository.editUser(testUserRequest)).thenAnswer(
        (_) async =>
            UserWithMessageResponse(user: null, message: 'No user data'),
      );

      // Act & Assert
      expect(
        () => userService.editUser(testUserRequest),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            'Exception: User response is null',
          ),
        ),
      );
    });

    // Test case for deleteUser
    test('deleteUser should return mapped UserModel on success', () async {
      // Arrange: When the repository's deleteUser is called, return a success response
      when(() => mockUserRepository.deleteUser()).thenAnswer(
        (_) async => UserWithMessageResponse(
          user: testUserResponse.copyWith(
            id: 0,
            email: '',
            name: '',
            role: 'DELETED',
          ), // Simulate deletion
          message: 'User deleted successfully',
        ),
      );

      // Act: Call the service method
      final result = await userService.deleteUser();

      // Assert: Verify the result and mock interactions
      expect(result, isA<UserModel>());
      expect(result.role, 'DELETED');
      // Verify that the repository method was called exactly once
      verify(() => mockUserRepository.deleteUser()).called(1);
    });

    // Test case for deleteUser with DioException
    test('deleteUser should rethrow DioException on failure', () async {
      // Arrange: When the repository's deleteUser is called, throw a DioException
      when(() => mockUserRepository.deleteUser()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/users/profile')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(() => userService.deleteUser(), throwsA(isA<DioException>()));
      // Verify that the repository method was called exactly once
      verify(() => mockUserRepository.deleteUser()).called(1);
    });

    // Test case for deleteUser when user response is null
    test(
      'deleteUser should throw exception if user response is null',
      () async {
        // Arrange
        when(() => mockUserRepository.deleteUser()).thenAnswer(
          (_) async =>
              UserWithMessageResponse(user: null, message: 'No user data'),
        );

        // Act & Assert
        expect(
          () => userService.deleteUser(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              'Exception: User response is null',
            ),
          ),
        );
      },
    );

    // Test case for mapToUserModel (mapper function)
    test('mapToUserModel should correctly map UserResponse to UserModel', () {
      // Act: Directly call the mapper method
      final model = userService.mapToUserModel(testUserResponse);

      // Assert: Verify the mapping
      expect(model, isA<UserModel>());
      expect(model.id, testUserResponse.id);
      expect(model.email, testUserResponse.email);
      expect(model.name, testUserResponse.name);
      expect(model.role, testUserResponse.role);
      expect(model.properties, testUserResponse.properties);
      expect(model.bookedAppointments, testUserResponse.bookedAppointments);
      expect(model.sellingAppointments, testUserResponse.sellingAppointments);
    });

    // Test case for mapToUserModel with null values in response
    test('mapToUserModel should handle null values gracefully', () {
      final nullUserResponse = UserResponse(
        id: null,
        email: null,
        name: null,
        role: null,
        properties: null,
        bookedAppointments: null,
        sellingAppointments: null,
      );

      final model = userService.mapToUserModel(nullUserResponse);

      expect(model.id, 0); // Default value for int?
      expect(model.email, ''); // Default value for String?
      expect(model.name, '');
      expect(model.role, '');
      expect(model.properties, isEmpty); // Default empty list
      expect(model.bookedAppointments, isEmpty);
      expect(model.sellingAppointments, isEmpty);
    });
  });
}
