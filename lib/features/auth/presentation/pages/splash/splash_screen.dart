import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:super_app/features/auth/application/splash/bloc/splash_bloc.dart';
import 'package:super_app/features/auth/application/splash/bloc/splash_event.dart';
import 'package:super_app/features/auth/application/splash/bloc/splash_state.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/presentation/widgets/loading.dart';

import 'package:super_app/core/router/route_name.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final splashBloc = SplashBloc();
        log('SplashPage: Created SplashBloc');
        
        // Add a failsafe timer to navigate to login after a delay
        Future.delayed(
          const Duration(seconds: 10),
          () {
            log('SplashPage: Failsafe timer triggered');
            context.goNamed(RouteName.login);
          },
        );
        
        // Trigger the check user status event after showing splash for a short time
        Future.delayed(
          const Duration(milliseconds: 1500),
          () {
            log('SplashPage: Triggering checkUserStatus event');
            splashBloc.add(const SplashEvent.checkUserStatus());
          },
        );
        
        return splashBloc;
      },
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          log('SplashPage: State changed - isLoading: ${state.isLoading}, isError: ${state.isError}, routeName: ${state.routeName}');
          
          // If we have a route name and either we're done loading or there's an error, navigate
          if (state.routeName != null) {
            log('SplashPage: Navigating to ${state.routeName}');
            context.goNamed(state.routeName!);
          }
          
          if (state.isError) {
            log('SplashPage: Error state detected');
            // Navigate to login screen on error
            context.goNamed(RouteName.login);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppConstants.gohbetochLogoHorizontal,
                      width: 200.w,
                      height: 200.h,
                    ),
                    SizedBox(height: 24.h),
                    const LoadingWidget(),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 48.h,
                child: Text(
                  AppConstants.conpanySlogan,
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
