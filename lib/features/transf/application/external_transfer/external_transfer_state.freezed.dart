// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'external_transfer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExternalTransferState {
// Basic state info
  ExternalTransferStatus get status =>
      throw _privateConstructorUsedError; // Bank selection data
  List<Map<String, dynamic>> get banks => throw _privateConstructorUsedError;
  Map<String, dynamic>? get selectedBank =>
      throw _privateConstructorUsedError; // Form inputs
  String get accountNumberInput => throw _privateConstructorUsedError;
  String get amountInput => throw _privateConstructorUsedError;
  String get reasonInput =>
      throw _privateConstructorUsedError; // Validated data
  BankAccount? get validatedAccount => throw _privateConstructorUsedError;
  double? get calculatedFee =>
      throw _privateConstructorUsedError; // Response data
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get transactionId =>
      throw _privateConstructorUsedError; // Error handling
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalTransferStateCopyWith<ExternalTransferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalTransferStateCopyWith<$Res> {
  factory $ExternalTransferStateCopyWith(ExternalTransferState value,
          $Res Function(ExternalTransferState) then) =
      _$ExternalTransferStateCopyWithImpl<$Res, ExternalTransferState>;
  @useResult
  $Res call(
      {ExternalTransferStatus status,
      List<Map<String, dynamic>> banks,
      Map<String, dynamic>? selectedBank,
      String accountNumberInput,
      String amountInput,
      String reasonInput,
      BankAccount? validatedAccount,
      double? calculatedFee,
      bool isLoading,
      bool isSuccess,
      String? transactionId,
      String? errorMessage});
}

/// @nodoc
class _$ExternalTransferStateCopyWithImpl<$Res,
        $Val extends ExternalTransferState>
    implements $ExternalTransferStateCopyWith<$Res> {
  _$ExternalTransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? banks = null,
    Object? selectedBank = freezed,
    Object? accountNumberInput = null,
    Object? amountInput = null,
    Object? reasonInput = null,
    Object? validatedAccount = freezed,
    Object? calculatedFee = freezed,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? transactionId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExternalTransferStatus,
      banks: null == banks
          ? _value.banks
          : banks // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      selectedBank: freezed == selectedBank
          ? _value.selectedBank
          : selectedBank // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      accountNumberInput: null == accountNumberInput
          ? _value.accountNumberInput
          : accountNumberInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _value.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      reasonInput: null == reasonInput
          ? _value.reasonInput
          : reasonInput // ignore: cast_nullable_to_non_nullable
              as String,
      validatedAccount: freezed == validatedAccount
          ? _value.validatedAccount
          : validatedAccount // ignore: cast_nullable_to_non_nullable
              as BankAccount?,
      calculatedFee: freezed == calculatedFee
          ? _value.calculatedFee
          : calculatedFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExternalTransferStateImplCopyWith<$Res>
    implements $ExternalTransferStateCopyWith<$Res> {
  factory _$$ExternalTransferStateImplCopyWith(
          _$ExternalTransferStateImpl value,
          $Res Function(_$ExternalTransferStateImpl) then) =
      __$$ExternalTransferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ExternalTransferStatus status,
      List<Map<String, dynamic>> banks,
      Map<String, dynamic>? selectedBank,
      String accountNumberInput,
      String amountInput,
      String reasonInput,
      BankAccount? validatedAccount,
      double? calculatedFee,
      bool isLoading,
      bool isSuccess,
      String? transactionId,
      String? errorMessage});
}

