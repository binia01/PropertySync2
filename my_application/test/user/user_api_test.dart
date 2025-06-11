import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/features/user/data/dto/request/user_request.dart';
import 'package:my_application/features/user/data/dto/response/user_response.dart';
import 'package:my_application/features/user/data/dto/response/message_response/user_response_with_message.dart';
import 'package:my_application/features/user/data/source/remote/user_api.dart';

// Mock the Dio client
class MockDio extends Mock implements Dio {}

// Mock the ITokenService
class MockTokenService extends Mock implements ITokenService {}

void main() {
  late UserApi userApi;
  late MockDio mockDio;
  late MockTokenService mockTokenService;

  setUp(() {
    mockDio = MockDio();
    mockTokenService = MockTokenService();
    userApi = UserApi(mockDio, mockTokenService);

    // Register fallback values for Dio's various methods and custom types
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Options());
    registerFallbackValue(const UserRequest());
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(<dynamic>[]);

    // Common setup for token service
    when(
      () => mockTokenService.getAccessToken(),
    ).thenAnswer((_) async => 'mock_access_token');
  });

  group('UserApi', () {
    final testUserRequest = UserRequest(
      firstname: 'John',
      lastname: 'Doe',
      email: 'john.doe@example.com',
    );

    final testUserResponse = UserResponse(
      id: 1,
      email: 'john.doe@example.com',
      name: 'John Doe',
      role: 'BUYER',
      properties: [],
      bookedAppointments: [],
      sellingAppointments: [],
    );

    final Map<String, dynamic> testUserWithMessageResponseJson = {
      'message': 'Operation successful',
      'user': testUserResponse.toJson(),
    };

    // Test for getUser
    test('getUser should return UserResponse on success', () async {
      // Arrange
      final responseBody = testUserResponse.toJson();
      when(
        () => mockDio.get<Map<String, dynamic>>(
          '/users/profile',
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/users/profile'),
          data: responseBody,
          statusCode: 200,
        ),
      );

      // Act
      final result = await userApi.getUser();

      // Assert
      expect(result, isA<UserResponse>());
      expect(result.id, testUserResponse.id);
      expect(result.email, testUserResponse.email);
      verify(() => mockTokenService.getAccessToken()).called(1);
      verify(
        () => mockDio.get<Map<String, dynamic>>(
          '/users/profile',
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    // Test for getUser error handling
    test('getUser should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.get<Map<String, dynamic>>(
          '/users/profile',
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users/profile'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/profile'),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => userApi.getUser(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to Get user: {message: Unauthorized}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });

    // Test for editUser
    test('editUser should return UserWithMessageResponse on success', () async {
      // Arrange
      when(
        () => mockDio.patch<Map<String, dynamic>>(
          '/users/profile',
          data: testUserRequest.toJson(),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/users/profile'),
          data: testUserWithMessageResponseJson,
          statusCode: 200,
        ),
      );

      // Act
      final result = await userApi.editUser(testUserRequest);

      // Assert
      expect(result, isA<UserWithMessageResponse>());
      expect(result.user?.id, testUserResponse.id);
      expect(result.message, 'Operation successful');
      verify(() => mockTokenService.getAccessToken()).called(1);
      verify(
        () => mockDio.patch<Map<String, dynamic>>(
          '/users/profile',
          data: testUserRequest.toJson(),
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    // Test for editUser error handling
    test('editUser should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.patch<Map<String, dynamic>>(
          '/users/profile',
          data: testUserRequest.toJson(),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users/profile'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/profile'),
            statusCode: 400,
            data: {'message': 'Invalid data'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => userApi.editUser(testUserRequest),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to Edit user: {message: Invalid data}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });

    // Test for deleteUser
    test(
      'deleteUser should return UserWithMessageResponse on success',
      () async {
        // Arrange
        when(
          () => mockDio.delete<Map<String, dynamic>>(
            '/users/profile',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/users/profile'),
            data: testUserWithMessageResponseJson,
            statusCode: 200,
          ),
        );

        // Act
        final result = await userApi.deleteUser();

        // Assert
        expect(result, isA<UserWithMessageResponse>());
        expect(result.user?.id, testUserResponse.id);
        expect(result.message, 'Operation successful');
        verify(() => mockTokenService.getAccessToken()).called(1);
        verify(
          () => mockDio.delete<Map<String, dynamic>>(
            '/users/profile',
            options: any(named: 'options'),
          ),
        ).called(1);
      },
    );

    // Test for deleteUser error handling
    test('deleteUser should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.delete<Map<String, dynamic>>(
          '/users/profile',
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users/profile'),
          response: Response(
            requestOptions: RequestOptions(path: '/users/profile'),
            statusCode: 500,
            data: {'message': 'Server error'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => userApi.deleteUser(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to Delete user: {message: Server error}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });
  });
}
