import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/navigation/navigation_service.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/auth/presentation/pages/login/login_screen.dart';
import 'package:super_app/features/auth/presentation/pages/onboarding/onboarding_screen.dart';
import 'package:super_app/features/auth/presentation/pages/registration/registration_screen.dart';
import 'package:super_app/features/auth/presentation/pages/terms/terms_and_conditions_screen.dart';
import 'package:super_app/features/auth/presentation/pages/verification/otp_verification_screen.dart';
import 'package:super_app/features/mini_app/presentation/screens/webView.dart';
import 'package:super_app/features/mortgages/domain/entities/property.dart';
import 'package:super_app/features/mortgages/presentation/screens/available_properties_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_dashboard_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/property_detail_screen.dart';
import 'package:super_app/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:super_app/features/history/presentation/history_screen.dart';
import 'package:super_app/core/presentation/main/main_screen.dart';
import 'package:super_app/features/profile/presentation/profile_screen.dart';
import 'package:super_app/core/presentation/main/shell_page.dart';
import 'package:super_app/features/chat/pages/message/view.dart';
import 'package:super_app/features/chat/pages/contact/view.dart';
import 'package:super_app/features/chat/pages/profile/view.dart';
import 'package:super_app/features/chat/pages/message/chat/view.dart';

import 'package:super_app/features/chat/pages/message/voicecall/view.dart';
import 'package:super_app/features/chat/pages/message/videocall/view.dart';
import 'package:get/get.dart';

// Mobile Topup Route Paths
const String mobileTopupPath = '/mobileTopup';
const String mobileTopupPhoneNumberPath = '/mobileTopupPhoneNumber';
const String mobileTopupAmountPath = '/mobileTopupAmount';
const String mobileTopupConfirmationPath = '/mobileTopupConfirmation';
const String mobileTopupSuccessPath = '/mobileTopupSuccess';

// Mobile Topup Navigation Methods
void navigateToMobileTopupSelectOperator(BuildContext context) {
  context.goNamed(RouteName.mobileTopup);
}

void navigateToMobileTopupPhoneNumber(
  BuildContext context, {
  required String operatorName,
  required String operatorLogo,
}) {
  context.goNamed(
    RouteName.mobileTopupPhoneNumber,
    extra: {
      'operatorName': operatorName,
      'operatorLogo': operatorLogo,
    },
  );
}

void navigateToMobileTopupAmount(BuildContext context) {
  context.goNamed(RouteName.mobileTopupAmount);
}

void navigateToMobileTopupConfirmation(BuildContext context) {
  context.goNamed(RouteName.mobileTopupConfirmation);
}

void navigateToMobileTopupSuccess(BuildContext context) {
  context.goNamed(RouteName.mobileTopupSuccess);
}

