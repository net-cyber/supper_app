import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/core/application/app/bloc/app_bloc.dart';
import 'package:super_app/core/router/router.dart';
import 'package:super_app/core/router/slide_transition.dart';
import 'package:super_app/core/theme/app_theme.dart';
import 'package:super_app/l10n/l10n.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return BlocProvider(
      create: (context) => AppBloc(),
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        theme: AppTheme.lightTheme().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomTransitionBuilder(),
            },
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        themeMode: context.read<AppBloc>().state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        
        darkTheme: AppTheme.darkTheme().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomTransitionBuilder(),
            },
          ),
        ),
      ),
    );
  }
}
