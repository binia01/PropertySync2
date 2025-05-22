import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/data/local/secure_storage/isecure_storage.dart';
import 'package:my_application/core/data/local/secure_storage/secure_storage.dart';
import 'package:my_application/core/data/local/secure_storage/secure_storage_const.dart';
import 'package:my_application/core/data/remote/token/itoken_service.dart';

final tokenServiceProvider = Provider.family<ITokenService, Dio>((ref, dio) {
  final secureStorage = ref.watch(secureStorageProvider);
  return TokenService(secureStorage);
});

class TokenService implements ITokenService {
  // final Dio _dio;
  final IsecureStorage _secureStorage;

  TokenService(this._secureStorage);

  @override
  Future<void> clearToken() {
    return Future.wait([_secureStorage.delete(accessTokenKey)]);
  }

  @override
  Future<String?> getAccessToken() => _secureStorage.read('access_token');

  @override
  Future<void> saveToken(String accessToken) {
    return Future.wait([_secureStorage.write(accessTokenKey, accessToken)]);
  }
}