final router = GoRouter(
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/${RouteName.splash}',
  routes: [
    // Splash
    GoRoute(
      name: RouteName.splash,
      path: '/${RouteName.splash}',
      builder: (context, state) => const SplashPage(),
    ),

    // Onboarding
    GoRoute(
      name: RouteName.onboarding,
      path: '/${RouteName.onboarding}',
      builder: (context, state) => const OnboardingPage(),
    ),

    // Registration
    GoRoute(
      name: RouteName.registrationScreen,
      path: '/${RouteName.registrationScreen}',
      builder: (context, state) => const RegistrationScreen(),
    ),

    // Login
    GoRoute(
      name: RouteName.login,
      path: '/${RouteName.login}',
      builder: (context, state) => const LoginScreen(),
    ),

    // OTP Verification
    GoRoute(
      name: RouteName.otpVerification,
      path: '/${RouteName.otpVerification}',
      builder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        return OTPVerificationScreen(
          phoneNumber: extra['phoneNumber'] as String,
          expiresAt: extra['expiresAt'] as DateTime?,
        );
      },
    ),

    // Terms and Conditions
    GoRoute(
      name: RouteName.termsAndConditionsScreen,
      path: '/${RouteName.termsAndConditionsScreen}',
      builder: (context, state) => const TermsAndConditionsScreen(),
    ),
    GoRoute(
      name: RouteName.webView,
      path: '/${RouteName.webView}',
      builder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        return MiniAppWebView(
          title: extra['title'] as String,
          url: extra['url'] as String,
        );
      },
    ),
    // Settings
    // GoRoute(
    //   name: RouteName.settings,
    //   path: '/${RouteName.settings}',
    //   builder: (context, state) => const SettingsPage(),
    // ),

    // Register
    // GoRoute(
    //   name: RouteName.register,
    //   path: '/${RouteName.register}',
    //   builder: (context, state) => const RegisterPage(),
    // ),

    // Shell Route
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellPage(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.mainScreen,
              path: '/${RouteName.mainScreen}',
              builder: (context, state) => BlocProvider(
                create: (context) => getIt<AccountsBloc>(),
                child: const MainScreen(),
              ),
              routes: const [],
            ),
          ],
        ),
        // History Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.mortgageDashboard,
              path: '/${RouteName.mortgageDashboard}',
              builder: (context, state) => const MortgageDashboardScreen(),
            ),
            GoRoute(
              name: RouteName.history,
              path: '/${RouteName.history}',
              builder: (context, state) => const HistoryScreen(),
            ),
          ],
        ),
        // Profile Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.profile,
              path: '/${RouteName.profile}',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        // Card Branch
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       name: RouteName.card,
        //       path: '/${RouteName.card}',
        //       builder: (context, state) => const CardPage(),
        //     ),
        //   ],
        // ),
        // Send Branch
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       name: RouteName.send,
        //       path: '/${RouteName.send}',
        //       builder: (context, state) => SendMoneyPage(),
        //     ),
        //   ],
        // ),
        // Recipients Branch
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       name: RouteName.convert,
        //       path: '/${RouteName.convert}',
        //       builder: (context, state) => const ConvertCurrencyPage(), // Replace with RecipientsPage
        //     ),
        //   ],
        // ),
        // Manage Branch
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       name: RouteName.manage,
        //       path: '/${RouteName.manage}',
        //       builder: (context, state) => const SettingsPage(), // Replace with ManagePage
        //     ),
        //   ],
        // ),
        // Chat Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.message,
              path: '/${RouteName.message}',
              builder: (context, state) => MessagePage(),
            ),
          ],
        ),
        // Contact Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RouteName.contact,
              path: '/${RouteName.contact}',
              builder: (context, state) => ContactPage(),
            ),
          ],
        ),
      ],
    ),

    // Chat detail routes without bottom navigation bar
    GoRoute(
      name: RouteName.chat,
      path: '/${RouteName.message}/chat',
      parentNavigatorKey: NavigationService.navigatorKey,
      builder: (context, state) {
        final Map<String, dynamic>? extra =
            state.extra as Map<String, dynamic>?;
        return ChatPage(arguments: extra);
      },
    ),
    GoRoute(
      name: RouteName.voiceCall,
      path: '/${RouteName.message}/voice-call',
      parentNavigatorKey: NavigationService.navigatorKey,
      builder: (context, state) {
        final Map<String, dynamic>? extra =
            state.extra as Map<String, dynamic>?;
        return VoiceCallViewPage(arguments: extra);
      },
    ),
    GoRoute(
      name: RouteName.videoCall,
      path: '/${RouteName.message}/video-call',
      parentNavigatorKey: NavigationService.navigatorKey,
      builder: (context, state) {
        final Map<String, dynamic>? extra =
            state.extra as Map<String, dynamic>?;
        return VideoCallPage(arguments: extra);
      },
    ),

    GoRoute(
      name: RouteName.propertyDetail,
      path: '/${RouteName.propertyDetail}',
      builder: (context, state) =>
          PropertyDetailScreen(property: state.extra as Property),
    ),
    GoRoute(
      name: RouteName.availableProperties,
      path: '/${RouteName.availableProperties}',
      builder: (context, state) => const AvailablePropertiesScreen(),
    ),
  ],
);

// Add navigation helper methods
void navigateToMessage(BuildContext context) {
  context.goNamed(RouteName.message);
}

void navigateToChat(
  BuildContext context, {
  required String docId,
  required String toToken,
  required String toName,
  required String toAvatar,
  required String toOnline,
}) {
  context.pushNamed(
    RouteName.chat,
    extra: {
      "doc_id": docId,
      "to_token": toToken,
      "to_name": toName,
      "to_avatar": toAvatar,
      "to_online": toOnline,
    },
  );
}

void navigateToContact(BuildContext context) {
  context.goNamed(RouteName.contact);
}

void navigateToPhotoView(BuildContext context) {
  context.goNamed(RouteName.photoImgView);
}

void navigateToVoiceCall(
  BuildContext context, {
  required String docId,
  required String toToken,
  required String toName,
  required String toAvatar,
  required String callRole,
}) {
  context.pushNamed(
    RouteName.voiceCall,
    extra: {
      "doc_id": docId,
      "to_token": toToken,
      "to_name": toName,
      "to_avatar": toAvatar,
      "call_role": callRole,
    },
  );
}

void navigateToVideoCall(
  BuildContext context, {
  required String docId,
  required String toToken,
  required String toName,
  required String toAvatar,
  required String callRole,
}) {
  context.pushNamed(
    RouteName.videoCall,
    extra: {
      "doc_id": docId,
      "to_token": toToken,
      "to_name": toName,
      "to_avatar": toAvatar,
      "call_role": callRole,
    },
  );
}
