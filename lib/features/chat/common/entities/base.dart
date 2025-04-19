class BaseResponseEntity {
  int? code;
  String? msg;
  String? data;

  BaseResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      BaseResponseEntity(
        code: json["code"] != null ? json["code"] as int : null,
        msg: json["msg"] != null ? json["msg"] as String : null,
        data: json["data"] != null ? json["data"] as String : null,
      );

  Map<String, dynamic> toJson() => {
        "counts": code,
        "msg": msg,
        "items": data,
      };
}

class BindFcmTokenRequestEntity {
  String? fcmtoken;

  BindFcmTokenRequestEntity({
    this.fcmtoken,
  });

  Map<String, dynamic> toJson() => {
        "fcmtoken": fcmtoken,
      };
}
