import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:super_app/features/chat/common/apis/apis.dart';
import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:super_app/features/chat/common/navigation/chat_navigation_service.dart';
import 'package:super_app/features/chat/common/routes/names.dart';
import 'package:super_app/features/chat/common/store/store.dart';
import 'package:super_app/features/chat/common/values/values.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/firebase_options.dart';
import 'package:super_app/core/navigation/navigation_service.dart';

class FirebaseMassagingHandler {
  FirebaseMassagingHandler._();
  static AndroidNotificationChannel channel_call =
      const AndroidNotificationChannel(
    'com.dbestech.super_app.call', // id
    'super_app_call', // title
    importance: Importance.max,
    enableLights: true,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alert'),
  );
  static AndroidNotificationChannel channel_message =
      const AndroidNotificationChannel(
    'com.dbestech.super_app.message', // id
    'super_app_message', // title
    importance: Importance.defaultImportance,
    enableLights: true,
    playSound: true,
    // sound: RawResourceAndroidNotificationSound('alert'),
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> config() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      RemoteMessage newMessage = RemoteMessage();
      await messaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );

      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print("initialMessage------");
        print(initialMessage);
      }
      var initializationSettingsAndroid =
          AndroidInitializationSettings("@mipmap/ic_launcher");
      var darwinInitializationSettings = DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: darwinInitializationSettings);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (value) {
        print("----------onDidReceiveNotificationResponse");
      });

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print("\n notification on onMessage function \n");
        print("Full message data: ${message.data}");
        print("Notification: ${message.notification?.title}");
        print("Has notification: ${message.notification != null}");

        if (message != null) {
          if (message.data != null && message.data["call_type"] != null) {
            if (message.data["call_type"] == "text") {
              // Text messages should show a notification
              _showNotification(message: message);
            } else {
              // Voice, video, and cancel calls use snackbar
              _receiveNotification(message);
            }
          } else {
            // Other messages show notification
            _showNotification(message: message);
          }
        }
      });
    } on Exception catch (e) {
      print("$e");
    }
  }

  static Future<void> _receiveNotification(RemoteMessage message) async {
    if (message.data != null && message.data["call_type"] != null) {
      if (message.data["call_type"] == "voice") {
        var data = message.data;
        print("data: ${data["token"]}");
        print("data: ${data["name"]}");
        print("data: ${data["avatar"]}");
        print("data: ${data["doc_id"]}");
        var to_token = data["token"];
        var to_name = data["name"];
        var to_avatar = data["avatar"];
        var doc_id = data["doc_id"] ?? "";

        // Check if we have a valid context through the navigator key
        final BuildContext? context = NavigationService.currentContext;
        if (to_token != null &&
            to_name != null &&
            to_avatar != null &&
            context != null) {
          try {
            // Show a custom overlay or use ScaffoldMessenger
            showCallNotificationOverlay(
                context: context,
                title: to_name.toString(),
                subtitle: 'Voice call',
                avatar: to_avatar.toString(),
                onDecline: () {
                  // Close the overlay
                  hideCallNotificationOverlay();

                  // Send cancel notification
                  _sendNotifications(
                      'cancel',
                      to_token.toString(),
                      to_avatar.toString(),
                      to_name.toString(),
                      doc_id.toString());
                },
                onAccept: () {
                  // Close the overlay
                  hideCallNotificationOverlay();
                  ChatNavigationService.toVoiceCall(context,
                      docId: doc_id.toString(),
                      toToken: to_token.toString(),
                      toName: to_name.toString(),
                      toAvatar: to_avatar.toString(),
                      callRole: 'audience');
                });
          } catch (e) {
            print("Error showing voice call overlay: $e");
            // Fall back to notification
            _showNotification(
                message: RemoteMessage(
                    notification: RemoteNotification(
                        title: 'Voice Call',
                        body: 'Incoming call from $to_name'),
                    data: message.data));
          }
        } else {
          print("context is not available");
          _showNotification(
              message: RemoteMessage(
                  notification: RemoteNotification(
                      title: 'Voice Call',
                      body: 'Incoming call from ${to_name ?? 'Unknown'}'),
                  data: message.data));
        }
      } else if (message.data["call_type"] == "video") {
        // Use the same approach as voice calls but for video
        var data = message.data;
        var to_token = data["token"];
        var to_name = data["name"];
        var to_avatar = data["avatar"];
        var doc_id = data["doc_id"] ?? "";

        // Check if we have a valid context through the navigator key
        final BuildContext? context = NavigationService.currentContext;
        if (to_token != null &&
            to_name != null &&
            to_avatar != null &&
            context != null) {
          try {
            // Show a custom overlay
            showCallNotificationOverlay(
                context: context,
                title: to_name.toString(),
                subtitle: 'Video call',
                avatar: to_avatar.toString(),
                onDecline: () {
                  // Close the overlay
                  hideCallNotificationOverlay();

                  // Send cancel notification
                  _sendNotifications(
                      'cancel',
                      to_token.toString(),
                      to_avatar.toString(),
                      to_name.toString(),
                      doc_id.toString());
                },
                onAccept: () {
                  // Close the overlay
                  hideCallNotificationOverlay();
                  ChatNavigationService.toVideoCall(context,
                      docId: doc_id.toString(),
                      toToken: to_token.toString(),
                      toName: to_name.toString(),
                      toAvatar: to_avatar.toString(),
                      callRole: 'audience');
                });
          } catch (e) {
            print("Error showing video call overlay: $e");
            // Fall back to notification
            _showNotification(
                message: RemoteMessage(
                    notification: RemoteNotification(
                        title: 'Video Call',
                        body: 'Incoming call from $to_name'),
                    data: message.data));
          }
        } else {
          print("context is not available");
          _showNotification(
              message: RemoteMessage(
                  notification: RemoteNotification(
                      title: 'Video Call',
                      body: 'Incoming call from ${to_name ?? 'Unknown'}'),
                  data: message.data));
        }
      } else if (message.data["call_type"] == "cancel") {
        // Handle call cancellation
        FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
        hideCallNotificationOverlay();

        // Close the current call screen if it's open
        final BuildContext? context = NavigationService.currentContext;
        if (context != null) {
          try {
            // Instead of checking the route with GoRouterState.of(context)
            // Just try to pop if we're in a call screen
            // The navigation service will handle this safely
            context.pop();
          } catch (e) {
            print("Error during navigation on cancel: $e");
          }
        }

        var _prefs = await SharedPreferences.getInstance();
        await _prefs.setString("CallVocieOrVideo", "");
      }
    }
  }

  static Future<void> _sendNotifications(String call_type, String to_token,
      String to_avatar, String to_name, String doc_id) async {
    CallRequestEntity callRequestEntity = new CallRequestEntity();
    callRequestEntity.call_type = call_type;
    callRequestEntity.to_token = to_token;
    callRequestEntity.to_avatar = to_avatar;
    callRequestEntity.doc_id = doc_id;
    callRequestEntity.to_name = to_name;
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    print("sendNotifications");
    print(res);
    if (res.code == 0) {
      print("sendNotifications success");
    } else {
      // Get.snackbar("Tips", "Notification error!");
      // Get.offAllNamed(AppRoutes.Message);
    }
  }

  static Future<void> _showNotification({RemoteMessage? message}) async {
    RemoteNotification? notification = message!.notification;
    AndroidNotification? androidNotification = message.notification!.android;
    AppleNotification? appleNotification = message.notification!.apple;

    if (notification != null &&
        (androidNotification != null || appleNotification != null)) {
      print("Attempting to show notification");
      print("Title: ${notification.title}");
      print("Body: ${notification.body}");
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel_message.id,
            channel_message.name,
            icon: "@mipmap/ic_launcher",
            playSound: true,
            enableVibration: true,
            priority: Priority.defaultPriority,
            // channelShowBadge: true,
            importance: Importance.defaultImportance,
            // sound: RawResourceAndroidNotificationSound('alert'),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
    // PlascoRequests().initReport();
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackground(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("message data: ${message.data}");
    print("message data: ${message}");
    print("message data: ${message.notification}");

    if (message != null) {
      if (message.data != null && message.data["call_type"] != null) {
        if (message.data["call_type"] == "cancel") {
          FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
          //  await setCallVocieOrVideo(false);
          var _prefs = await SharedPreferences.getInstance();
          await _prefs.setString("CallVocieOrVideo", "");
        }
        if (message.data["call_type"] == "voice" ||
            message.data["call_type"] == "video") {
          var data = {
            "to_token": message.data["token"],
            "to_name": message.data["name"],
            "to_avatar": message.data["avatar"],
            "doc_id": message.data["doc_id"] ?? "",
            "call_type": message.data["call_type"],
            "expire_time": DateTime.now().toString(),
          };
          print(data);
          var _prefs = await SharedPreferences.getInstance();
          await _prefs.setString("CallVocieOrVideo", jsonEncode(data));
        }
      }
    }
  }

  // Create an overlay entry to show call notifications
  static OverlayEntry? _overlayEntry;

  static void showCallNotificationOverlay({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String avatar,
    required VoidCallback onDecline,
    required VoidCallback onAccept,
  }) {
    hideCallNotificationOverlay(); // Ensure no duplicate overlays

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(avatar),
                    ),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(subtitle),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: onDecline,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryElementBg,
                          borderRadius: BorderRadius.circular(30.w),
                        ),
                        child: Image.asset("assets/icons/a_phone.png"),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: onAccept,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryElementStatus,
                          borderRadius: BorderRadius.circular(30.w),
                        ),
                        child: Image.asset("assets/icons/a_telephone.png"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Auto-dismiss after 30 seconds
    Future.delayed(Duration(seconds: 30), () {
      hideCallNotificationOverlay();
    });
  }

  static void hideCallNotificationOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
