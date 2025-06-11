import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';
import 'package:my_application/features/property/data/dto/response/message_response/property_response_with_message.dart';
import 'package:my_application/features/property/data/source/remote/property_api.dart';

// Mock the Dio client
class MockDio extends Mock implements Dio {}

// Mock the ITokenService
class MockTokenService extends Mock implements ITokenService {}

void main() {
  late PropertyApi propertyApi;
  late MockDio mockDio;
  late MockTokenService mockTokenService;

  setUp(() {
    mockDio = MockDio();
    mockTokenService = MockTokenService();
    propertyApi = PropertyApi(mockDio, mockTokenService);

    // Register fallback values for Dio's various methods if not explicitly stubbed.
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Options());
    registerFallbackValue(const PropertyRequest());
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(<dynamic>[]);

    // Common setup for token service
    when(
      () => mockTokenService.getAccessToken(),
    ).thenAnswer((_) async => 'mock_access_token');
  });

  group('PropertyApi', () {
    final testPropertyRequest = PropertyRequest(
      title: 'New Listing',
      description: 'A beautiful house',
      price: 300000,
      location: 'City Center',
      beds: 3,
      baths: 2,
      area: 1500,
    );

    final testPropertyResponse = PropertyResponse(
      id: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: 'New Listing',
      description: 'A beautiful house',
      price: 300000,
      location: 'City Center',
      beds: 3,
      baths: 2,
      area: 1500,
      status: 'AVAILABLE',
      sellerId: 1,
    );

    // Explicitly create the JSON representation for PropertyWithMessageResponse
    // to ensure the 'property' field is a Map<String, dynamic>
    final Map<String, dynamic> testPropertyWithMessageResponseJson = {
      'message': 'Property created successfully',
      'property':
          testPropertyResponse
              .toJson(), // Ensure nested PropertyResponse is also toJson()
    };

    // Test for createProperty
    test(
      'createProperty should return PropertyWithMessageResponse on success',
      () async {
        // Arrange
        final responseBody =
            testPropertyWithMessageResponseJson; // Use the explicitly defined JSON map
        when(
          () => mockDio.post<Map<String, dynamic>>(
            '/property',
            data: testPropertyRequest.toJson(),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/property'),
            data: responseBody,
            statusCode: 201,
          ),
        );

        // Act
        final result = await propertyApi.createProperty(testPropertyRequest);

        // Assert
        expect(result, isA<PropertyWithMessageResponse>());
        expect(result.property?.id, testPropertyResponse.id);
        expect(result.message, 'Property created successfully');
        verify(() => mockTokenService.getAccessToken()).called(1);
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            '/property',
            data: testPropertyRequest.toJson(),
            options: any(named: 'options'),
          ),
        ).called(1);
      },
    );

    // Test for createProperty error handling
    test('createProperty should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.post<Map<String, dynamic>>(
          '/property',
          data: testPropertyRequest.toJson(),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/property'),
          response: Response(
            requestOptions: RequestOptions(path: '/property'),
            statusCode: 400,
            data: {'message': 'Bad Request'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => propertyApi.createProperty(testPropertyRequest),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to Create property: {message: Bad Request}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });

    // Test for getAllProperty
    test(
      'getAllProperty should return List<PropertyResponse> on success',
      () async {
        // Arrange
        final responseBody = [
          testPropertyResponse.toJson(),
          testPropertyResponse.toJson(),
        ];
        when(
          () => mockDio.get<List<dynamic>>(
            '/property',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/property'),
            data: responseBody,
            statusCode: 200,
          ),
        );

        // Act
        final result = await propertyApi.getAllProperty();

        // Assert
        expect(result, isA<List<PropertyResponse>>());
        expect(result.length, 2);
        expect(result.first.id, testPropertyResponse.id);
        verify(() => mockTokenService.getAccessToken()).called(1);
        verify(
          () => mockDio.get<List<dynamic>>(
            '/property',
            options: any(named: 'options'),
          ),
        ).called(1);
      },
    );

    // Test for getAllProperty error handling
    test('getAllProperty should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.get<List<dynamic>>(
          '/property',
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/property'),
          response: Response(
            requestOptions: RequestOptions(path: '/property'),
            statusCode: 500,
            data: {'message': 'Server Error'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => propertyApi.getAllProperty(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to get property: {message: Server Error}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });

    // Test for getPropertyById
    test('getPropertyById should return PropertyResponse on success', () async {
      // Arrange
      final responseBody = testPropertyResponse.toJson();
      when(
        () => mockDio.get<Map<String, dynamic>>(
          '/property/1',
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/property/1'),
          data: responseBody,
          statusCode: 200,
        ),
      );

      // Act
      final result = await propertyApi.getPropertyById(1);

      // Assert
      expect(result, isA<PropertyResponse>());
      expect(result.id, testPropertyResponse.id);
      verify(() => mockTokenService.getAccessToken()).called(1);
      verify(
        () => mockDio.get<Map<String, dynamic>>(
          '/property/1',
          options: any(named: 'options'),
        ),
      ).called(1);
    });

    // Test for getPropertyById error handling
    test('getPropertyById should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.get<Map<String, dynamic>>(
          '/property/1',
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/property/1'),
          response: Response(
            requestOptions: RequestOptions(path: '/property/1'),
            statusCode: 404,
            data: {'message': 'Not Found'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => propertyApi.getPropertyById(1),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to get property: {message: Not Found}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });

    // Test for editProperty
    test(
      'editProperty should return PropertyWithMessageResponse on success',
      () async {
        // Arrange
        final responseBody =
            testPropertyWithMessageResponseJson; // Use the explicitly defined JSON map
        when(
          () => mockDio.patch<Map<String, dynamic>>(
            '/property/1',
            data: testPropertyRequest.toJson(),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/property/1'),
            data: responseBody,
            statusCode: 200,
          ),
        );

        // Act
        final result = await propertyApi.editProperty(testPropertyRequest, 1);

        // Assert
        expect(result, isA<PropertyWithMessageResponse>());
        expect(result.property?.id, testPropertyResponse.id);
        expect(
          result.message,
          'Property created successfully',
        ); // Message from the test response
        verify(() => mockTokenService.getAccessToken()).called(1);
        verify(
          () => mockDio.patch<Map<String, dynamic>>(
            '/property/1',
            data: testPropertyRequest.toJson(),
            options: any(named: 'options'),
          ),
        ).called(1);
      },
    );

    // Test for editProperty error handling
    test('editProperty should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.patch<Map<String, dynamic>>(
          '/property/1',
          data: testPropertyRequest.toJson(),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/property/1'),
          response: Response(
            requestOptions: RequestOptions(path: '/property/1'),
            statusCode: 403,
            data: {'message': 'Forbidden'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => propertyApi.editProperty(testPropertyRequest, 1),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to edit property: {message: Forbidden}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });

    // Test for deleteProperty
    test(
      'deleteProperty should return PropertyWithMessageResponse on success',
      () async {
        // Arrange
        final responseBody =
            testPropertyWithMessageResponseJson; // Use the explicitly defined JSON map
        when(
          () => mockDio.delete<Map<String, dynamic>>(
            '/property/1',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/property/1'),
            data: responseBody,
            statusCode: 200,
          ),
        );

        // Act
        final result = await propertyApi.deleteProperty(1);

        // Assert
        expect(result, isA<PropertyWithMessageResponse>());
        expect(result.property?.id, testPropertyResponse.id);
        expect(
          result.message,
          'Property created successfully',
        ); // Message from test response
        verify(() => mockTokenService.getAccessToken()).called(1);
        verify(
          () => mockDio.delete<Map<String, dynamic>>(
            '/property/1',
            options: any(named: 'options'),
          ),
        ).called(1);
      },
    );

    // Test for deleteProperty error handling
    test('deleteProperty should throw Exception on DioError', () async {
      // Arrange
      when(
        () => mockDio.delete<Map<String, dynamic>>(
          '/property/1',
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/property/1'),
          response: Response(
            requestOptions: RequestOptions(path: '/property/1'),
            statusCode: 401,
            data: {'message': 'Unauthorized'},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      // Act & Assert
      await expectLater(
        () => propertyApi.deleteProperty(1),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to delete property: {message: Unauthorized}'),
          ),
        ),
      );
      verify(() => mockTokenService.getAccessToken()).called(1);
    });
  });
}
