import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_application/features/user/data/repository/user_repository.dart';
import 'package:my_application/features/user/data/source/remote/user_api.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';
import 'package:my_application/features/user/data/dto/response/message_response/user_response_with_message.dart';
import 'package:dio/dio.dart';

// Mock the UserApi
class MockUserApi extends Mock implements UserApi {}

void main() {
  late UserRepository userRepository;
  late MockUserApi mockUserApi;

  // Set up mocks before each test
  setUp(() {
    mockUserApi = MockUserApi();
    userRepository = UserRepository(mockUserApi);

    // Register fallback for UserRequest
    registerFallbackValue(UserRequest());
  });

  group('UserRepository', () {
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

    // Define a sample UserWithMessageResponse for consistent testing
    final testUserWithMessageResponse = UserWithMessageResponse(
      user: testUserResponse,
      message: 'Success',
    );

    // Test case for getUser
    test('getUser should return UserResponse on success', () async {
      // Arrange: When the API's getUser is called, return a success response
      when(
        () => mockUserApi.getUser(),
      ).thenAnswer((_) async => testUserResponse);

      // Act: Call the repository method
      final result = await userRepository.getUser();

      // Assert: Verify the result and mock interactions
      expect(result, isA<UserResponse>());
      expect(result.id, testUserResponse.id);
      expect(result.email, testUserResponse.email);
      // Verify that the API method was called exactly once
      verify(() => mockUserApi.getUser()).called(1);
    });

    // Test case for getUser with DioException
    test('getUser should rethrow DioException on failure', () async {
      // Arrange: When the API's getUser is called, throw a DioException
      when(() => mockUserApi.getUser()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/users/profile')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(() => userRepository.getUser(), throwsA(isA<DioException>()));
      // Verify that the API method was called exactly once
      verify(() => mockUserApi.getUser()).called(1);
    });

    // Test case for editUser
    test('editUser should return UserWithMessageResponse on success', () async {
      // Arrange: When the API's editUser is called, return a success response
      when(
        () => mockUserApi.editUser(testUserRequest),
      ).thenAnswer((_) async => testUserWithMessageResponse);

      // Act: Call the repository method
      final result = await userRepository.editUser(testUserRequest);

      // Assert: Verify the result and mock interactions
      expect(result, isA<UserWithMessageResponse>());
      expect(result.user?.id, testUserResponse.id);
      expect(result.message, 'Success');
      // Verify that the API method was called exactly once with correct arguments
      verify(() => mockUserApi.editUser(testUserRequest)).called(1);
    });

    // Test case for editUser with DioException
    test('editUser should rethrow DioException on failure', () async {
      // Arrange: When the API's editUser is called, throw a DioException
      when(() => mockUserApi.editUser(testUserRequest)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/users/profile')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(
        () => userRepository.editUser(testUserRequest),
        throwsA(isA<DioException>()),
      );
      // Verify that the API method was called exactly once
      verify(() => mockUserApi.editUser(testUserRequest)).called(1);
    });

    // Test case for deleteUser
    test('deleteUser should return UserWithMessageResponse on success', () async {
      // Arrange: When the API's deleteUser is called, return a success response
      when(
        () => mockUserApi.deleteUser(),
      ).thenAnswer((_) async => testUserWithMessageResponse);

      // Act: Call the repository method
      final result = await userRepository.deleteUser();

      // Assert: Verify the result and mock interactions
      expect(result, isA<UserWithMessageResponse>());
      expect(result.user?.id, testUserResponse.id);
      expect(result.message, 'Success');
      // Verify that the API method was called exactly once
      verify(() => mockUserApi.deleteUser()).called(1);
    });

    // Test case for deleteUser with DioException
    test('deleteUser should rethrow DioException on failure', () async {
      // Arrange: When the API's deleteUser is called, throw a DioException
      when(() => mockUserApi.deleteUser()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/users/profile')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(() => userRepository.deleteUser(), throwsA(isA<DioException>()));
      // Verify that the API method was called exactly once
      verify(() => mockUserApi.deleteUser()).called(1);
    });
  });
}
