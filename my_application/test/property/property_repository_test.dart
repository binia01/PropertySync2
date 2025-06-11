import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_application/features/property/data/repository/property_repository.dart';
import 'package:my_application/features/property/data/source/remote/property_api.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';
import 'package:my_application/features/property/data/dto/response/message_response/property_response_with_message.dart';
import 'package:dio/dio.dart';

// Mock the PropertyApi
class MockPropertyApi extends Mock implements PropertyApi {}

void main() {
  late PropertyRepository propertyRepository;
  late MockPropertyApi mockPropertyApi;

  // Set up mocks before each test
  setUp(() {
    mockPropertyApi = MockPropertyApi();
    propertyRepository = PropertyRepository(mockPropertyApi);
  });

  group('PropertyRepository', () {
    // Define a sample PropertyResponse for consistent testing
    final testPropertyResponse = PropertyResponse(
      id: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      title: 'Test Property Title',
      description: 'This is a test property description.',
      price: 150000,
      location: '123 Test St, Test City',
      beds: 3,
      baths: 2,
      area: 1200,
      status: 'AVAILABLE',
      sellerId: 101,
    );

    // Define a sample PropertyRequest for consistent testing
    final testPropertyRequest = PropertyRequest(
      title: 'New Property',
      description: 'A newly added property.',
      price: 200000,
      location: '456 New Ave, New Town',
      beds: 4,
      baths: 3,
      area: 1800,
    );

    // Define a sample PropertyWithMessageResponse for consistent testing
    final testPropertyWithMessageResponse = PropertyWithMessageResponse(
      property: testPropertyResponse,
      message: 'Success',
    );

    // Test case for createProperty
    test(
      'createProperty should return PropertyWithMessageResponse on success',
      () async {
        // Arrange: When the API's createProperty is called, return a success response
        when(
          () => mockPropertyApi.createProperty(testPropertyRequest),
        ).thenAnswer((_) async => testPropertyWithMessageResponse);

        // Act: Call the repository method
        final result = await propertyRepository.createProperty(
          testPropertyRequest,
        );

        // Assert: Verify the result and mock interactions
        expect(result, isA<PropertyWithMessageResponse>());
        expect(result.property?.id, testPropertyResponse.id);
        expect(result.message, 'Success');
        // Verify that the API method was called exactly once with the correct arguments
        verify(
          () => mockPropertyApi.createProperty(testPropertyRequest),
        ).called(1);
      },
    );

    // Test case for createProperty with DioException
    test('createProperty should rethrow DioException on failure', () async {
      // Arrange: When the API's createProperty is called, throw a DioException
      when(() => mockPropertyApi.createProperty(testPropertyRequest)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(
        () => propertyRepository.createProperty(testPropertyRequest),
        throwsA(isA<DioException>()),
      );
      // Verify that the API method was called exactly once
      verify(
        () => mockPropertyApi.createProperty(testPropertyRequest),
      ).called(1);
    });

    // Test case for getAllProperty
    test(
      'getAllProperty should return a list of PropertyResponses on success',
      () async {
        // Arrange: When the API's getAllProperty is called, return a list of responses
        when(
          () => mockPropertyApi.getAllProperty(),
        ).thenAnswer((_) async => [testPropertyResponse, testPropertyResponse]);

        // Act: Call the repository method
        final result = await propertyRepository.getAllProperty();

        // Assert: Verify the result and mock interactions
        expect(result, isA<List<PropertyResponse>>());
        expect(result.length, 2);
        expect(result.first.id, testPropertyResponse.id);
        // Verify that the API method was called exactly once
        verify(() => mockPropertyApi.getAllProperty()).called(1);
      },
    );

    // Test case for getAllProperty with DioException
    test('getAllProperty should rethrow DioException on failure', () async {
      // Arrange: When the API's getAllProperty is called, throw a DioException
      when(() => mockPropertyApi.getAllProperty()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(
        () => propertyRepository.getAllProperty(),
        throwsA(isA<DioException>()),
      );
      // Verify that the API method was called exactly once
      verify(() => mockPropertyApi.getAllProperty()).called(1);
    });

    // Test case for getPropertyById
    test('getPropertyById should return PropertyResponse on success', () async {
      // Arrange: When the API's getPropertyById is called, return a response
      when(
        () => mockPropertyApi.getPropertyById(1),
      ).thenAnswer((_) async => testPropertyResponse);

      // Act: Call the repository method
      final result = await propertyRepository.getPropertyById(1);

      // Assert: Verify the result and mock interactions
      expect(result, isA<PropertyResponse>());
      expect(result.id, testPropertyResponse.id);
      // Verify that the API method was called exactly once with the correct ID
      verify(() => mockPropertyApi.getPropertyById(1)).called(1);
    });

    // Test case for getPropertyById with DioException
    test('getPropertyById should rethrow DioException on failure', () async {
      // Arrange: When the API's getPropertyById is called, throw a DioException
      when(() => mockPropertyApi.getPropertyById(1)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property/1')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(
        () => propertyRepository.getPropertyById(1),
        throwsA(isA<DioException>()),
      );
      // Verify that the API method was called exactly once
      verify(() => mockPropertyApi.getPropertyById(1)).called(1);
    });

    // Test case for editProperty
    test(
      'editProperty should return PropertyWithMessageResponse on success',
      () async {
        // Arrange: When the API's editProperty is called, return a success response
        when(
          () => mockPropertyApi.editProperty(testPropertyRequest, 1),
        ).thenAnswer((_) async => testPropertyWithMessageResponse);

        // Act: Call the repository method
        final result = await propertyRepository.editProperty(
          testPropertyRequest,
          1,
        );

        // Assert: Verify the result and mock interactions
        expect(result, isA<PropertyWithMessageResponse>());
        expect(result.property?.id, testPropertyResponse.id);
        expect(result.message, 'Success');
        // Verify that the API method was called exactly once with correct arguments
        verify(
          () => mockPropertyApi.editProperty(testPropertyRequest, 1),
        ).called(1);
      },
    );

    // Test case for editProperty with DioException
    test('editProperty should rethrow DioException on failure', () async {
      // Arrange: When the API's editProperty is called, throw a DioException
      when(
        () => mockPropertyApi.editProperty(testPropertyRequest, 1),
      ).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property/1')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(
        () => propertyRepository.editProperty(testPropertyRequest, 1),
        throwsA(isA<DioException>()),
      );
      // Verify that the API method was called exactly once
      verify(
        () => mockPropertyApi.editProperty(testPropertyRequest, 1),
      ).called(1);
    });

    // Test case for deleteProperty
    test(
      'deleteProperty should return PropertyWithMessageResponse on success',
      () async {
        // Arrange: When the API's deleteProperty is called, return a success response
        when(
          () => mockPropertyApi.deleteProperty(1),
        ).thenAnswer((_) async => testPropertyWithMessageResponse);

        // Act: Call the repository method
        final result = await propertyRepository.deleteProperty(1);

        // Assert: Verify the result and mock interactions
        expect(result, isA<PropertyWithMessageResponse>());
        expect(result.property?.id, testPropertyResponse.id);
        expect(result.message, 'Success');
        // Verify that the API method was called exactly once with the correct ID
        verify(() => mockPropertyApi.deleteProperty(1)).called(1);
      },
    );

    // Test case for deleteProperty with DioException
    test('deleteProperty should rethrow DioException on failure', () async {
      // Arrange: When the API's deleteProperty is called, throw a DioException
      when(() => mockPropertyApi.deleteProperty(1)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property/1')),
      );

      // Act & Assert: Expect the repository method to rethrow the DioException
      expect(
        () => propertyRepository.deleteProperty(1),
        throwsA(isA<DioException>()),
      );
      // Verify that the API method was called exactly once
      verify(() => mockPropertyApi.deleteProperty(1)).called(1);
    });
  });
}
