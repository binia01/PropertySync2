
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart'; // For DioException
import 'package:my_application/core/data/remote/token/itoken_service.dart';
import 'package:my_application/features/auth/login/data/dto/request/login_request.dart';
import 'package:my_application/features/auth/login/data/dto/response/login_response.dart';
import 'package:my_application/features/auth/login/data/repository/login_repository.dart';
import 'package:my_application/features/auth/login/data/source/remote/login_api.dart';

@GenerateMocks([LoginApi, ITokenService])

import 'login_repository_test.mocks.dart';

void main (){
  late MockLoginApi mokLoginApi;
  late MockITokenService mockITokenService;
  late LoginRepository loginRepository;

  setUp(() {
    mokLoginApi = MockLoginApi();
    mockITokenService = MockITokenService();
    loginRepository = LoginRepository(mokLoginApi, mockITokenService);

  });

  group('Login Repository Test Suit', () {
    final test_LoginReq = LoginRequest(email: "someemail@ex.com", password: "password");
    final test_loginResp = LoginResponse(accessToken: "token");

    test("Should Login Api and save the token upon success login", () async {
      when(mokLoginApi.login(test_LoginReq)).thenAnswer((_) async => test_loginResp);
      when(mockITokenService.saveToken(test_loginResp.accessToken)).thenAnswer((_) async => {});

      final result = await loginRepository.login(test_LoginReq);

      expect(result, equals(test_loginResp));
      verify(mokLoginApi.login(test_LoginReq)).called(1);
      verify(mockITokenService.saveToken(test_loginResp.accessToken)).called(1);
      verifyNoMoreInteractions(mokLoginApi);
      verifyNoMoreInteractions(mockITokenService);

    });

    test("should re throw the dio exception when api fails", () async {
      final dioEcption = DioException(
        requestOptions: RequestOptions(path: "/auth/singin"),
        response: Response(requestOptions: RequestOptions(path: "/auth/signin"), data: {'message': 'Server Error'}, statusCode: 500),
        type: DioExceptionType.badResponse,
        error: 'Server Error',
      );

      when(mokLoginApi.login(any)).thenThrow(dioEcption);

      expect( () => loginRepository.login(test_LoginReq), throwsA(equals(dioEcption)));
      verify(mokLoginApi.login(test_LoginReq)).called(1);
      verifyZeroInteractions(mockITokenService);
      verifyNoMoreInteractions(mokLoginApi);
    });

  });
}