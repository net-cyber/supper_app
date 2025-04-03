import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/auth/domain/repositories/auth_repository.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';
part 'otp_verification_bloc.freezed.dart';

@injectable
class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final AuthRepository _authRepository;
  
  OtpVerificationBloc(this._authRepository) 
      : super(OtpVerificationState.initial()) {
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<VerifyOtpSubmitted>(_onVerifyOtpSubmitted);
    on<ResendOtpRequested>(_onResendOtpRequested);
    on<PhoneNumberSet>(_onPhoneNumberSet);
  }

  void _onOtpCodeChanged(OtpCodeChanged event, Emitter<OtpVerificationState> emit) {
    emit(state.copyWith(
      otpCode: event.otpCode,
      verificationError: false,
      errorMessage: '',
    ));
  }

  void _onPhoneNumberSet(PhoneNumberSet event, Emitter<OtpVerificationState> emit) {
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
    ));
  }

  Future<void> _onVerifyOtpSubmitted(VerifyOtpSubmitted event, Emitter<OtpVerificationState> emit) async {
    // TODO: Implement actual OTP verification
    // For now, we'll consider it a success if it's 6 digits
    if (state.otpCode.length != 6) {
      emit(state.copyWith(
        verificationError: true,
        errorMessage: 'Please enter a valid 6-digit code',
      ));
      return;
    }

    emit(state.copyWith(isVerifying: true));

    // Simulate API call for now
    await Future.delayed(const Duration(seconds: 1));

    // TODO: Replace with actual verification API call
    emit(state.copyWith(
      isVerifying: false,
      isVerified: true,
    ));
  }

  Future<void> _onResendOtpRequested(ResendOtpRequested event, Emitter<OtpVerificationState> emit) async {
    final connected = await AppConnectivity.connectivity();
    
    if (!connected) {
      emit(state.copyWith(
        resendError: true,
        errorMessage: 'No internet connection. Please check your network.',
      ));
      return;
    }
    
    emit(state.copyWith(isResending: true));
    
    try {
      final result = await _authRepository.sendVerificationCode(state.phoneNumber);
      
      result.fold(
        (failure) => emit(state.copyWith(
          isResending: false,
          resendError: true,
          errorMessage: NetworkExceptions.getErrorMessage(failure),
        )),
        (response) => emit(state.copyWith(
          isResending: false,
          resendError: false,
          expiresAt: response.expires_at,
          resendSuccess: true,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        isResending: false,
        resendError: true,
        errorMessage: e.toString(),
      ));
    }
  }
} 