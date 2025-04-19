import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:super_app/features/chat/common/utils/utils.dart';
import 'package:super_app/features/chat/common/values/values.dart';

class UserAPI {
  static Future<UserLoginResponseEntity> Login({
    LoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'api/login',
      queryParameters: params?.toJson(),
    );
    return UserLoginResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<UserLoginResponseEntity> get_profile() async {
    var response = await HttpUtil().post(
      'api/get_profile',
    );
    return UserLoginResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<BaseResponseEntity> UpdateProfile({
    LoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'api/update_profile',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response as Map<String, dynamic>);
  }
}
