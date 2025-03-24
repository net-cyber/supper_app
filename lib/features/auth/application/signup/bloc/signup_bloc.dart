import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/features/auth/domain/value_objects.dart';

import 'package:super_app/features/auth/application/signup/bloc/signup_event.dart';
import 'package:super_app/features/auth/application/signup/bloc/signup_state.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(
    SignupState(
      email: EmailAddress(''),
      password: Password(''),
      confirmPassword: ConfirmPassword('', ''),
      fullName: FullName(''),
    ),
  ) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<CountryChanged>(_onCountryChanged);
    on<ToggleShowPassword>(_onToggleShowPassword);
    on<ToggleShowConfirmPassword>(_onToggleShowConfirmPassword);
    on<TermsAcceptedChanged>(_onTermsAcceptedChanged);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(
      email: EmailAddress(event.email.trim()),
    ),);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    final password = Password(event.password.trim());
    emit(state.copyWith(
      password: password,
      // Update confirmPassword with the new password value
      confirmPassword: ConfirmPassword(
        state.confirmPassword.getOrCrash(), 
        password.getOrCrash(),
      ),
    ),);
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(
      confirmPassword: ConfirmPassword(
        event.confirmPassword.trim(), 
        state.password.getOrCrash(),
      ),
    ),);
  }

  void _onFullNameChanged(FullNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(
      fullName: FullName(event.fullName.trim()),
    ),);
  }

  void _onCountryChanged(CountryChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(
      country: event.country,
    ),);
  }

  void _onToggleShowPassword(ToggleShowPassword event, Emitter<SignupState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onToggleShowConfirmPassword(ToggleShowConfirmPassword event, Emitter<SignupState> emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  void _onTermsAcceptedChanged(TermsAcceptedChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(termsAccepted: event.accepted));
  }

  Future<void> _onSignupSubmitted(SignupSubmitted event, Emitter<SignupState> emit) async {
    final connected = await AppConnectivity.connectivity();
    
    if (connected) {
      if (!state.email.isValid()) {
        emit(state.copyWith(showErrorMessages: true));
        return;
      }
      
      if (!state.password.isValid()) {
        emit(state.copyWith(showErrorMessages: true));
        return;
      }
      
      if (state.password.getOrCrash() != state.confirmPassword.getOrCrash()) {
        emit(state.copyWith(showErrorMessages: true));
        return;
      }
      
      if (state.fullName.value.isLeft()) {
        emit(state.copyWith(showErrorMessages: true));
        return;
      }
      
      if (state.country.isEmpty) {
        emit(state.copyWith(showErrorMessages: true));
        return;
      }
      
      if (!state.termsAccepted) {
        // Terms not accepted, don't proceed
        return;
      }
      
      emit(state.copyWith(isLoading: true));
      
      // TODO: Implement signup logic
      // For now, we'll just simulate a successful signup
      
      // After successful signup, you might want to navigate to the main screen
      // This would be handled in the UI layer using BlocListener
    }
    // The connectivity error handling will be done in the UI
  }
} 