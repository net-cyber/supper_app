import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_app/features/mobileTopup/application/mobile_topup/bloc/mobile_topup_event.dart';
import 'package:super_app/features/mobileTopup/application/mobile_topup/bloc/mobile_topup_state.dart';

class MobileTopupBloc extends Bloc<MobileTopupEvent, MobileTopupState> {
  MobileTopupBloc() : super(const MobileTopupState()) {
    on<OperatorSelected>(_onOperatorSelected);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<TopupTypeChanged>(_onTopupTypeChanged);
    on<AmountSelected>(_onAmountSelected);
    on<ValidatePhoneNumber>(_onValidatePhoneNumber);
    on<SubmitTopupRequest>(_onSubmitTopupRequest);
    on<ResetTopupState>(_onResetTopupState);
  }

  void _onOperatorSelected(
    OperatorSelected event,
    Emitter<MobileTopupState> emit,
  ) {
    emit(state.copyWith(
      operatorName: event.operatorName,
      operatorLogo: event.operatorLogo,
    ));
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<MobileTopupState> emit,
  ) {
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      isPhoneValid: _validatePhoneNumber(event.phoneNumber),
    ));
  }

  void _onTopupTypeChanged(
    TopupTypeChanged event,
    Emitter<MobileTopupState> emit,
  ) {
    emit(state.copyWith(
      topupType: event.topupType,
    ));
  }

  void _onAmountSelected(
    AmountSelected event,
    Emitter<MobileTopupState> emit,
  ) {
    emit(state.copyWith(
      amount: event.amount,
    ));
  }

  void _onValidatePhoneNumber(
    ValidatePhoneNumber event,
    Emitter<MobileTopupState> emit,
  ) {
    final isValid = _validatePhoneNumber(state.phoneNumber);
    emit(state.copyWith(isPhoneValid: isValid));
  }

  Future<void> _onSubmitTopupRequest(
    SubmitTopupRequest event,
    Emitter<MobileTopupState> emit,
  ) async {
    if (!state.isPhoneValid) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid phone number',
      ));
      return;
    }

    if (state.amount <= 0) {
      emit(state.copyWith(
        errorMessage: 'Please select a valid amount',
      ));
      return;
    }

    emit(state.copyWith(
      isSubmitting: true,
      errorMessage: null,
    ));

    try {
      // Here you would integrate with your repository to submit the top-up request
      // For now, we'll just simulate a successful request after a delay
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to process mobile top-up request',
      ));
    }
  }

  void _onResetTopupState(
    ResetTopupState event,
    Emitter<MobileTopupState> emit,
  ) {
    emit(const MobileTopupState());
  }

  bool _validatePhoneNumber(String phoneNumber) {
    // Simple validation for Ethiopian phone numbers
    // A proper implementation would have more robust validation
    return phoneNumber.length >= 9;
  }
}