/// @nodoc
class __$$ExternalTransferStateImplCopyWithImpl<$Res>
    extends _$ExternalTransferStateCopyWithImpl<$Res,
        _$ExternalTransferStateImpl>
    implements _$$ExternalTransferStateImplCopyWith<$Res> {
  __$$ExternalTransferStateImplCopyWithImpl(_$ExternalTransferStateImpl _value,
      $Res Function(_$ExternalTransferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? banks = null,
    Object? selectedBank = freezed,
    Object? accountNumberInput = null,
    Object? amountInput = null,
    Object? reasonInput = null,
    Object? validatedAccount = freezed,
    Object? calculatedFee = freezed,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? transactionId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ExternalTransferStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExternalTransferStatus,
      banks: null == banks
          ? _value._banks
          : banks // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      selectedBank: freezed == selectedBank
          ? _value._selectedBank
          : selectedBank // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      accountNumberInput: null == accountNumberInput
          ? _value.accountNumberInput
          : accountNumberInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _value.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      reasonInput: null == reasonInput
          ? _value.reasonInput
          : reasonInput // ignore: cast_nullable_to_non_nullable
              as String,
      validatedAccount: freezed == validatedAccount
          ? _value.validatedAccount
          : validatedAccount // ignore: cast_nullable_to_non_nullable
              as BankAccount?,
      calculatedFee: freezed == calculatedFee
          ? _value.calculatedFee
          : calculatedFee // ignore: cast_nullable_to_non_nullable
              as double?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ExternalTransferStateImpl extends _ExternalTransferState {
  const _$ExternalTransferStateImpl(
      {required this.status,
      final List<Map<String, dynamic>> banks = const [],
      final Map<String, dynamic>? selectedBank,
      this.accountNumberInput = '',
      this.amountInput = '',
      this.reasonInput = '',
      this.validatedAccount,
      this.calculatedFee,
      this.isLoading = false,
      this.isSuccess = false,
      this.transactionId,
      this.errorMessage})
      : _banks = banks,
        _selectedBank = selectedBank,
        super._();

// Basic state info
  @override
  final ExternalTransferStatus status;
// Bank selection data
  final List<Map<String, dynamic>> _banks;
// Bank selection data
  @override
  @JsonKey()
  List<Map<String, dynamic>> get banks {
    if (_banks is EqualUnmodifiableListView) return _banks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_banks);
  }

  final Map<String, dynamic>? _selectedBank;
  @override
  Map<String, dynamic>? get selectedBank {
    final value = _selectedBank;
    if (value == null) return null;
    if (_selectedBank is EqualUnmodifiableMapView) return _selectedBank;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Form inputs
  @override
  @JsonKey()
  final String accountNumberInput;
  @override
  @JsonKey()
  final String amountInput;
  @override
  @JsonKey()
  final String reasonInput;
// Validated data
  @override
  final BankAccount? validatedAccount;
  @override
  final double? calculatedFee;
// Response data
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  final String? transactionId;
// Error handling
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ExternalTransferState(status: $status, banks: $banks, selectedBank: $selectedBank, accountNumberInput: $accountNumberInput, amountInput: $amountInput, reasonInput: $reasonInput, validatedAccount: $validatedAccount, calculatedFee: $calculatedFee, isLoading: $isLoading, isSuccess: $isSuccess, transactionId: $transactionId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalTransferStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._banks, _banks) &&
            const DeepCollectionEquality()
                .equals(other._selectedBank, _selectedBank) &&
            (identical(other.accountNumberInput, accountNumberInput) ||
                other.accountNumberInput == accountNumberInput) &&
            (identical(other.amountInput, amountInput) ||
                other.amountInput == amountInput) &&
            (identical(other.reasonInput, reasonInput) ||
                other.reasonInput == reasonInput) &&
            (identical(other.validatedAccount, validatedAccount) ||
                other.validatedAccount == validatedAccount) &&
            (identical(other.calculatedFee, calculatedFee) ||
                other.calculatedFee == calculatedFee) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_banks),
      const DeepCollectionEquality().hash(_selectedBank),
      accountNumberInput,
      amountInput,
      reasonInput,
      validatedAccount,
      calculatedFee,
      isLoading,
      isSuccess,
      transactionId,
      errorMessage);

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalTransferStateImplCopyWith<_$ExternalTransferStateImpl>
      get copyWith => __$$ExternalTransferStateImplCopyWithImpl<
          _$ExternalTransferStateImpl>(this, _$identity);
}

abstract class _ExternalTransferState extends ExternalTransferState {
  const factory _ExternalTransferState(
      {required final ExternalTransferStatus status,
      final List<Map<String, dynamic>> banks,
      final Map<String, dynamic>? selectedBank,
      final String accountNumberInput,
      final String amountInput,
      final String reasonInput,
      final BankAccount? validatedAccount,
      final double? calculatedFee,
      final bool isLoading,
      final bool isSuccess,
      final String? transactionId,
      final String? errorMessage}) = _$ExternalTransferStateImpl;
  const _ExternalTransferState._() : super._();

// Basic state info
  @override
  ExternalTransferStatus get status; // Bank selection data
  @override
  List<Map<String, dynamic>> get banks;
  @override
  Map<String, dynamic>? get selectedBank; // Form inputs
  @override
  String get accountNumberInput;
  @override
  String get amountInput;
  @override
  String get reasonInput; // Validated data
  @override
  BankAccount? get validatedAccount;
  @override
  double? get calculatedFee; // Response data
  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  String? get transactionId; // Error handling
  @override
  String? get errorMessage;

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalTransferStateImplCopyWith<_$ExternalTransferStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
