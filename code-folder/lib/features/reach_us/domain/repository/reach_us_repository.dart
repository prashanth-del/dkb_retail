// Domain repository interface for reach_us.
import '../../../../core/utils/typedefs.dart';
import '../entities/transfer_detail.dart';

abstract class ReachUsRepository {
  // Define the methods your presentation/domain will use.
  // Example:
  // Future<Result<User>> login({required String username, required String password});
  ResultEither<TransferDetail> getTestEntity({
    required Map<String, dynamic> requestBody,
  });
}
