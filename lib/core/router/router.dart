import 'package:go_router/go_router.dart';
import 'package:super_app/core/navigation/navigation_service.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/mortgages/domain/entities/property.dart';
import 'package:super_app/features/mortgages/presentation/screens/available_properties_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_dashboard_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/property_detail_screen.dart';
import 'package:super_app/features/auth/presentation/pages/login/login_screen.dart';
import 'package:super_app/features/auth/presentation/pages/signup/signup_screen.dart';
import 'package:super_app/features/auth/presentation/pages/splash/splash_screen.dart';
import 'package:super_app/features/history/presentation/history_screen.dart';
import 'package:super_app/core/presentation/main/main_screen.dart';
import 'package:super_app/features/profile/presentation/profile_screen.dart';
import 'package:super_app/core/presentation/main/shell_page.dart';


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
    
    // Login
    GoRoute(
      name: RouteName.login,
      path: '/${RouteName.login}',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: RouteName.signup,
      path: '/${RouteName.signup}',
      builder: (context, state) =>  SignupScreen(),
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
              builder: (context, state) => const MainScreen(),
              routes: const [
               
              ],
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
      builder: (context, state) => PropertyDetailScreen(property: state.extra as Property),
    ),
    GoRoute(
      name: RouteName.availableProperties,
      path: '/${RouteName.availableProperties}',
      builder: (context, state) => const AvailablePropertiesScreen(),
    ),
   

     
   
  ],
);
