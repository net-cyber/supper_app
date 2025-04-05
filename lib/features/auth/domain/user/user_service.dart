import 'package:injectable/injectable.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/auth/domain/login/entities/login_response.dart';

abstract class UserService {
  /// Get the current logged in user data
  LoginUser? getCurrentUser();
  // show onboarding screen if user is first time opening the app
  bool isFirstTimeOpeningApp();
  
  /// Check if the user is logged in
  bool isLoggedIn();
  
  /// Logout the user
  Future<void> logout();
}

@Injectable(as: UserService)
class UserServiceImpl implements UserService {

  
  UserServiceImpl();
  
  @override
  LoginUser? getCurrentUser() {
    final userData = LocalStorage.instance.getUserData();
    if (userData == null) {
      return null;
    }
    
    try {
      return LoginUser.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  @override 
  bool isFirstTimeOpeningApp() {
    final isFirstTime = LocalStorage.instance.getIsDoneOnboarding();
    return isFirstTime;
  }
  
  @override
  bool isLoggedIn() {
    final token = LocalStorage.instance.getAccessToken();
    return token != null && token.isNotEmpty;
  }
  
  @override
  Future<void> logout() async {
    await LocalStorage.instance.clearUserSession();
  }
} 