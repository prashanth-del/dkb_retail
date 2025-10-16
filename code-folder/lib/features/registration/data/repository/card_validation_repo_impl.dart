import 'package:dartz/dartz.dart';
import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/features/registration/data/datasource/card_validation_datasource.dart';
import 'package:dkb_retail/features/registration/data/models/card_validation_modal_dto.dart';
import 'package:dkb_retail/features/registration/domain/entities/card_validation_modal.dart';
import 'package:dkb_retail/features/registration/domain/repository/card_validation_repository.dart';

class CardValidationRepoImpl extends CardValidationRepository {
  final CardValidationDatasource cardValidationDatasource;

  CardValidationRepoImpl({required this.cardValidationDatasource});

  @override
  Future<Either<Failure, List<CardValidationModal>>>
  getCardValidations() async {
    // TODO: implement getCardValidations
    //throw UnimplementedError();
    try {
      final response = await cardValidationDatasource.getCardValidations();

      // if (!response.ok) {
      //   return left(ServiceFailure(response.status.description.toString()));
      // }
      // consoleLog('api status: ${response.appStatus}');
      // consoleLog('api message: ${response.message}');

      final data = response.data;
      if (data == null) {
        return left(ServiceFailure(response.status.description.toString()));
      }
      final entities = data
          .map((dto) => dto.toEntity())
          .toList(growable: false);
      // Convert DTO to domain

      return right(entities);
    } catch (e) {
      return left(ServiceFailure(e.toString()));
    }
  }
}
