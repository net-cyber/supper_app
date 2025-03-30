import 'package:equatable/equatable.dart';
import 'package:super_app/features/mobileTopup/application/mobile_topup/bloc/mobile_topup_state.dart';

abstract class MobileTopupEvent extends Equatable {
  const MobileTopupEvent();

  @override
  List<Object> get props => [];
}

class OperatorSelected extends MobileTopupEvent {
  final String operatorName;
  final String operatorLogo;

  const OperatorSelected({
    required this.operatorName,
    required this.operatorLogo,
  });

  @override
  List<Object> get props => [operatorName, operatorLogo];
}

class PhoneNumberChanged extends MobileTopupEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class TopupTypeChanged extends MobileTopupEvent {
  final TopupType topupType;

  const TopupTypeChanged(this.topupType);

  @override
  List<Object> get props => [topupType];
}

class AmountSelected extends MobileTopupEvent {
  final double amount;

  const AmountSelected(this.amount);

  @override
  List<Object> get props => [amount];
}

class ValidatePhoneNumber extends MobileTopupEvent {
  const ValidatePhoneNumber();
}

class SubmitTopupRequest extends MobileTopupEvent {
  const SubmitTopupRequest();

  @override
  List<Object> get props => [];
}

class ResetTopupState extends MobileTopupEvent {
  const ResetTopupState();
}
