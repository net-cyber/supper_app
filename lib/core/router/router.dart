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
import 'package:super_app/features/mortgages/domain/entities/property.dart';
import 'package:super_app/features/mortgages/presentation/screens/available_properties_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_dashboard_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/property_detail_screen.dart';
import 'package:super_app/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:super_app/features/history/presentation/history_screen.dart';
import 'package:super_app/core/presentation/main/main_screen.dart';
import 'package:super_app/features/profile/presentation/profile_screen.dart';
import 'package:super_app/core/presentation/main/shell_page.dart';
import 'package:super_app/features/transf/presentation/sendToInternal/pages/internal_bank_account_screen.dart';
import 'package:super_app/features/transf/presentation/sendToInternal/pages/internal_bank_amount_screen.dart';
import 'package:super_app/features/transf/presentation/sendToInternal/pages/internal_confirm_transfer_screen.dart';

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
      ],
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

    // Internal bank transfer routes
    GoRoute(
      name: RouteName.internalBankAccount,
      path: '/${RouteName.internalBankAccount}',
      builder: (context, state) => const InternalBankAccountScreen(),
    ),
    GoRoute(
      name: RouteName.internalBankAmount,
      path: '/${RouteName.internalBankAmount}',
      builder: (context, state) => InternalBankAmountScreen(
        transferData: state.extra as Map<String, dynamic>,
      ),
    ),
    GoRoute(
      name: RouteName.internalConfirmTransfer,
      path: '/${RouteName.internalConfirmTransfer}',
      builder: (context, state) => InternalConfirmTransferScreen(
        transferData: state.extra as Map<String, dynamic>,
      ),
    ),
  ],
);
