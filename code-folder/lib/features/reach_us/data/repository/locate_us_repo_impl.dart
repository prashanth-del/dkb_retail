import 'package:dkb_retail/core/utils/typedefs.dart';
import 'package:dkb_retail/features/reach_us/domain/entities/branch_atm_kiosk_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repository/locate_us_repository.dart';
import '../datasource/locate_us_datasource.dart';

class LocateUsRepositoryImpl implements LocateUsRepository {
  final LocateUsDataSource datasource;
  LocateUsRepositoryImpl(this.datasource);

  @override
  ResultEither<LocateUsEntity> getLocateEntity({
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final response = await datasource.getLocateUsResponse(
        requestBody: requestBody,
      );
      final getTransaction = response;
      return Either.right(getTransaction.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }
}
