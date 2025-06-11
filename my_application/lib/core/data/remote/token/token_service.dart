import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

  // static const _userIdKey = 'user_id_key';

  String? _cachedRole;
  String? _cachedAccessToken;
  String? _cachedUserId;

  TokenService(this._secureStorage);

  @override
  Future<void> clearToken() async {
    debugPrint("TokenService: Executing deleteToken(). Clearing ALL cached data (token, role, userId).");
    _cachedAccessToken = null;
    _cachedRole = null;
    _cachedUserId = null;
    await Future.wait([
      _secureStorage.delete(accessTokenKey),
      _secureStorage.delete(roleKey),
      _secureStorage.delete(userIdKey),
    ]);
    debugPrint("TokenService: Token, role, and userId storage cleared.");
  }

  @override
  Future<String?> getAccessToken() async {
    if (_cachedAccessToken != null) {
      debugPrint("TokenService: getAccessToken() - Returning cached token.");
      return _cachedAccessToken;
    }
    debugPrint("TokenService: getAccessToken() - Reading token from secure storage.");
    _cachedAccessToken = await _secureStorage.read(accessTokenKey);
    debugPrint("TokenService: getAccessToken() - Stored token: ${(_cachedAccessToken != null && _cachedAccessToken!.isNotEmpty) ? 'Found token (length: ${_cachedAccessToken!.length})' : 'No token found'}");
    return _cachedAccessToken;
  }

  @override
  Future<void> saveToken(String accessToken) async {
    debugPrint("TokenService: saveToken() - Saving token to cache and secure storage.");
    _cachedAccessToken = accessToken;
    await _secureStorage.write(accessTokenKey, accessToken);
    debugPrint("TokenService: saveToken() - Token saved.");
  }

  @override
  Future<void> clearRole() async {
    debugPrint("TokenService: clearRole() - Clearing cached role and role from secure storage.");
    _cachedRole = null;
    await _secureStorage.delete(roleKey);
    debugPrint("TokenService: clearRole() - Role cleared.");
  }

  @override
  Future<void> saveRole(String role) async {
    debugPrint("TokenService: saveRole() - Saving role to cache and secure storage: $role");
    _cachedRole = role;
    await _secureStorage.write(roleKey, role);
    debugPrint("TokenService: saveRole() - Role saved.");
  }

  @override
  Future<String?> getRole() async {
    if (_cachedRole != null) {
      debugPrint("TokenService: getRole() - Returning cached role: $_cachedRole");
      return _cachedRole;
    }
    debugPrint("TokenService: getRole() - Reading role from secure storage.");
    _cachedRole = await _secureStorage.read(roleKey);
    debugPrint("TokenService: getRole() - Stored role: $_cachedRole");
    return _cachedRole;
  }

  @override
  Future<void> saveUserId(String userId) async {
    debugPrint("TokenService: saveUserId() - Saving userId to cache and secure storage: $userId");
    _cachedUserId = userId;
    await _secureStorage.write(userIdKey, userId);
    debugPrint("TokenService: saveUserId() - UserId saved.");
  }

  @override
  Future<String?> getUserId() async {
    if (_cachedUserId != null) {
      debugPrint("TokenService: getUserId() - Returning cached userId: $_cachedUserId");
      return _cachedUserId;
    }
    debugPrint("TokenService: getUserId() - Reading userId from secure storage.");
    _cachedUserId = await _secureStorage.read(userIdKey);
    debugPrint("TokenService: getUserId() - Stored userId: $_cachedUserId");
    return _cachedUserId;
  }

  @override
  Future<void> clearUserId() async {
    debugPrint("TokenService: clearUserId() - Clearing cached userId and userId from secure storage.");
    _cachedUserId = null;
    await _secureStorage.delete(userIdKey);
    debugPrint("TokenService: clearUserId() - UserId cleared.");
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
