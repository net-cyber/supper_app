import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:super_app/features/chat/common/utils/utils.dart';

class ContactAPI {
  /// 翻页
  /// refresh 是否刷新
  static Future<ContactResponseEntity> post_contact() async {
    var response = await HttpUtil().get(
      'listusers',
      queryParameters: {
        'page_id': '1',
        'page_size': '5',
      },
    );
    print("Contact API Response: $response");

    // Create a wrapper map to match ContactResponseEntity structure
    Map<String, dynamic> wrappedResponse = {
      'code': 0,
      'msg': 'success',
      'data': response, // The list from the API becomes our data field
    };

    return ContactResponseEntity.fromJson(wrappedResponse);
  }
}
