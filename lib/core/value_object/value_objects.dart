import 'package:dartz/dartz.dart';
import 'package:super_app/core/errors/errors.dart';
import 'package:super_app/core/value_failures/value_failures.dart';
import 'package:super_app/core/value_object/common_interfaces.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ValueObject<T> implements IValidatable {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  T getOrElse(T dflt) {
    return value.getOrElse(() => dflt);
  }

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      left,
      (r) => right(unit),
    );
  }

  @override
  bool isValid() {
    return value.isRight();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

// class UniqueId extends ValueObject<String> {
//   @override
//   final Either<ValueFailure<String>, String> value;

//   // We cannot let a simple String be passed in. This would allow for possible non-unique IDs.
//   factory UniqueId() {
//     return UniqueId._(
//       right(Uuid().v1()),
//     );
//   }

//   /// Used with strings we trust are unique, such as database IDs.
//   factory UniqueId.fromUniqueString(String uniqueIdStr) {
//     assert(uniqueIdStr != null);
//     return UniqueId._(
//       right(uniqueIdStr),
//     );
//   }

//   const UniqueId._(this.value);
// }

