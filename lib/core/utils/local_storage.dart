import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/core/utils/local_storage_key.dart';

class LocalStorage {
  LocalStorage._();
  static SharedPreferences? _preferences;
  static LocalStorage? _localStorage;
  static final LocalStorage instance = LocalStorage._();

  static Future<void> ensureInitialized() async {
    try {
      if (_preferences == null) {
        _preferences = await SharedPreferences.getInstance();
        log('SharedPreferences initialized successfully');
      }
    } catch (e) {
      log('Error initializing SharedPreferences: $e');
      // Initialize with an empty instance to prevent further crashes
      _preferences = null;
    }
  }

  /// init shared preferences
  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// get is onboarding
  bool getIsDoneOnboarding() {
    try {
      if (_preferences == null) {
        log('getIsDoneOnboarding: _preferences is null');
        return false;
      }
      final isDoneOnboarding =
          _preferences!.getBool(LocalStorageKey.isDoneOnboarding);
      log('getIsDoneOnboarding: $isDoneOnboarding');

      return isDoneOnboarding ?? false;
    } catch (e) {
      log('Error in getIsDoneOnboarding: $e');
      return false;
    }
  }

  /// set is onboarding
  Future<void> setIsDoneOnboarding(bool value) async {
    log('setIsDoneOnboarding: $value');
    try {
      await ensureInitialized();
      if (_preferences == null) {
        log('setIsDoneOnboarding: _preferences is still null after initialization');
        return;
      }
      await _preferences!.setBool(LocalStorageKey.isDoneOnboarding, value);
      log('isDoneOnboarding set to: $value');
    } catch (e) {
      log('Error in setIsDoneOnboarding: $e');
    }
  }

  /// delete is onboarding
  Future<void> deleteIsDoneOnboarding() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.remove(LocalStorageKey.isDoneOnboarding);
  }

  /// set refresh token
  Future<void> setRefreshToken(String token) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setString(LocalStorageKey.refreshToken, token);
  }

  /// get refresh token
  String? getRefreshToken() {
    if (_preferences == null) {
      return null;
    }
    return _preferences!.getString(LocalStorageKey.refreshToken);
  }

  /// delete refresh token
  Future<void> deleteRefreshToken() async {
    if (_preferences == null) {
      return;
    }
    await _preferences!.remove(LocalStorageKey.refreshToken);
  }

  /// set token
  Future<void> setAccessToken(String token) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setString(LocalStorageKey.accessToken, token);
  }

  /// get token
  String? getAccessToken() {
    if (_preferences == null) {
      return null;
    }
    return _preferences?.getString(LocalStorageKey.accessToken);
  }

  /// delete token
  Future<void> deleteAccessToken() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.remove(LocalStorageKey.accessToken);
  }

  /// set is dark mode
  Future<void> setIsDarkMode(bool value) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setBool(LocalStorageKey.isDarkMode, value);
  }

  /// get is dark mode
  bool getIsDarkMode() {
    final isDarkMode = _preferences?.getBool(LocalStorageKey.isDarkMode);
    if (isDarkMode == null) {
      return false;
    }
    return isDarkMode;
  }

  /// clear all
  Future<void> clear() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.clear();
  }

  // set app theme mode
  Future<void> setAppThemeMode(bool isDarkMode) async {
    log('setAppThemeMode: $isDarkMode');
    if (_preferences != null) {
      await _preferences!.setBool(LocalStorageKey.themeMode, isDarkMode);
    }
  }

  bool getAppThemeMode() {
    log('getAppThemeMode ${_preferences?.getBool(LocalStorageKey.themeMode)}');
    return _preferences?.getBool(LocalStorageKey.themeMode) ?? false;
  }

  void deleteAppThemeMode() {
    log('deleteAppThemeMode');
    _preferences?.remove(LocalStorageKey.themeMode);
  }

  /// set user data
  Future<void> setUserData(Map<String, dynamic> userData) async {
    if (_preferences == null) {
      return;
    }
    final userDataString = jsonEncode(userData);
    await _preferences?.setString(LocalStorageKey.userData, userDataString);
  }

  /// get user data
  Map<String, dynamic>? getUserData() {
    if (_preferences == null) {
      return null;
    }
    final userDataString = _preferences?.getString(LocalStorageKey.userData);
    if (userDataString == null) {
      return null;
    }
    return jsonDecode(userDataString) as Map<String, dynamic>;
  }

  /// delete user data
  Future<void> deleteUserData() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.remove(LocalStorageKey.userData);
  }

  /// Get user account ID
  int? getUserId() {
    if (_preferences == null) {
      return null;
    }

    final userData = getUserData();
    if (userData == null) {
      return null;
    }

    // Try to get user ID from userData map
    // The field might be named 'id', 'userId', 'accountId', etc. depending on API
    return userData['id'] as int? ??
        userData['userId'] as int? ??
        userData['accountId'] as int? ??
        userData['user_id'] as int? ??
        userData['account_id'] as int?;
  }

  /// clear user session (tokens and data)
  Future<void> clearUserSession() async {
    if (_preferences == null) {
      return;
    }
    await deleteAccessToken();
    await deleteRefreshToken();
    await deleteUserData();
    await deleteTokenExpiration();
  }

  /// set token expiration timestamp (in milliseconds)
  Future<void> setTokenExpiration(int expirationTimestamp) async {
    if (_preferences == null) {
      await ensureInitialized();
    }
    await _preferences?.setInt(
        LocalStorageKey.tokenExpiration, expirationTimestamp);
  }

  /// get token expiration timestamp (in milliseconds)
  int? getTokenExpiration() {
    if (_preferences == null) {
      return null;
    }
    return _preferences?.getInt(LocalStorageKey.tokenExpiration);
  }

  /// delete token expiration
  Future<void> deleteTokenExpiration() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.remove(LocalStorageKey.tokenExpiration);
  }
}
