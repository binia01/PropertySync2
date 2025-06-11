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
  final IsecureStorage _secureStorage;

  // Add in-memory cache for role
  String? _cachedRole;

  TokenService(this._secureStorage);

  @override
  Future<void> clearToken() {
    return _secureStorage.delete(accessTokenKey);
  }

  @override
  Future<String?> getAccessToken() => _secureStorage.read(accessTokenKey);

  @override
  Future<void> saveToken(String accessToken) {
    return Future.wait([_secureStorage.write(accessTokenKey, accessToken)]);
  }

  @override
  Future<void> clearRole() async {
    _cachedRole = null;
    await _secureStorage.delete(roleKey);
  }

  @override
  Future<void> saveRole(String role) async {
    _cachedRole = role;
    await _secureStorage.write(roleKey, role);
  }

  @override
  Future<String?> getRole() async {
    if (_cachedRole != null) return _cachedRole;
    _cachedRole = await _secureStorage.read(roleKey);
    return _cachedRole;
  }
}
