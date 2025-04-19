import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRequestEntity {
  int? type;
  String? name;
  String? description;
  String? email;
  String? phone;
  String? avatar;
  String? open_id;
  int? online;

  LoginRequestEntity({
    this.type,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.avatar,
    this.open_id,
    this.online,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "description": description,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "open_id": open_id,
        "online": online,
      };
}

//api post response msg
class UserLoginResponseEntity {
  int? code;
  String? msg;
  UserItem? data;

  UserLoginResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        code: json["code"] != null ? json["code"] as int : null,
        msg: json["msg"] != null ? json["msg"] as String : null,
        data: json["data"] != null
            ? UserItem.fromJson(json["data"] as Map<String, dynamic>)
            : null,
      );
}

// login result
class UserItem {
  String? access_token;
  String? token;
  String? name;
  String? description;
  String? avatar;
  int? online;
  int? type;

  UserItem({
    this.access_token,
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.type,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) => UserItem(
        access_token: json["access_token"] != null
            ? json["access_token"] as String
            : null,
        token: json["token"] != null ? json["token"] as String : null,
        name: json["name"] != null ? json["name"] as String : null,
        description:
            json["description"] != null ? json["description"] as String : null,
        avatar: json["avatar"] != null ? json["avatar"] as String : null,
        online: json["online"] != null ? json["online"] as int : null,
        type: json["type"] != null ? json["type"] as int : null,
      );

  Map<String, dynamic> toJson() => {
        "access_token": access_token,
        "token": token,
        "name": name,
        "description": description,
        "avatar": avatar,
        "online": online,
        "type": type,
      };
}

class UserData {
  final String? token;
  final String? name;
  final String? avatar;
  final String? description;
  final int? online;

  UserData({
    this.token,
    this.name,
    this.avatar,
    this.description,
    this.online,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      token: data?['token'] != null ? data!['token'] as String : null,
      name: data?['name'] != null ? data!['name'] as String : null,
      avatar: data?['avatar'] != null ? data!['avatar'] as String : null,
      description:
          data?['description'] != null ? data!['description'] as String : null,
      online: data?['online'] != null ? data!['online'] as int : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (name != null) "name": name,
      if (avatar != null) "avatar": avatar,
      if (description != null) "description": description,
      if (online != null) "online": online,
    };
  }
}
