import '../errors/failures.dart';

abstract class IValidator {
  ValidationFailure? validate(String? value);
}