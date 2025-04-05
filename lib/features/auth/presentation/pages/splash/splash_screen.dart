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

import '../../../../../core/router/route_name.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final splashBloc = SplashBloc();
        Future.delayed(
          const Duration(milliseconds: 1500),
          () => splashBloc.add(const SplashEvent.checkUserStatus()),
        );
        return splashBloc;
      },
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (!state.isLoading && !state.isError) {
            context.goNamed(state.routeName!);
          }
          
          if (state.isError) {
            // Handle error state
            // Show error message or retry option
            
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
