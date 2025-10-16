import 'package:dartz/dartz.dart';
import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/features/registration/domain/entities/username_rules_modal.dart';

abstract class UsernameRulesRepository {
  Future<Either<Failure, List<UsernameRulesModal>>> getUsernameValidations();
}
