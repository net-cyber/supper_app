import 'package:flutter/material.dart';
import 'package:super_app/core/router/router.dart' as app_router;

class ChatNavigationService {
  static void toMessage(BuildContext context) {
    app_router.navigateToMessage(context);
  }

  static void toChat(
    BuildContext context, {
    required String docId,
    required String toToken,
    required String toName,
    required String toAvatar,
    required String toOnline,
  }) {
    app_router.navigateToChat(
      context,
      docId: docId,
      toToken: toToken,
      toName: toName,
      toAvatar: toAvatar,
      toOnline: toOnline,
    );
  }

  static void toContact(BuildContext context) {
    app_router.navigateToContact(context);
  }

  static void toVoiceCall(
    BuildContext context, {
    required String docId,
    required String toToken,
    required String toName,
    required String toAvatar,
    required String callRole,
  }) {
    app_router.navigateToVoiceCall(
      context,
      docId: docId,
      toToken: toToken,
      toName: toName,
      toAvatar: toAvatar,
      callRole: callRole,
    );
  }

  static void toVideoCall(
    BuildContext context, {
    required String docId,
    required String toToken,
    required String toName,
    required String toAvatar,
    required String callRole,
  }) {
    app_router.navigateToVideoCall(
      context,
      docId: docId,
      toToken: toToken,
      toName: toName,
      toAvatar: toAvatar,
      callRole: callRole,
    );
  }

  static void back(BuildContext context) {
    app_router.navigateToMessage(context);
  }
}
