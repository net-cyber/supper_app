import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/features/auth/domain/value_objects.dart';
import 'package:super_app/features/auth/application/login/bloc/login_event.dart';
import 'package:super_app/features/auth/application/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(
    LoginState(
      email: EmailAddress(''),
      password: Password(''),
    ),
  ) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ToggleShowPassword>(_onToggleShowPassword);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: EmailAddress(event.email.trim()),
    ),);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: Password(event.password.trim()),
    ),);
  }

  void _onToggleShowPassword(ToggleShowPassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
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
      
      emit(state.copyWith(isLoading: true));
      
      // Here you would typically add authentication logic
      // For now, we'll just navigate to the main screen as in the original code
    } else {
      // Handle no connectivity case
      // Note: The 'mounted' check is handled differently in Bloc
      // You'll need to handle this in the UI
    }
  }
} 