import 'package:equatable/equatable.dart';

/// Base failure class for the application
abstract class Failure extends Equatable {
  /// Constructor for Failure
  const Failure([this.message = '']);

  /// Error message
  final String message;

  @override
  List<Object> get props => [message];
}

/// Server failure
class ServerFailure extends Failure {
  /// Constructor for ServerFailure
  const ServerFailure([String message = 'Server error occurred'])
      : super(message);
}

/// Cache failure
class CacheFailure extends Failure {
  /// Constructor for CacheFailure
  const CacheFailure([String message = 'Cache error occurred'])
      : super(message);
}

/// Network failure
class NetworkFailure extends Failure {
  /// Constructor for NetworkFailure
  const NetworkFailure([String message = 'Network error occurred'])
      : super(message);
}

/// Invalid input failure
class InvalidInputFailure extends Failure {
  /// Constructor for InvalidInputFailure
  const InvalidInputFailure([String message = 'Invalid input'])
      : super(message);
}

/// Authentication failure
class AuthFailure extends Failure {
  /// Constructor for AuthFailure
  const AuthFailure([String message = 'Authentication failed'])
      : super(message);
}

/// Account validation failure
class AccountValidationFailure extends Failure {
  /// Constructor for AccountValidationFailure
  const AccountValidationFailure([String message = 'Account validation failed'])
      : super(message);
}

/// Transfer failure
class TransferFailure extends Failure {
  /// Constructor for TransferFailure
  const TransferFailure([String message = 'Transfer failed']) : super(message);
}
