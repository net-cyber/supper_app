import 'package:injectable/injectable.dart';
import 'package:super_app/core/utils/local_storage.dart';

/// Service for managing authentication tokens
@lazySingleton
class TokenService {
  /// Get the current user's access token
  Future<String?> getAccessToken() async {
    return LocalStorage.instance.getAccessToken();
  }

  /// Check if the user is logged in (has a valid token)
  Future<bool> isUserLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Check if the token has expired
  Future<bool> isTokenExpired() async {
    try {
      // Get the token expiration timestamp
      final expirationTimestamp = LocalStorage.instance.getTokenExpiration();

      // If no expiration is stored, assume token is expired
      if (expirationTimestamp == null) return true;

      // Check if the token has expired
      final now = DateTime.now().millisecondsSinceEpoch;
      return now >= expirationTimestamp;
    } catch (e) {
      // If any error occurs, assume token is expired to trigger refresh
      return true;
    }
  }

  /// Clear all authentication data
  Future<void> logout() async {
    await LocalStorage.instance.clearUserSession();
  }
}
