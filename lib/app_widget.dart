import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/core/application/app/bloc/app_bloc.dart';
import 'package:super_app/core/application/app/bloc/app_state.dart';
import 'package:super_app/core/router/router.dart';
import 'package:super_app/core/router/slide_transition.dart';
import 'package:super_app/core/theme/app_theme.dart';
import 'package:super_app/l10n/l10n.dart';
import 'package:super_app/features/chat/common/langs/translation_service.dart';
import 'package:super_app/features/chat/common/routes/pages.dart';
import 'package:super_app/features/chat/common/store/store.dart';
import 'package:super_app/features/chat/common/utils/FirebaseMassagingHandler.dart';
import 'package:super_app/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  Future<void> _initializeChatFeature() async {
    await Global.init(); // Initialize chat globals

    // Firebase messaging setup
    FirebaseMessaging.onBackgroundMessage(
      FirebaseMassagingHandler.firebaseMessagingBackground,
    );

    if (GetPlatform.isAndroid) {
      await FirebaseMassagingHandler.flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(FirebaseMassagingHandler.channel_call);
      await FirebaseMassagingHandler.flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(FirebaseMassagingHandler.channel_message);
    }

    FirebaseMassagingHandler.config();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    // Initialize chat feature
    _initializeChatFeature();

    return BlocProvider(
      create: (context) => AppBloc(),
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => BlocConsumer<AppBloc, AppState>(
        listenWhen: (previous, current) =>
            previous.isDarkMode != current.isDarkMode,
        listener: (context, state) {
          // Print debug info when theme changes
          debugPrint('Theme changed: isDarkMode = ${state.isDarkMode}');
        },
        buildWhen: (previous, current) =>
            previous.isDarkMode != current.isDarkMode,
        builder: (context, state) => MaterialApp.router(
          theme: AppTheme.lightTheme().copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomTransitionBuilder(),
              },
            ),
          ),
          darkTheme: AppTheme.darkTheme().copyWith(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomTransitionBuilder(),
              },
            ),
          ),
          localizationsDelegates: [
            ...AppLocalizations.localizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          builder: (context, child) {
            child = EasyLoading.init()(context, child);
            return child ?? const SizedBox();
          },
        ),
      ),
    );
  }
}
