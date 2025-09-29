// Repository implementation for reach_us — bridge Data -> Domain.
import 'package:dkb_retail/core/errors/exceptions.dart';
import 'package:dkb_retail/core/errors/failures.dart';
import 'package:dkb_retail/core/utils/typedefs.dart';
import 'package:dkb_retail/features/reach_us/domain/entities/transfer_detail.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repository/reach_us_repository.dart';
import '../datasource/reach_us_datasource.dart';
// import '../datasource/reach_us_datasource.dart';

class ReachUsRepositoryImpl implements ReachUsRepository {
  final ReachUsDataSource datasource;
  ReachUsRepositoryImpl(this.datasource);

  @override
  ResultEither<TransferDetail> getTestEntity({
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final response = await datasource.getTestList(requestBody: requestBody);
      final getCountryList = response;
      return Either.right(getCountryList.toDomain());
    } on ServiceException catch (e) {
      return Either.left(ServiceFailure(e.message));
    }
  }
  // final ReachUsDataSource _ds;
  // ReachUsRepositoryImpl(this._ds);

  // Implement ReachUsRepository methods here using _ds
}
