class ContactResponseEntity {
  int? code;
  String? msg;
  List<ContactItem>? data;

  ContactResponseEntity({
    this.code,
    this.msg,
    this.data,
  });
  factory ContactResponseEntity.fromJson(Map<String, dynamic> json) =>
      ContactResponseEntity(
        code: json["code"] != null ? json["code"] as int : null,
        msg: json["msg"] != null ? json["msg"] as String : null,
        data: json["data"] == null
            ? []
            : List<ContactItem>.from((json["data"] as List)
                .map((x) => ContactItem.fromJson(x as Map<String, dynamic>))),
      );

  Map<String, dynamic> toJson() => {
        "counts": code,
        "msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

// login result
class ContactItem {
  String? username;
  String? full_name;
  String? international_phone_number;
  String? avatar;
  String? fcmtoken;
  bool? online;
  String? token;
  String? role;
  bool? phone_verified;

  ContactItem({
    this.username,
    this.full_name,
    this.international_phone_number,
    this.avatar,
    this.fcmtoken,
    this.online,
    this.token,
    this.role,
    this.phone_verified,
  });

  factory ContactItem.fromJson(Map<String, dynamic> json) => ContactItem(
        username: json["username"] as String?,
        full_name: json["full_name"] as String?,
        international_phone_number:
            json["international_phone_number"] as String?,
        avatar: json["avatar"] as String?,
        fcmtoken: json["fcmtoken"] as String?,
        online: json["online"] as bool?,
        token: json["token"] as String?,
        role: json["role"] as String?,
        phone_verified: json["phone_verified"] as bool?,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "full_name": full_name,
        "international_phone_number": international_phone_number,
        "avatar": avatar,
        "fcmtoken": fcmtoken,
        "online": online,
        "token": token,
        "role": role,
        "phone_verified": phone_verified,
      };
}
