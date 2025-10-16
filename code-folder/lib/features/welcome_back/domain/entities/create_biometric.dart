import 'package:freezed_annotation/freezed_annotation.dart';
import './create_biometric_user.dart';

part 'create_biometric.freezed.dart';

@freezed
class CreateBiometric with _$CreateBiometric {
  const factory CreateBiometric({
    required String deviceId,
    required String imei,
    required int customerNo,
    required int userNo,
    CreateBiometricUser? user,
    required String isBioExpired,
    required dynamic oldDeviceId,
    required String bioEnabled,
    required String dateCreated,
    required dynamic dateModified,
    required String createdBy,
    required dynamic modifiedBy,
  }) = _CreateBiometric;
}
