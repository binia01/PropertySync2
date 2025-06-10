
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';
import 'package:my_application/features/auth/login/data/source/remote/login_api.dart';

@GenerateMocks([Dio])

import 'login_api_test.mocks.dart';

void main(){
  late MockDio mockDio;
  late LoginApi loginApi;

  setUp(() {
    mockDio = MockDio();
    loginApi = LoginApi(mockDio);
  });

  group("LoginApi Test Suit", ()  {
    final test_LoginReq = LoginRequest(email: "someemail@ex.com", password: "password");
    final test_loginResp = LoginResponse(accessToken: "token");

    test('Should return success login ', () async {
      when(mockDio.post<Map<String, dynamic>>(
        any, data: anyNamed('data'),
      )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: '/auth/signin'),
          data: test_loginResp.toJson(),
          statusCode: 200
      ));

      final result =  await loginApi.login(test_LoginReq);

      expect(result, equals(test_loginResp));
      verify(mockDio.post<Map<String, dynamic>>(
        '/auth/signin',
        data: test_LoginReq.toJson(),
      )).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test("Should have dio exception", () async {
      when(mockDio.post<Map<String, dynamic>>(
        any, data: anyNamed("data"),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/auth/signin'),
        response: Response(
          requestOptions: RequestOptions(path: '/auth/signin'),
          data: {'message': 'Invalid credentials'},
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
        error: 'Invalid credentials',
      ));
      dynamic caughtException;
      try {
        await loginApi.login(test_LoginReq);
      } catch (e) {
        caughtException = e;
      }

      // Assert
      expect(caughtException, isA<Exception>());
      expect(caughtException.toString(), contains('Failed to login: '));
      verify(mockDio.post<Map<String, dynamic>>(
        '/auth/signin',
        data: test_LoginReq.toJson(),
      )).called(1);
      verifyNoMoreInteractions(mockDio);
    });

  });
}
