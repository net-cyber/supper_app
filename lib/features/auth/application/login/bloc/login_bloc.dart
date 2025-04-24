import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/core/value_object/value_objects.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/auth/application/login/bloc/login_event.dart';
import 'package:super_app/features/auth/application/login/bloc/login_state.dart';
import 'package:super_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository)
      : super(
          LoginState(
            username: Username(''),
            password: Password(''),
          ),
        ) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ToggleShowPassword>(_onToggleShowPassword);
    on<LoginSubmitted>(_onLoginSubmitted);
  }
  final AuthRepository _authRepository;

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        username: Username(event.username.trim()),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: Password(event.password.trim()),
      ),
    );
  }

  void _onToggleShowPassword(
      ToggleShowPassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    final connected = await AppConnectivity.connectivity();

    if (connected) {
      if (!state.username.isValid()) {
        emit(state.copyWith(showErrorMessages: true));
        return;
      }

      if (!state.password.isValid()) {
        emit(state.copyWith(showErrorMessages: true));
        return;
      }

      emit(state.copyWith(isLoading: true));

      // Extract username from email for API compatibility
      final username = state.username.value.getOrElse(() => '');
      final password = state.password.value.getOrElse(() => '');

      final result = await _authRepository.login(username, password);

      await result.fold(
        (failure) async {
          // Extract just the error message
          final errorMessage = NetworkExceptions.getRawErrorMessage(failure);
          
          // For debugging
          print('Error message: $errorMessage');
          
          emit(state.copyWith(
            isLoading: false,
            isLoginError: true,
            errorMessage: errorMessage,
          ));
        },
        (success) async {
          // Reset AccountsBloc to clear previous user's data first
          getIt<AccountsBloc>().add(const AccountsEvent.resetAccounts());
          
          // Store tokens
          await LocalStorage.instance.setAccessToken(success.access_token);
          await LocalStorage.instance.setRefreshToken(success.refresh_token);

          // Store user data
          await LocalStorage.instance.setUserData(success.user.toJson());

          // Trigger a fetch of the new user's accounts
          getIt<AccountsBloc>().add(const AccountsEvent.fetchAccounts());

          if (!emit.isDone) {
            emit(state.copyWith(
              isLoading: false,
              isLoginError: false,
            ));
          }
        },
      );
    } else {
      emit(state.copyWith(
        isLoading: false,
        isLoginError: true,
        errorMessage: "No internet connection. Please check your network.",
      ));
    }
  }
}