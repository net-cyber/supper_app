// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_transfer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletTransferState {
// Basic state info
  WalletTransferStatus get status =>
      throw _privateConstructorUsedError; // Form inputs
  String get phoneNumberInput => throw _privateConstructorUsedError;
  String get amountInput => throw _privateConstructorUsedError;
  String get reasonInput =>
      throw _privateConstructorUsedError; // Wallet and provider data
  List<Map<String, dynamic>> get providers =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get selectedProvider =>
      throw _privateConstructorUsedError; // Validated data
  WalletAccount? get validatedWallet => throw _privateConstructorUsedError;
  double? get calculatedFee =>
      throw _privateConstructorUsedError; // Response data
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get transactionId =>
      throw _privateConstructorUsedError; // Error handling
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of WalletTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletTransferStateCopyWith<WalletTransferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletTransferStateCopyWith<$Res> {
  factory $WalletTransferStateCopyWith(
          WalletTransferState value, $Res Function(WalletTransferState) then) =
      _$WalletTransferStateCopyWithImpl<$Res, WalletTransferState>;
  @useResult
  $Res call(
      {WalletTransferStatus status,
      String phoneNumberInput,
      String amountInput,
      String reasonInput,
      List<Map<String, dynamic>> providers,
      Map<String, dynamic>? selectedProvider,
      WalletAccount? validatedWallet,
      double? calculatedFee,
      bool isLoading,
      bool isSuccess,
      String? transactionId,
      String? errorMessage});
}

/// @nodoc
class _$WalletTransferStateCopyWithImpl<$Res, $Val extends WalletTransferState>
    implements $WalletTransferStateCopyWith<$Res> {
  _$WalletTransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? phoneNumberInput = null,
    Object? amountInput = null,
    Object? reasonInput = null,
    Object? providers = null,
    Object? selectedProvider = freezed,
    Object? validatedWallet = freezed,
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
              as WalletTransferStatus,
      phoneNumberInput: null == phoneNumberInput
          ? _value.phoneNumberInput
          : phoneNumberInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _value.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      reasonInput: null == reasonInput
          ? _value.reasonInput
          : reasonInput // ignore: cast_nullable_to_non_nullable
              as String,
      providers: null == providers
          ? _value.providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      selectedProvider: freezed == selectedProvider
          ? _value.selectedProvider
          : selectedProvider // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      validatedWallet: freezed == validatedWallet
          ? _value.validatedWallet
          : validatedWallet // ignore: cast_nullable_to_non_nullable
              as WalletAccount?,
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
abstract class _$$WalletTransferStateImplCopyWith<$Res>
    implements $WalletTransferStateCopyWith<$Res> {
  factory _$$WalletTransferStateImplCopyWith(_$WalletTransferStateImpl value,
          $Res Function(_$WalletTransferStateImpl) then) =
      __$$WalletTransferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WalletTransferStatus status,
      String phoneNumberInput,
      String amountInput,
      String reasonInput,
      List<Map<String, dynamic>> providers,
      Map<String, dynamic>? selectedProvider,
      WalletAccount? validatedWallet,
      double? calculatedFee,
      bool isLoading,
      bool isSuccess,
      String? transactionId,
      String? errorMessage});
}

