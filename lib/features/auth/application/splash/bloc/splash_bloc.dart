import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:super_app/features/auth/application/splash/bloc/splash_event.dart';
import 'package:super_app/features/auth/application/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<CheckUserStatus>(_onCheckUserStatus);
  }

  Future<void> _onCheckUserStatus(
    CheckUserStatus event, 
    Emitter<SplashState> emit,
  ) async {
    log('getUserStatus');
    emit(state.copyWith(isLoading: true));
    
    await Future.delayed(const Duration(seconds: 3));
    
    // The navigation will be handled in the UI layer
    // We just update the state here
    
    emit(state.copyWith(isLoading: false,));
    
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