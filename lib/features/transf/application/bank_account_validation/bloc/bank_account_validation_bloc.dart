import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/bank_account_validation/bank_account_validation.dart';
import 'package:super_app/features/transf/domain/repositories/bank_account_validation_repository.dart';

part 'bank_account_validation_event.dart';
part 'bank_account_validation_state.dart';
part 'bank_account_validation_bloc.freezed.dart';

@injectable
class BankAccountValidationBloc
    extends Bloc<BankAccountValidationEvent, BankAccountValidationState> {
  final BankAccountValidationRepository _repository;

  BankAccountValidationBloc(this._repository)
      : super(BankAccountValidationState.initial()) {
    on<ValidateBankAccount>(_onValidateBankAccount);
    on<ResetBankAccountValidation>(_onResetBankAccountValidation);
    on<SetBankAccountValidationError>(_onSetBankAccountValidationError);
  }

  Future<void> _onValidateBankAccount(
      ValidateBankAccount event, Emitter<BankAccountValidationState> emit) async {
    log('BankAccountValidationBloc: Validating bank account - bankCode: ${event.bankCode}, accountNumber: ${event.accountNumber}');
    
    emit(state.copyWith(
      isLoading: true,
      isValid: false,
      hasError: false,
      errorMessage: '',
    ));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    if (!hasConnectivity) {
      log('BankAccountValidationBloc: No internet connection');
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: 'No internet connection. Please check your network.',
      ));
      return;
    }

    try {
      final result = await _repository.validateBankAccount(
        bankCode: event.bankCode,
        accountNumber: event.accountNumber,
      );

      result.fold(
        (failure) {
          log('BankAccountValidationBloc: Bank account validation failed: ${failure.toString()}');
          emit(state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: NetworkExceptions.getRawErrorMessage(failure),
          ));
        },
        (validation) {
          log('BankAccountValidationBloc: Bank account validation result - found: ${validation.found}, accountName: ${validation.accountName}');
          
          if (validation.found) {
            emit(state.copyWith(
              isLoading: false,
              isValid: true,
              validationResult: validation,
              hasError: false,
              errorMessage: '',
            ));
          } else {
            emit(state.copyWith(
              isLoading: false,
              isValid: false,
              validationResult: validation,
              hasError: true,
              errorMessage: 'Account not found. Please check the account number and try again.',
            ));
          }
        },
      );
    } catch (e) {
      log('BankAccountValidationBloc: Unexpected error: $e');
      emit(state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: 'An unexpected error occurred: $e',
      ));
    }
  }

  void _onResetBankAccountValidation(
      ResetBankAccountValidation event, Emitter<BankAccountValidationState> emit) {
    log('BankAccountValidationBloc: Resetting bank account validation');
    emit(BankAccountValidationState.initial());
  }

  void _onSetBankAccountValidationError(
      SetBankAccountValidationError event, Emitter<BankAccountValidationState> emit) {
    log('BankAccountValidationBloc: Setting error - ${event.message}');
    emit(state.copyWith(
      isLoading: false,
      hasError: true,
      errorMessage: event.message,
    ));
  }
} 