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
    emit(state.copyWith(isLoading: true));
    try {
      final userService = getIt<UserService>();
      final isLoggedIn = userService.isLoggedIn();
      final isFirstTime = userService.isFirstTimeOpeningApp();
      log('isLoggedIn: $isLoggedIn');
      log('isFirstTime: $isFirstTime');
      // If first time opening app, navigate to onboarding screen
      if (!isFirstTime) {
        emit(state.copyWith(isLoading: false, routeName: RouteName.onboarding));
        return;
      }
      // If logged in, navigate to main screen
      if (isLoggedIn) {
        emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.mainScreen));
        return;
      }
      // If not logged in, navigate to login screen
      if (!isLoggedIn) {
        emit(state.copyWith(isLoading: false, isError: false, routeName: RouteName.login));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
      
    // Uncomment this when you want to implement the actual token check logic
    // try {
    //   final token = LocalStorage.instance.getAccessToken();
    //   log('token: $token');
    //   
    //   if (token != null) {
    //     log('token is not null');
    //     // Token exists, user is logged in
    //     emit(state.copyWith(isLoading: false));
    //   } else {
    //     log('token is null');
    //     // No token, user needs to log in
    //     emit(state.copyWith(isLoading: false));
    //   }
    // } catch (e) {
    //   emit(state.copyWith(isError: true, isLoading: false));
    // }
  }
} 