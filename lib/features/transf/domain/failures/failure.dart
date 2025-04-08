import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.serverError(String message) = ServerFailure;
  const factory Failure.networkError(String message) = NetworkFailure;
  const factory Failure.validationError(String message) = ValidationFailure;
  const factory Failure.insufficientFunds(String message) =
      InsufficientFundsFailure;
  const factory Failure.accountNotFound(String message) =
      AccountNotFoundFailure;
  const factory Failure.unauthorized(String message) = UnauthorizedFailure;
  const factory Failure.unknown(String message) = UnknownFailure;
}
