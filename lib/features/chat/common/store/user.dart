import 'dart:convert';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:super_app/features/chat/common/routes/names.dart';
import 'package:super_app/features/chat/common/services/services.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 令牌 token
  String token = '';
  // 用户 profile
  final _profile = UserItem().obs;

  UserItem get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = LocalStorage.instance.getAccessToken() ?? "";
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _profile(UserItem.fromJson(
          jsonDecode(profileOffline) as Map<String, dynamic>));
    }
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  // 获取 profile
  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    // var result = await UserAPI.profile();
    // _profile(result);
    // _isLogin.value = true;
    return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  // 保存 profile
  Future<void> saveProfile(UserItem profile) async {
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
    setToken(profile.access_token!);
  }

  // 注销
}
