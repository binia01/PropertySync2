abstract interface class ITokenService {
  Future<String?> getAccessToken();
  Future<void> saveToken(String accessToken);
  Future<void> clearToken();
}
