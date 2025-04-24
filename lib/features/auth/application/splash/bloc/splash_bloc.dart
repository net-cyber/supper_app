import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/auth/application/splash/bloc/splash_event.dart';
import 'package:super_app/features/auth/application/splash/bloc/splash_state.dart';
import 'package:super_app/features/auth/domain/user/user_service.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<CheckUserStatus>(_onCheckUserStatus);
  }

  Future<void> _onCheckUserStatus(
    CheckUserStatus event, 
    Emitter<SplashState> emit,
  ) async {
    log('SplashBloc: Starting _onCheckUserStatus');
    emit(state.copyWith(isLoading: true));
    
    // Add timeout to prevent indefinite loading
    bool timeoutOccurred = false;
    Timer? timeoutTimer;
    
    timeoutTimer = Timer(const Duration(seconds: 8), () {
      timeoutOccurred = true;
      log('SplashBloc: TIMEOUT occurred! Navigating to login screen as fallback');
      emit(state.copyWith(
        isLoading: false, 
        isError: false, 
        routeName: RouteName.login
      ));
    });
    
    try {
      log('SplashBloc: Trying to get UserService from dependency injection');
      final userService = getIt<UserService>();
      log('SplashBloc: Successfully got UserService');
      
      log('SplashBloc: Checking if user is logged in');
      final isLoggedIn = userService.isLoggedIn();
      log('SplashBloc: Checking if first time opening app');
      final isFirstTime = userService.isFirstTimeOpeningApp();
      
      log('SplashBloc: isLoggedIn: $isLoggedIn');
      log('SplashBloc: isFirstTime: $isFirstTime');
      
      // Cancel timeout as we've successfully completed checks
      if (timeoutTimer != null && timeoutTimer.isActive) {
        timeoutTimer.cancel();
      }
      
      // Only proceed if timeout hasn't occurred
      if (!timeoutOccurred) {
        // If first time opening app, navigate to onboarding screen
        if (isFirstTime) {
          log('SplashBloc: Navigating to onboarding screen');
          emit(state.copyWith(isLoading: false, routeName: RouteName.onboarding));
          return;
        }
        // If logged in, navigate to main screen
        if (isLoggedIn) {
          log('SplashBloc: Navigating to main screen');
          emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.mainScreen));
          return;
        }
        // If not logged in, navigate to login screen
        if (!isLoggedIn) {
          log('SplashBloc: Navigating to login screen');
          emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.login));
        }
      }
    } catch (e) {
      log('SplashBloc: ERROR in _onCheckUserStatus: $e');
      
      // Cancel timeout as we've encountered an error
      if (timeoutTimer != null && timeoutTimer.isActive) {
        timeoutTimer.cancel();
      }
      
      // Only proceed if timeout hasn't occurred
      if (!timeoutOccurred) {
        log('SplashBloc: Navigating to login screen due to error');
        emit(state.copyWith(
          isLoading: false, 
          isError: true,
          routeName: RouteName.login  // Navigate to login on error
        ));
      }
    }
  }
} 