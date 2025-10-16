import '../../../../core/utils/typedefs.dart';
import '../entities/branch_atm_kiosk_entity.dart';

abstract class LocateUsRepository {
  ResultEither<LocateUsEntity> getLocateEntity({
    required Map<String, dynamic> requestBody,
  });
}
