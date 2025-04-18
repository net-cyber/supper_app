import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/core/value_object/value_objects.dart';
import 'package:super_app/features/auth/application/registration/bloc/registration_event.dart';
import 'package:super_app/features/auth/application/registration/bloc/registration_state.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  RegistrationBloc(this._authRepository) 
    : super(RegistrationState(
        userName: UserName(''),
        fullName: FullName(''),
        phoneNumber: PhoneNumber(''),
        password: Password(''),
        confirmPassword: ConfirmPassword('', ''),
        termsAcceptance: TermsAcceptance(false),
        profilePhoto: ProfilePhoto(null),
      )) {
    on<UserNameChanged>(_onUserNameChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<TermsAcceptedChanged>(_onTermsAcceptedChanged);
    on<ProfilePhotoChanged>(_onProfilePhotoChanged);
    on<ToggleShowPassword>(_onToggleShowPassword);
    on<ToggleShowConfirmPassword>(_onToggleShowConfirmPassword);
    on<RegistrationSubmitted>(_onRegistrationSubmitted);
  }
  final AuthRepository _authRepository;

  void _onUserNameChanged(UserNameChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
      userName: UserName(event.userName.trim()),
      showErrorMessages: false,
      isRegistrationError: false,
    ),);
  }

  void _onFullNameChanged(FullNameChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
      fullName: FullName(event.fullName.trim()),
      showErrorMessages: false,
      isRegistrationError: false,
    ),);
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
      phoneNumber: PhoneNumber(event.phoneNumber.trim()),
      showErrorMessages: false,
      isRegistrationError: false,
    ),);
  }

  void _onProfilePhotoChanged(ProfilePhotoChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
      profilePhoto: ProfilePhoto(event.photoPath),
      showErrorMessages: false,
      isRegistrationError: false,
    ),);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegistrationState> emit) {
    final password = event.password.trim();
    final passwordObj = Password(password);
    
    // Calculate password strength
    var strength = 0.0;
    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp('[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp('[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.25;
    
    emit(state.copyWith(
      password: passwordObj,
      confirmPassword: ConfirmPassword(
        state.confirmPassword.value.getOrElse(() => ''), 
        password,
      ),
      passwordStrength: strength,
      showErrorMessages: false,
      isRegistrationError: false,
    ),);
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
      confirmPassword: ConfirmPassword(
        event.confirmPassword.trim(), 
        state.password.value.getOrElse(() => ''),
      ),
      showErrorMessages: false,
      isRegistrationError: false,
      ),
    );
  }

  void _onTermsAcceptedChanged(TermsAcceptedChanged event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
      termsAcceptance: TermsAcceptance(event.accepted),
      showErrorMessages: false,
      isRegistrationError: false,
    ),);
  }

  void _onToggleShowPassword(ToggleShowPassword event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onToggleShowConfirmPassword(ToggleShowConfirmPassword event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  Future<void> _onRegistrationSubmitted(RegistrationSubmitted event, Emitter<RegistrationState> emit) async {
    final connected = await AppConnectivity.connectivity();
    
    if (!connected) {
      emit(state.copyWith(
        isRegistrationError: true,
        errorMessage: 'No internet connection. Please check your network.',
      ),);
      return;
    }
    
    if (!state.isFormValid) {
      emit(state.copyWith(showErrorMessages: true));
      return;
    }
    
    emit(state.copyWith(isLoading: true));
    
    final registration = Registration(
      userName: state.userName,
      fullName: state.fullName,
      phoneNumber: state.phoneNumber,
      password: state.password,
      confirmPassword: state.confirmPassword,
      termsAcceptance: state.termsAcceptance,
      profilePhoto: state.profilePhoto,
    );
    
    final result = await _authRepository.register(registration);
    
    // Handle the first result
    if (result.isLeft()) {
      final failure = result.fold(
        (l) => l,
        (r) => null,
      );
      if (!emit.isDone) {
        emit(state.copyWith(
          isLoading: false,
          isRegistrationError: true,
          errorMessage: NetworkExceptions.getErrorMessage(failure!),
        ),);
      }
      return;
    }
    
    // After successful registration, send verification code
    final response = result.fold((l) => null, (r) => r);
    final phoneNumber = registration.phoneNumber.value.getOrElse(() => '');
    final verificationResult = await _authRepository.sendVerificationCode(phoneNumber);
    
    // Before final emit, check if the emitter is still active
    if (!emit.isDone) {
      final verificationResponse = verificationResult.fold((l) => null, (r) => r);
      emit(state.copyWith(
        isLoading: false,
        verificationSent: verificationResult.isRight(),
        registrationResponse: response,
        verificationResponse: verificationResponse,
        isRegistrationError: verificationResult.isLeft(),
        errorMessage: verificationResult.isLeft() 
          ? NetworkExceptions.getErrorMessage(verificationResult.fold((l) => l, (r) => null)!)
          : '',
      ),);
    }
  }
} 