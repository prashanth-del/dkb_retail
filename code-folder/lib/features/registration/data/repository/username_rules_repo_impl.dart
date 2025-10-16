import 'package:dartz/dartz.dart';
import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/features/registration/data/datasource/username_validations_datasource.dart';
import 'package:dkb_retail/features/registration/data/models/username_rules_modal_dto.dart';
import 'package:dkb_retail/features/registration/domain/entities/username_rules_modal.dart';
import 'package:dkb_retail/features/registration/domain/repository/username_rules_repository.dart';

class UsernameRulesRepoImpl extends UsernameRulesRepository {
  final UsernameValidationsDatasource usernameValidationsDatasource;

  UsernameRulesRepoImpl({required this.usernameValidationsDatasource});

  @override
  Future<Either<Failure, List<UsernameRulesModal>>>
  getUsernameValidations() async {
    // TODO: implement getUsernameValidations
    // throw UnimplementedError();
    try {
      final response = await usernameValidationsDatasource
          .getUsernameValidations();

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
