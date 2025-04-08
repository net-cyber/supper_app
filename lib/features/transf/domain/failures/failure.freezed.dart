// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
          _$ServerFailureImpl value, $Res Function(_$ServerFailureImpl) then) =
      __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
      _$ServerFailureImpl _value, $Res Function(_$ServerFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ServerFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ServerFailureImpl implements ServerFailure {
  const _$ServerFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.serverError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) {
    return serverError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) {
    return serverError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements Failure {
  const factory ServerFailure(final String message) = _$ServerFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$NetworkFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.networkError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) {
    return networkError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) {
    return networkError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure(final String message) = _$NetworkFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(_$ValidationFailureImpl value,
          $Res Function(_$ValidationFailureImpl) then) =
      __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(_$ValidationFailureImpl _value,
      $Res Function(_$ValidationFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ValidationFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.validationError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) {
    return validationError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) {
    return validationError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (validationError != null) {
      return validationError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validationError != null) {
      return validationError(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  const factory ValidationFailure(final String message) =
      _$ValidationFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsufficientFundsFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$InsufficientFundsFailureImplCopyWith(
          _$InsufficientFundsFailureImpl value,
          $Res Function(_$InsufficientFundsFailureImpl) then) =
      __$$InsufficientFundsFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$InsufficientFundsFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InsufficientFundsFailureImpl>
    implements _$$InsufficientFundsFailureImplCopyWith<$Res> {
  __$$InsufficientFundsFailureImplCopyWithImpl(
      _$InsufficientFundsFailureImpl _value,
      $Res Function(_$InsufficientFundsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$InsufficientFundsFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InsufficientFundsFailureImpl implements InsufficientFundsFailure {
  const _$InsufficientFundsFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.insufficientFunds(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientFundsFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsufficientFundsFailureImplCopyWith<_$InsufficientFundsFailureImpl>
      get copyWith => __$$InsufficientFundsFailureImplCopyWithImpl<
          _$InsufficientFundsFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) {
    return insufficientFunds(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) {
    return insufficientFunds?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return insufficientFunds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return insufficientFunds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(this);
    }
    return orElse();
  }
}

abstract class InsufficientFundsFailure implements Failure {
  const factory InsufficientFundsFailure(final String message) =
      _$InsufficientFundsFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsufficientFundsFailureImplCopyWith<_$InsufficientFundsFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountNotFoundFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AccountNotFoundFailureImplCopyWith(
          _$AccountNotFoundFailureImpl value,
          $Res Function(_$AccountNotFoundFailureImpl) then) =
      __$$AccountNotFoundFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AccountNotFoundFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AccountNotFoundFailureImpl>
    implements _$$AccountNotFoundFailureImplCopyWith<$Res> {
  __$$AccountNotFoundFailureImplCopyWithImpl(
      _$AccountNotFoundFailureImpl _value,
      $Res Function(_$AccountNotFoundFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AccountNotFoundFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccountNotFoundFailureImpl implements AccountNotFoundFailure {
  const _$AccountNotFoundFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.accountNotFound(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountNotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountNotFoundFailureImplCopyWith<_$AccountNotFoundFailureImpl>
      get copyWith => __$$AccountNotFoundFailureImplCopyWithImpl<
          _$AccountNotFoundFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) {
    return accountNotFound(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) {
    return accountNotFound?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (accountNotFound != null) {
      return accountNotFound(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return accountNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return accountNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (accountNotFound != null) {
      return accountNotFound(this);
    }
    return orElse();
  }
}

abstract class AccountNotFoundFailure implements Failure {
  const factory AccountNotFoundFailure(final String message) =
      _$AccountNotFoundFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountNotFoundFailureImplCopyWith<_$AccountNotFoundFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnauthorizedFailureImplCopyWith(_$UnauthorizedFailureImpl value,
          $Res Function(_$UnauthorizedFailureImpl) then) =
      __$$UnauthorizedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnauthorizedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnauthorizedFailureImpl>
    implements _$$UnauthorizedFailureImplCopyWith<$Res> {
  __$$UnauthorizedFailureImplCopyWithImpl(_$UnauthorizedFailureImpl _value,
      $Res Function(_$UnauthorizedFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UnauthorizedFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnauthorizedFailureImpl implements UnauthorizedFailure {
  const _$UnauthorizedFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      __$$UnauthorizedFailureImplCopyWithImpl<_$UnauthorizedFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class UnauthorizedFailure implements Failure {
  const factory UnauthorizedFailure(final String message) =
      _$UnauthorizedFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(_$UnknownFailureImpl value,
          $Res Function(_$UnknownFailureImpl) then) =
      __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
      _$UnknownFailureImpl _value, $Res Function(_$UnknownFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UnknownFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) serverError,
    required TResult Function(String message) networkError,
    required TResult Function(String message) validationError,
    required TResult Function(String message) insufficientFunds,
    required TResult Function(String message) accountNotFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? serverError,
    TResult? Function(String message)? networkError,
    TResult? Function(String message)? validationError,
    TResult? Function(String message)? insufficientFunds,
    TResult? Function(String message)? accountNotFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? serverError,
    TResult Function(String message)? networkError,
    TResult Function(String message)? validationError,
    TResult Function(String message)? insufficientFunds,
    TResult Function(String message)? accountNotFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) serverError,
    required TResult Function(NetworkFailure value) networkError,
    required TResult Function(ValidationFailure value) validationError,
    required TResult Function(InsufficientFundsFailure value) insufficientFunds,
    required TResult Function(AccountNotFoundFailure value) accountNotFound,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? serverError,
    TResult? Function(NetworkFailure value)? networkError,
    TResult? Function(ValidationFailure value)? validationError,
    TResult? Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult? Function(AccountNotFoundFailure value)? accountNotFound,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? serverError,
    TResult Function(NetworkFailure value)? networkError,
    TResult Function(ValidationFailure value)? validationError,
    TResult Function(InsufficientFundsFailure value)? insufficientFunds,
    TResult Function(AccountNotFoundFailure value)? accountNotFound,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure(final String message) = _$UnknownFailureImpl;

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
