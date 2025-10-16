import 'package:dartz/dartz.dart';
import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/features/registration/domain/entities/card_validation_modal.dart';

abstract class CardValidationRepository {
  Future<Either<Failure, List<CardValidationModal>>> getCardValidations();
}
