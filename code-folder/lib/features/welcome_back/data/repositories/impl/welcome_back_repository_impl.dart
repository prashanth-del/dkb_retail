import 'package:dartz/dartz.dart';
import '../../datasource/welcome_back_datasource.dart';
import '../../models/biometric_auth_dto.dart';
import '../../../domain/repositories/welcome_back_repository.dart';
import '../../../domain/entities/biometric_auth.dart';
import '../../models/register_biometric_request.dart';
import '../../models/create_biometric_dto.dart';
import '../../../domain/entities/create_biometric.dart';
import '../../../../../network/domain/models/api_error.dart' show ApiError, ApiErrorX;
import '../../models/biometriclogin_request.dart';

class WelcomeBackRepositoryImpl implements WelcomeBackRepository {
  final WelcomeBackDatasource datasource;
  WelcomeBackRepositoryImpl(this.datasource);
  @override
  Future<Either<ApiError, BiometricAuth>> biometriclogin({ required BiometricloginRequest request, }) async {
    final env = await datasource.biometriclogin(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);

  }


  @override
  Future<Either<ApiError, CreateBiometric>> registerBiometric({ required RegisterBiometricRequest request, }) async {
    final env = await datasource.registerBiometric(request: request);
    if (!env.ok) return left(ApiErrorX.fromEnvelope(env));
    final mapped = env.data?.toEntity();
    if (mapped == null) return left(ApiErrorX.fromEnvelope(env));
    return right(mapped);

  }
}
