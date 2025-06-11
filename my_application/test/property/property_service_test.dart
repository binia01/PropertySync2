import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_application/features/property/application/property_service.dart';
import 'package:my_application/features/property/data/dto/request/property_request.dart';
import 'package:my_application/features/property/data/dto/response/property_response.dart';
import 'package:my_application/features/property/data/dto/response/message_response/property_response_with_message.dart';
import 'package:my_application/features/property/data/repository/iproperty_repository.dart';
import 'package:my_application/features/property/domain/model/property_model.dart';
import 'package:dio/dio.dart'; // Import DioException for error handling

// Mock the IpropertyRepository
class MockPropertyRepository extends Mock implements IpropertyRepository {}

void main() {
  late PropertyService propertyService;
  late MockPropertyRepository mockPropertyRepository;

  // Set up mocks before each test
  setUp(() {
    mockPropertyRepository = MockPropertyRepository();
    propertyService = PropertyService(mockPropertyRepository);
  });

  group('PropertyService', () {
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

    // Test case for createProperty
    test('createProperty should return mapped PropertyModel on success', () async {
      // Arrange: When the repository's createProperty is called, return a success response
      when(
        () => mockPropertyRepository.createProperty(testPropertyRequest),
      ).thenAnswer(
        (_) async => PropertyWithMessageResponse(
          property: testPropertyResponse,
          message: 'Property created successfully!',
        ),
      );

      // Act: Call the service method
      final result = await propertyService.createProperty(testPropertyRequest);

      // Assert: Verify the result and mock interactions
      expect(result, isA<PropertyModel>());
      expect(result.id, testPropertyResponse.id);
      expect(result.title, testPropertyResponse.title);
      expect(result.description, testPropertyResponse.description);
      // Verify that the repository method was called exactly once with the correct arguments
      verify(
        () => mockPropertyRepository.createProperty(testPropertyRequest),
      ).called(1);
    });

    // Test case for createProperty with DioException
    test('createProperty should rethrow DioException on failure', () async {
      // Arrange: When the repository's createProperty is called, throw a DioException
      when(
        () => mockPropertyRepository.createProperty(testPropertyRequest),
      ).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(
        () => propertyService.createProperty(testPropertyRequest),
        throwsA(isA<DioException>()),
      );
      // Verify that the repository method was called exactly once
      verify(
        () => mockPropertyRepository.createProperty(testPropertyRequest),
      ).called(1);
    });

    // Test case for getAllProperty
    test(
      'getAllProperty should return a list of mapped PropertyModels on success',
      () async {
        // Arrange: When the repository's getAllProperty is called, return a list of responses
        when(
          () => mockPropertyRepository.getAllProperty(),
        ).thenAnswer((_) async => [testPropertyResponse, testPropertyResponse]);

        // Act: Call the service method
        final result = await propertyService.getAllProperty();

        // Assert: Verify the result and mock interactions
        expect(result, isA<List<PropertyModel>>());
        expect(result.length, 2);
        expect(result.first.id, testPropertyResponse.id);
        // Verify that the repository method was called exactly once
        verify(() => mockPropertyRepository.getAllProperty()).called(1);
      },
    );

    // Test case for getAllProperty with DioException
    test('getAllProperty should rethrow DioException on failure', () async {
      // Arrange: When the repository's getAllProperty is called, throw a DioException
      when(() => mockPropertyRepository.getAllProperty()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(
        () => propertyService.getAllProperty(),
        throwsA(isA<DioException>()),
      );
      // Verify that the repository method was called exactly once
      verify(() => mockPropertyRepository.getAllProperty()).called(1);
    });

    // Test case for getPropertyById
    test('getPropertyById should return mapped PropertyModel on success', () async {
      // Arrange: When the repository's getPropertyById is called, return a response
      when(
        () => mockPropertyRepository.getPropertyById(1),
      ).thenAnswer((_) async => testPropertyResponse);

      // Act: Call the service method
      final result = await propertyService.getPropertyById(1);

      // Assert: Verify the result and mock interactions
      expect(result, isA<PropertyModel>());
      expect(result.id, testPropertyResponse.id);
      // Verify that the repository method was called exactly once with the correct ID
      verify(() => mockPropertyRepository.getPropertyById(1)).called(1);
    });

    // Test case for getPropertyById with DioException
    test('getPropertyById should rethrow DioException on failure', () async {
      // Arrange: When the repository's getPropertyById is called, throw a DioException
      when(() => mockPropertyRepository.getPropertyById(1)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property/1')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(
        () => propertyService.getPropertyById(1),
        throwsA(isA<DioException>()),
      );
      // Verify that the repository method was called exactly once
      verify(() => mockPropertyRepository.getPropertyById(1)).called(1);
    });

    // Test case for editProperty
    test(
      'editProperty should return updated mapped PropertyModel on success',
      () async {
        // Arrange: When the repository's editProperty is called, return a success response
        when(
          () => mockPropertyRepository.editProperty(testPropertyRequest, 1),
        ).thenAnswer(
          (_) async => PropertyWithMessageResponse(
            property: testPropertyResponse.copyWith(
              title: 'Updated Title',
            ), // Simulate update
            message: 'Property updated successfully!',
          ),
        );

        // Act: Call the service method
        final result = await propertyService.editProperty(
          testPropertyRequest,
          1,
        );

        // Assert: Verify the result and mock interactions
        expect(result, isA<PropertyModel>());
        expect(result.id, testPropertyResponse.id);
        expect(result.title, 'Updated Title'); // Check for the updated title
        // Verify that the repository method was called exactly once with correct arguments
        verify(
          () => mockPropertyRepository.editProperty(testPropertyRequest, 1),
        ).called(1);
      },
    );

    // Test case for editProperty with DioException
    test('editProperty should rethrow DioException on failure', () async {
      // Arrange: When the repository's editProperty is called, throw a DioException
      when(
        () => mockPropertyRepository.editProperty(testPropertyRequest, 1),
      ).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property/1')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(
        () => propertyService.editProperty(testPropertyRequest, 1),
        throwsA(isA<DioException>()),
      );
      // Verify that the repository method was called exactly once
      verify(
        () => mockPropertyRepository.editProperty(testPropertyRequest, 1),
      ).called(1);
    });

    // Test case for deleteProperty
    test('deleteProperty should return mapped PropertyModel on success', () async {
      // Arrange: When the repository's deleteProperty is called, return a success response
      when(() => mockPropertyRepository.deleteProperty(1)).thenAnswer(
        (_) async => PropertyWithMessageResponse(
          property: testPropertyResponse.copyWith(
            status: 'DELETED',
          ), // Simulate deletion
          message: 'Property deleted successfully!',
        ),
      );

      // Act: Call the service method
      final result = await propertyService.deleteProperty(1);

      // Assert: Verify the result and mock interactions
      expect(result, isA<PropertyModel>());
      expect(result.id, testPropertyResponse.id);
      expect(result.status, 'DELETED'); // Check for the updated status
      // Verify that the repository method was called exactly once with the correct ID
      verify(() => mockPropertyRepository.deleteProperty(1)).called(1);
    });

    // Test case for deleteProperty with DioException
    test('deleteProperty should rethrow DioException on failure', () async {
      // Arrange: When the repository's deleteProperty is called, throw a DioException
      when(() => mockPropertyRepository.deleteProperty(1)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/property/1')),
      );

      // Act & Assert: Expect the service method to rethrow the DioException
      expect(
        () => propertyService.deleteProperty(1),
        throwsA(isA<DioException>()),
      );
      // Verify that the repository method was called exactly once
      verify(() => mockPropertyRepository.deleteProperty(1)).called(1);
    });

    // Test case for mapToPropertyModel (mapper function)
    test(
      'mapToPropertyModel should correctly map PropertyResponse to PropertyModel',
      () {
        // Act: Directly call the mapper method
        final model = propertyService.mapToPropertyModel(testPropertyResponse);

        // Assert: Verify the mapping
        expect(model, isA<PropertyModel>());
        expect(model.id, testPropertyResponse.id);
        expect(model.title, testPropertyResponse.title);
        expect(model.description, testPropertyResponse.description);
        expect(model.price, testPropertyResponse.price);
        expect(model.location, testPropertyResponse.location);
        expect(model.beds, testPropertyResponse.beds);
        expect(model.baths, testPropertyResponse.baths);
        expect(model.area, testPropertyResponse.area);
        expect(model.status, testPropertyResponse.status);
        expect(model.sellerId, testPropertyResponse.sellerId);
        expect(model.createdAt, testPropertyResponse.createdAt);
        expect(model.updatedAt, testPropertyResponse.updatedAt);
      },
    );

    // Test case for mapToPropertyModel with null values in response
    test('mapToPropertyModel should handle null values gracefully', () {
      final nullPropertyResponse = PropertyResponse(
        id: null,
        createdAt: null,
        updatedAt: null,
        title: null,
        description: null,
        price: null,
        location: null,
        beds: null,
        baths: null,
        area: null,
        status: null,
        sellerId: null,
      );

      final model = propertyService.mapToPropertyModel(nullPropertyResponse);

      expect(model.id, 0); // Default value for int?
      expect(model.createdAt, null);
      expect(model.updatedAt, null);
      expect(model.title, ''); // Default value for String?
      expect(model.description, '');
      expect(model.price, 0);
      expect(model.location, '');
      expect(model.beds, 0);
      expect(model.baths, 0);
      expect(model.area, 0);
      expect(model.status, '');
      expect(model.sellerId, 0);
    });
  });
}
