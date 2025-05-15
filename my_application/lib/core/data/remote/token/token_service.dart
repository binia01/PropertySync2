import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/local/secure_storage/isecure_storage.dart';
import 'package:my_application/core/data/local/secure_storage/secure_storage.dart';
import 'package:my_application/core/data/local/secure_storage/secure_storage_const.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';

final tokenServiceProvider = Provider.family<ITokenService, Dio>((ref, dio) {
  final secureStorage = ref.watch(secureStorageProvider);
  return TokenService(dio, secureStorage);
});

class TokenService implements ITokenService {
  final Dio _dio;
  final IsecureStorage _secureStorage;

  TokenService(this._dio, this._secureStorage);

  @override
  Future<void> clearToken() {
    return Future.wait([
      _secureStorage.delete(accessTokenKey),
      _secureStorage.delete(refreshTokenKey),
    ]);
  }

  @override
  Future<String?> getAccessToken() => _secureStorage.read('access_token');

  @override
  Future<String?> getRefreshToken() => _secureStorage.read('refresh_token');

  @override
  Future<void> saveToken(String accessToken, String refreshToken) {
    return Future.wait([
      _secureStorage.write(accessTokenKey, accessToken),
      _secureStorage.write(refreshTokenKey, refreshToken),
    ]);
  }

  @override
  Future<String> refeshToken(String? refreshToken) async {
    throw UnimplementedError('Token refresh is not supported by backend');
    // final response = await _dio.post<Map<String, dynamic>>(
    //   '/auth/signup',
    //   data: {'refresh_token': refreshToken},
    // );
    // if (response.statusCode == 200) {
    //   final data = response.data;
    //   final accessToken = data?['access_token'] as String?;
    //   final newRefreshToken = data?['refresh_token'] as String?;
    //
    //   if (accessToken != null && newRefreshToken != null) {
    //     await saveToken(accessToken, newRefreshToken);
    //     return accessToken;
    //   }
    // } else {
    //   throw DioException(
    //     requestOptions: response.requestOptions,
    //     response: response,
    //   );
    // }
    // throw Exception(
    //   'Failed to refresh token: invalid response or missing tokens',
    // );
  }
}
