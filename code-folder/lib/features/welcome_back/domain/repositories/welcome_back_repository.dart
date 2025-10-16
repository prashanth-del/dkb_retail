import 'package:dartz/dartz.dart';
import '../../../../network/domain/models/api_error.dart';
import '../entities/biometric_auth.dart';
import '../../data/models/biometriclogin_request.dart';
import '../entities/create_biometric.dart';
import '../../data/models/register_biometric_request.dart';

abstract class WelcomeBackRepository {
  Future<Either<ApiError, BiometricAuth>> biometriclogin({ required BiometricloginRequest request, });
  Future<Either<ApiError, CreateBiometric>> registerBiometric({ required RegisterBiometricRequest request, });
}
