import 'dart:io';
import 'package:dio/dio.dart';
import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:super_app/features/chat/common/utils/utils.dart';
import 'package:super_app/features/chat/common/values/values.dart';

class ChatAPI {
  static Future<BaseResponseEntity> bind_fcmtoken(
      {BindFcmTokenRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'fcmtoken',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<BaseResponseEntity> call_notifications(
      {CallRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'sendnotice',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<BaseResponseEntity> call_token(
      {CallTokenRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'get_rtc_token',
      data: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<BaseResponseEntity> send_message(
      {ChatRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/message',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<BaseResponseEntity> upload_img({File? file}) async {
    String fileName = file!.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    var response = await HttpUtil().post(
      'api/upload_photo',
      data: data,
    );
    return BaseResponseEntity.fromJson(response as Map<String, dynamic>);
  }

  static Future<SyncMessageResponseEntity> sync_message(
      {SyncMessageRequestEntity? params}) async {
    var response = await HttpUtil().post(
      'api/sync_message',
      queryParameters: params?.toJson(),
    );
    return SyncMessageResponseEntity.fromJson(response as Map<String, dynamic>);
  }
}
