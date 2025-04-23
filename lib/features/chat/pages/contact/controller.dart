import 'dart:convert';

import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/auth/domain/login/entities/login_response.dart';
import 'package:super_app/features/auth/domain/user/user_service.dart';
import 'package:super_app/features/chat/common/apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:super_app/features/chat/common/store/store.dart';
import 'index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_app/features/chat/common/navigation/chat_navigation_service.dart';

class ContactController extends GetxController {
  ContactController();
  final ContactState state = ContactState();
  final db = FirebaseFirestore.instance;
  // final token = UserStore.to.profile.token;
  late final UserService userService;
  LoginUser? user;
  late final String token;
  goChat(BuildContext context, ContactItem contactItem) async {
    var from_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: contactItem.token)
        .get();
    var to_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: contactItem.token)
        .where("to_token", isEqualTo: token)
        .get();

    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      print("----from_messages--to_messages--empty--");
      final userService = getIt<UserService>();
      final LoginUser? user = userService.getCurrentUser();

      // var profile = UserStore.to.profile;
      var msgdata = new Msg(
        from_token: user?.token,
        to_token: contactItem.token,
        from_name: user?.full_name,
        to_name: contactItem.username,
        from_avatar: user?.avatar,
        to_avatar: contactItem.avatar,
        from_online: true,
        to_online: contactItem.online,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      var doc_id = await db
          .collection("message")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .add(msgdata);

      ChatNavigationService.toChat(
        context,
        docId: doc_id.id,
        toToken: contactItem.token ?? "",
        toName: contactItem.username ?? "",
        toAvatar: contactItem.avatar ?? "",
        toOnline: (contactItem.online ?? false).toString(),
      );
    } else {
      if (!from_messages.docs.isEmpty) {
        print("---from_messages");
        print(from_messages.docs.first.id);
        ChatNavigationService.toChat(
          context,
          docId: from_messages.docs.first.id,
          toToken: contactItem.token ?? "",
          toName: contactItem.username ?? "",
          toAvatar: contactItem.avatar ?? "",
          toOnline: (contactItem.online ?? false).toString(),
        );
      }
      if (!to_messages.docs.isEmpty) {
        print("---to_messages");
        print(to_messages.docs.first.id);
        ChatNavigationService.toChat(
          context,
          docId: to_messages.docs.first.id,
          toToken: contactItem.token ?? "",
          toName: contactItem.username ?? "",
          toAvatar: contactItem.avatar ?? "",
          toOnline: (contactItem.online ?? false).toString(),
        );
      }
    }
  }

  // 拉取数据
  asyncLoadAllData() async {
    EasyLoading.show(
        indicator: CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    state.contactList.clear();
    var result = await ContactAPI.post_contact();

    if (result.code == 0) {
      state.contactList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }

  /// 初始
  @override
  void onInit() {
    super.onInit();
    userService = getIt<UserService>();
    user = userService.getCurrentUser();
    token = user?.token ?? "";
  }

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
