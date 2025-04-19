import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../pages/contact/binding.dart';
import '../../pages/contact/view.dart';

import '../../pages/message/binding.dart';
import '../../pages/message/chat/binding.dart';
import '../../pages/message/chat/view.dart';
import '../../pages/message/photoview/binding.dart';
import '../../pages/message/photoview/view.dart';
import '../../pages/message/videocall/binding.dart';
import '../../pages/message/videocall/view.dart';
import '../../pages/message/view.dart';
import '../../pages/message/voicecall/binding.dart';
import '../../pages/message/voicecall/view.dart';
import '../../pages/profile/bindings.dart';
import '../../pages/profile/view.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.Message;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];
  static final List<GetPage> routes = [
    // Remove login-related routes and keep only the main features
    GetPage(
        name: AppRoutes.Message,
        page: () => MessagePage(),
        binding: MessageBinding()),
    GetPage(
        name: AppRoutes.Contact,
        page: () => ContactPage(),
        binding: ContactBinding()),
    GetPage(
        name: AppRoutes.Profile,
        page: () => ProfilePage(),
        binding: ProfileBinding()),
    GetPage(
        name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),
    GetPage(
        name: AppRoutes.Photoimgview,
        page: () => PhotoImgViewPage(),
        binding: PhotoImgViewBinding()),
    GetPage(
        name: AppRoutes.VoiceCall,
        page: () => VoiceCallViewPage(),
        binding: VoiceCallViewBinding()),
    GetPage(
        name: AppRoutes.VideoCall,
        page: () => VideoCallPage(),
        binding: VideoCallBinding()),
  ];
}
