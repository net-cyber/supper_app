

import 'package:super_app/core/value_failures/value_failures.dart';

class NotAuthenticatedError extends Error {}

class UnexpectedValueError extends Error {

  UnexpectedValueError(this.valueFailure);
  final ValueFailure valueFailure;

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}
