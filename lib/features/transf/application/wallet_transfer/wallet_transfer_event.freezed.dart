// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_transfer_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletTransferEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletTransferEventCopyWith<$Res> {
  factory $WalletTransferEventCopyWith(
          WalletTransferEvent value, $Res Function(WalletTransferEvent) then) =
      _$WalletTransferEventCopyWithImpl<$Res, WalletTransferEvent>;
}

/// @nodoc
class _$WalletTransferEventCopyWithImpl<$Res, $Val extends WalletTransferEvent>
    implements $WalletTransferEventCopyWith<$Res> {
  _$WalletTransferEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadWalletProvidersImplCopyWith<$Res> {
  factory _$$LoadWalletProvidersImplCopyWith(_$LoadWalletProvidersImpl value,
          $Res Function(_$LoadWalletProvidersImpl) then) =
      __$$LoadWalletProvidersImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadWalletProvidersImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$LoadWalletProvidersImpl>
    implements _$$LoadWalletProvidersImplCopyWith<$Res> {
  __$$LoadWalletProvidersImplCopyWithImpl(_$LoadWalletProvidersImpl _value,
      $Res Function(_$LoadWalletProvidersImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadWalletProvidersImpl extends LoadWalletProviders {
  const _$LoadWalletProvidersImpl() : super._();

  @override
  String toString() {
    return 'WalletTransferEvent.loadWalletProviders()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadWalletProvidersImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return loadWalletProviders();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return loadWalletProviders?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (loadWalletProviders != null) {
      return loadWalletProviders();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return loadWalletProviders(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return loadWalletProviders?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (loadWalletProviders != null) {
      return loadWalletProviders(this);
    }
    return orElse();
  }
}

abstract class LoadWalletProviders extends WalletTransferEvent {
  const factory LoadWalletProviders() = _$LoadWalletProvidersImpl;
  const LoadWalletProviders._() : super._();
}

/// @nodoc
abstract class _$$SelectWalletProviderImplCopyWith<$Res> {
  factory _$$SelectWalletProviderImplCopyWith(_$SelectWalletProviderImpl value,
          $Res Function(_$SelectWalletProviderImpl) then) =
      __$$SelectWalletProviderImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> provider});
}

/// @nodoc
class __$$SelectWalletProviderImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$SelectWalletProviderImpl>
    implements _$$SelectWalletProviderImplCopyWith<$Res> {
  __$$SelectWalletProviderImplCopyWithImpl(_$SelectWalletProviderImpl _value,
      $Res Function(_$SelectWalletProviderImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? provider = null,
  }) {
    return _then(_$SelectWalletProviderImpl(
      null == provider
          ? _value._provider
          : provider // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$SelectWalletProviderImpl extends SelectWalletProvider {
  const _$SelectWalletProviderImpl(final Map<String, dynamic> provider)
      : _provider = provider,
        super._();

  final Map<String, dynamic> _provider;
  @override
  Map<String, dynamic> get provider {
    if (_provider is EqualUnmodifiableMapView) return _provider;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_provider);
  }

  @override
  String toString() {
    return 'WalletTransferEvent.selectWalletProvider(provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectWalletProviderImpl &&
            const DeepCollectionEquality().equals(other._provider, _provider));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_provider));

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectWalletProviderImplCopyWith<_$SelectWalletProviderImpl>
      get copyWith =>
          __$$SelectWalletProviderImplCopyWithImpl<_$SelectWalletProviderImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return selectWalletProvider(provider);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return selectWalletProvider?.call(provider);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (selectWalletProvider != null) {
      return selectWalletProvider(provider);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return selectWalletProvider(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return selectWalletProvider?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (selectWalletProvider != null) {
      return selectWalletProvider(this);
    }
    return orElse();
  }
}

abstract class SelectWalletProvider extends WalletTransferEvent {
  const factory SelectWalletProvider(final Map<String, dynamic> provider) =
      _$SelectWalletProviderImpl;
  const SelectWalletProvider._() : super._();

  Map<String, dynamic> get provider;

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectWalletProviderImplCopyWith<_$SelectWalletProviderImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberChangedImplCopyWith<$Res> {
  factory _$$PhoneNumberChangedImplCopyWith(_$PhoneNumberChangedImpl value,
          $Res Function(_$PhoneNumberChangedImpl) then) =
      __$$PhoneNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$PhoneNumberChangedImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$PhoneNumberChangedImpl>
    implements _$$PhoneNumberChangedImplCopyWith<$Res> {
  __$$PhoneNumberChangedImplCopyWithImpl(_$PhoneNumberChangedImpl _value,
      $Res Function(_$PhoneNumberChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_$PhoneNumberChangedImpl(
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberChangedImpl extends PhoneNumberChanged {
  const _$PhoneNumberChangedImpl(this.phoneNumber) : super._();

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'WalletTransferEvent.phoneNumberChanged(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberChangedImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      __$$PhoneNumberChangedImplCopyWithImpl<_$PhoneNumberChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return phoneNumberChanged(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return phoneNumberChanged?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return phoneNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return phoneNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberChanged extends WalletTransferEvent {
  const factory PhoneNumberChanged(final String phoneNumber) =
      _$PhoneNumberChangedImpl;
  const PhoneNumberChanged._() : super._();

  String get phoneNumber;

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidatePhoneNumberImplCopyWith<$Res> {
  factory _$$ValidatePhoneNumberImplCopyWith(_$ValidatePhoneNumberImpl value,
          $Res Function(_$ValidatePhoneNumberImpl) then) =
      __$$ValidatePhoneNumberImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ValidatePhoneNumberImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$ValidatePhoneNumberImpl>
    implements _$$ValidatePhoneNumberImplCopyWith<$Res> {
  __$$ValidatePhoneNumberImplCopyWithImpl(_$ValidatePhoneNumberImpl _value,
      $Res Function(_$ValidatePhoneNumberImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ValidatePhoneNumberImpl extends ValidatePhoneNumber {
  const _$ValidatePhoneNumberImpl() : super._();

  @override
  String toString() {
    return 'WalletTransferEvent.validatePhoneNumber()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidatePhoneNumberImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return validatePhoneNumber();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return validatePhoneNumber?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (validatePhoneNumber != null) {
      return validatePhoneNumber();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return validatePhoneNumber(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return validatePhoneNumber?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (validatePhoneNumber != null) {
      return validatePhoneNumber(this);
    }
    return orElse();
  }
}

abstract class ValidatePhoneNumber extends WalletTransferEvent {
  const factory ValidatePhoneNumber() = _$ValidatePhoneNumberImpl;
  const ValidatePhoneNumber._() : super._();
}

/// @nodoc
abstract class _$$AmountChangedImplCopyWith<$Res> {
  factory _$$AmountChangedImplCopyWith(
          _$AmountChangedImpl value, $Res Function(_$AmountChangedImpl) then) =
      __$$AmountChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String amount});
}

/// @nodoc
class __$$AmountChangedImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$AmountChangedImpl>
    implements _$$AmountChangedImplCopyWith<$Res> {
  __$$AmountChangedImplCopyWithImpl(
      _$AmountChangedImpl _value, $Res Function(_$AmountChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_$AmountChangedImpl(
      null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AmountChangedImpl extends AmountChanged {
  const _$AmountChangedImpl(this.amount) : super._();

  @override
  final String amount;

  @override
  String toString() {
    return 'WalletTransferEvent.amountChanged(amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmountChangedImpl &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmountChangedImplCopyWith<_$AmountChangedImpl> get copyWith =>
      __$$AmountChangedImplCopyWithImpl<_$AmountChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return amountChanged(amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return amountChanged?.call(amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (amountChanged != null) {
      return amountChanged(amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return amountChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return amountChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (amountChanged != null) {
      return amountChanged(this);
    }
    return orElse();
  }
}

abstract class AmountChanged extends WalletTransferEvent {
  const factory AmountChanged(final String amount) = _$AmountChangedImpl;
  const AmountChanged._() : super._();

  String get amount;

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmountChangedImplCopyWith<_$AmountChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CalculateFeeImplCopyWith<$Res> {
  factory _$$CalculateFeeImplCopyWith(
          _$CalculateFeeImpl value, $Res Function(_$CalculateFeeImpl) then) =
      __$$CalculateFeeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CalculateFeeImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$CalculateFeeImpl>
    implements _$$CalculateFeeImplCopyWith<$Res> {
  __$$CalculateFeeImplCopyWithImpl(
      _$CalculateFeeImpl _value, $Res Function(_$CalculateFeeImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CalculateFeeImpl extends CalculateFee {
  const _$CalculateFeeImpl() : super._();

  @override
  String toString() {
    return 'WalletTransferEvent.calculateFee()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CalculateFeeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return calculateFee();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return calculateFee?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (calculateFee != null) {
      return calculateFee();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return calculateFee(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return calculateFee?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (calculateFee != null) {
      return calculateFee(this);
    }
    return orElse();
  }
}

abstract class CalculateFee extends WalletTransferEvent {
  const factory CalculateFee() = _$CalculateFeeImpl;
  const CalculateFee._() : super._();
}

/// @nodoc
abstract class _$$ReasonChangedImplCopyWith<$Res> {
  factory _$$ReasonChangedImplCopyWith(
          _$ReasonChangedImpl value, $Res Function(_$ReasonChangedImpl) then) =
      __$$ReasonChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$ReasonChangedImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$ReasonChangedImpl>
    implements _$$ReasonChangedImplCopyWith<$Res> {
  __$$ReasonChangedImplCopyWithImpl(
      _$ReasonChangedImpl _value, $Res Function(_$ReasonChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$ReasonChangedImpl(
      null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReasonChangedImpl extends ReasonChanged {
  const _$ReasonChangedImpl(this.reason) : super._();

  @override
  final String reason;

  @override
  String toString() {
    return 'WalletTransferEvent.reasonChanged(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReasonChangedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReasonChangedImplCopyWith<_$ReasonChangedImpl> get copyWith =>
      __$$ReasonChangedImplCopyWithImpl<_$ReasonChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return reasonChanged(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return reasonChanged?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reasonChanged != null) {
      return reasonChanged(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return reasonChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return reasonChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reasonChanged != null) {
      return reasonChanged(this);
    }
    return orElse();
  }
}

abstract class ReasonChanged extends WalletTransferEvent {
  const factory ReasonChanged(final String reason) = _$ReasonChangedImpl;
  const ReasonChanged._() : super._();

  String get reason;

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReasonChangedImplCopyWith<_$ReasonChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitTransferImplCopyWith<$Res> {
  factory _$$SubmitTransferImplCopyWith(_$SubmitTransferImpl value,
          $Res Function(_$SubmitTransferImpl) then) =
      __$$SubmitTransferImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitTransferImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$SubmitTransferImpl>
    implements _$$SubmitTransferImplCopyWith<$Res> {
  __$$SubmitTransferImplCopyWithImpl(
      _$SubmitTransferImpl _value, $Res Function(_$SubmitTransferImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitTransferImpl extends SubmitTransfer {
  const _$SubmitTransferImpl() : super._();

  @override
  String toString() {
    return 'WalletTransferEvent.submitTransfer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitTransferImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return submitTransfer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return submitTransfer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (submitTransfer != null) {
      return submitTransfer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return submitTransfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return submitTransfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (submitTransfer != null) {
      return submitTransfer(this);
    }
    return orElse();
  }
}

abstract class SubmitTransfer extends WalletTransferEvent {
  const factory SubmitTransfer() = _$SubmitTransferImpl;
  const SubmitTransfer._() : super._();
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
          _$ResetImpl value, $Res Function(_$ResetImpl) then) =
      __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$WalletTransferEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
      _$ResetImpl _value, $Res Function(_$ResetImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl extends Reset {
  const _$ResetImpl() : super._();

  @override
  String toString() {
    return 'WalletTransferEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadWalletProviders,
    required TResult Function(Map<String, dynamic> provider)
        selectWalletProvider,
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() validatePhoneNumber,
    required TResult Function(String amount) amountChanged,
    required TResult Function() calculateFee,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadWalletProviders,
    TResult? Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? validatePhoneNumber,
    TResult? Function(String amount)? amountChanged,
    TResult? Function()? calculateFee,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadWalletProviders,
    TResult Function(Map<String, dynamic> provider)? selectWalletProvider,
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? validatePhoneNumber,
    TResult Function(String amount)? amountChanged,
    TResult Function()? calculateFee,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadWalletProviders value) loadWalletProviders,
    required TResult Function(SelectWalletProvider value) selectWalletProvider,
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(ValidatePhoneNumber value) validatePhoneNumber,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(CalculateFee value) calculateFee,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadWalletProviders value)? loadWalletProviders,
    TResult? Function(SelectWalletProvider value)? selectWalletProvider,
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(CalculateFee value)? calculateFee,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadWalletProviders value)? loadWalletProviders,
    TResult Function(SelectWalletProvider value)? selectWalletProvider,
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(ValidatePhoneNumber value)? validatePhoneNumber,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(CalculateFee value)? calculateFee,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class Reset extends WalletTransferEvent {
  const factory Reset() = _$ResetImpl;
  const Reset._() : super._();
}
