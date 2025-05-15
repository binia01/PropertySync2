abstract interface class ITokenService {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> saveToken(String accessToken, String refreshToken);
  Future<void> clearToken();
  Future<String?> refeshToken(String? refreshToken);
}