/// @nodoc
class __$$WalletTransferStateImplCopyWithImpl<$Res>
    extends _$WalletTransferStateCopyWithImpl<$Res, _$WalletTransferStateImpl>
    implements _$$WalletTransferStateImplCopyWith<$Res> {
  __$$WalletTransferStateImplCopyWithImpl(_$WalletTransferStateImpl _value,
      $Res Function(_$WalletTransferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? phoneNumberInput = null,
    Object? amountInput = null,
    Object? reasonInput = null,
    Object? providers = null,
    Object? selectedProvider = freezed,
    Object? validatedWallet = freezed,
    Object? calculatedFee = freezed,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? transactionId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$WalletTransferStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WalletTransferStatus,
      phoneNumberInput: null == phoneNumberInput
          ? _value.phoneNumberInput
          : phoneNumberInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _value.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      reasonInput: null == reasonInput
          ? _value.reasonInput
          : reasonInput // ignore: cast_nullable_to_non_nullable
              as String,
      providers: null == providers
          ? _value._providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      selectedProvider: freezed == selectedProvider
          ? _value._selectedProvider
          : selectedProvider // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      validatedWallet: freezed == validatedWallet
          ? _value.validatedWallet
          : validatedWallet // ignore: cast_nullable_to_non_nullable
              as WalletAccount?,
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

class _$WalletTransferStateImpl extends _WalletTransferState {
  const _$WalletTransferStateImpl(
      {required this.status,
      this.phoneNumberInput = '',
      this.amountInput = '',
      this.reasonInput = '',
      final List<Map<String, dynamic>> providers = const [],
      final Map<String, dynamic>? selectedProvider,
      this.validatedWallet,
      this.calculatedFee,
      this.isLoading = false,
      this.isSuccess = false,
      this.transactionId,
      this.errorMessage})
      : _providers = providers,
        _selectedProvider = selectedProvider,
        super._();

// Basic state info
  @override
  final WalletTransferStatus status;
// Form inputs
  @override
  @JsonKey()
  final String phoneNumberInput;
  @override
  @JsonKey()
  final String amountInput;
  @override
  @JsonKey()
  final String reasonInput;
// Wallet and provider data
  final List<Map<String, dynamic>> _providers;
// Wallet and provider data
  @override
  @JsonKey()
  List<Map<String, dynamic>> get providers {
    if (_providers is EqualUnmodifiableListView) return _providers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_providers);
  }

  final Map<String, dynamic>? _selectedProvider;
  @override
  Map<String, dynamic>? get selectedProvider {
    final value = _selectedProvider;
    if (value == null) return null;
    if (_selectedProvider is EqualUnmodifiableMapView) return _selectedProvider;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Validated data
  @override
  final WalletAccount? validatedWallet;
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
    return 'WalletTransferState(status: $status, phoneNumberInput: $phoneNumberInput, amountInput: $amountInput, reasonInput: $reasonInput, providers: $providers, selectedProvider: $selectedProvider, validatedWallet: $validatedWallet, calculatedFee: $calculatedFee, isLoading: $isLoading, isSuccess: $isSuccess, transactionId: $transactionId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletTransferStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.phoneNumberInput, phoneNumberInput) ||
                other.phoneNumberInput == phoneNumberInput) &&
            (identical(other.amountInput, amountInput) ||
                other.amountInput == amountInput) &&
            (identical(other.reasonInput, reasonInput) ||
                other.reasonInput == reasonInput) &&
            const DeepCollectionEquality()
                .equals(other._providers, _providers) &&
            const DeepCollectionEquality()
                .equals(other._selectedProvider, _selectedProvider) &&
            (identical(other.validatedWallet, validatedWallet) ||
                other.validatedWallet == validatedWallet) &&
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
      phoneNumberInput,
      amountInput,
      reasonInput,
      const DeepCollectionEquality().hash(_providers),
      const DeepCollectionEquality().hash(_selectedProvider),
      validatedWallet,
      calculatedFee,
      isLoading,
      isSuccess,
      transactionId,
      errorMessage);

  /// Create a copy of WalletTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletTransferStateImplCopyWith<_$WalletTransferStateImpl> get copyWith =>
      __$$WalletTransferStateImplCopyWithImpl<_$WalletTransferStateImpl>(
          this, _$identity);
}

abstract class _WalletTransferState extends WalletTransferState {
  const factory _WalletTransferState(
      {required final WalletTransferStatus status,
      final String phoneNumberInput,
      final String amountInput,
      final String reasonInput,
      final List<Map<String, dynamic>> providers,
      final Map<String, dynamic>? selectedProvider,
      final WalletAccount? validatedWallet,
      final double? calculatedFee,
      final bool isLoading,
      final bool isSuccess,
      final String? transactionId,
      final String? errorMessage}) = _$WalletTransferStateImpl;
  const _WalletTransferState._() : super._();

// Basic state info
  @override
  WalletTransferStatus get status; // Form inputs
  @override
  String get phoneNumberInput;
  @override
  String get amountInput;
  @override
  String get reasonInput; // Wallet and provider data
  @override
  List<Map<String, dynamic>> get providers;
  @override
  Map<String, dynamic>? get selectedProvider; // Validated data
  @override
  WalletAccount? get validatedWallet;
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

  /// Create a copy of WalletTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletTransferStateImplCopyWith<_$WalletTransferStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
