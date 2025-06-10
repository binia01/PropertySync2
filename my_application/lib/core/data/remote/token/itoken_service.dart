abstract interface class ITokenService {
  Future<String?> getAccessToken();
  Future<void> saveToken(String accessToken);
  Future<void> clearToken();
  Future<String?> getRole();
  Future<void> saveRole(String role);
  Future<void> clearRole();

  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  Future<void> clearUserId();
}
