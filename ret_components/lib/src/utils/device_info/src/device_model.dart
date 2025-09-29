import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
class DeviceModel with _$DeviceModel {
  const factory DeviceModel({
    String? deviceType,
    String? devicePlatform,
    String? deviceId,
    String? ipAddress,
    String? vendorId,
    String? osVersion,
    String? appVersion,
    String? endToEndId,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => _$DeviceModelFromJson(json);
}