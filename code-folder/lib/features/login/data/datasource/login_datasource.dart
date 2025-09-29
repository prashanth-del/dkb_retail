import 'dart:io';

import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../../../../common/utils.dart';
import '../../../../core/utils/method_channel/custom_method_channel.dart';
import '../../../../network/data/api_mapper.dart';
import '../../../../network/data/execute_api_call.dart';
import '../../../../network/data/model/app_status.dart';
import '../../../../network/data/model/generic_response.dart';
import '../../../../network/data/network_client.dart';
import '../../../../network/data/status_policy.dart';
import '../../../../network/data/types.dart';
import '../../../../network/data/urls/login_url.dart';
import '../../../../network/domain/models/api_envelope.dart';
import '../../../../network/domain/models/api_error.dart';
import '../../../../network/domain/models/api_response.dart';
import '../models/rp_dto.dart';
import '../models/user_dto.dart';

part 'src/resend_otp.dart';

part 'src/validate_otp.dart';

part 'src/signin_with_credentials.dart';

abstract class LoginDatasource {
  Future<ApiEnvelope<void>> validateOtp({required String otp});

  Future<ApiEnvelope<UserDto>> signInWithCredentials({
    required String customerId,
    required String username,
    required String password,
  });

  Future<ApiEnvelope<void>> resendOtp();
  //
  // Future<ApiResponse> logout();
  //
  // Future<ApiResponse> changePassword({required String oldPassword,
  //   required String newPassword,
  //   required bool isLogin});
  //
  // Future<ApiResponse> menuItems({
  //   required String screenId
  // });
}

class LoginDatasourceImpl implements LoginDatasource {
  LoginDatasourceImpl({required this.networkClient});

  final NetworkClient networkClient;

  @override
  Future<ApiEnvelope<UserDto>> signInWithCredentials({
    required String customerId,
    required String username,
    required String password,
  }) {
    return _signInWithCredentials(
      networkClient,
      customerId: customerId,
      username: username,
      password: password,
    );
  }

  @override
  Future<ApiEnvelope> resendOtp() async {
    return _resendOtp(networkClient);
  }

  @override
  Future<ApiEnvelope> validateOtp({required String otp}) async {
    return _validateOtp(networkClient, otp: otp);
  }
}
