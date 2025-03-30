import 'package:equatable/equatable.dart';

enum TopupType { self, others }

class MobileTopupState extends Equatable {
  final String phoneNumber;
  final String operatorName;
  final String operatorLogo;
  final TopupType topupType;
  final double amount;
  final bool isPhoneValid;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const MobileTopupState({
    this.phoneNumber = '',
    this.operatorName = '',
    this.operatorLogo = '',
    this.topupType = TopupType.self,
    this.amount = 0.0,
    this.isPhoneValid = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  MobileTopupState copyWith({
    String? phoneNumber,
    String? operatorName,
    String? operatorLogo,
    TopupType? topupType,
    double? amount,
    bool? isPhoneValid,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return MobileTopupState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      operatorName: operatorName ?? this.operatorName,
      operatorLogo: operatorLogo ?? this.operatorLogo,
      topupType: topupType ?? this.topupType,
      amount: amount ?? this.amount,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        operatorName,
        operatorLogo,
        topupType,
        amount,
        isPhoneValid,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}
