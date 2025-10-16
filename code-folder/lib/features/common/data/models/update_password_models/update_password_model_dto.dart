import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/update_password_entites/update_password_model.dart';

part 'update_password_model_dto.freezed.dart';
part 'update_password_model_dto.g.dart';

@freezed
class UpdatePasswordModelDto with _$UpdatePasswordModelDto {
  const factory UpdatePasswordModelDto({
    bool? success,
    String? message,
    dynamic updatedAt,
    bool? usernameUpdated,
    bool? passwordUpdated,
    String? updatedUsername,
    int? passwordHistoryCount,
  }) = _UpdatePasswordModelDto;

  factory UpdatePasswordModelDto.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordModelDtoFromJson(json);
}

extension UpdatePasswordModelDtoX on UpdatePasswordModelDto {
  UpdatePasswordModel toEntity() => UpdatePasswordModel(
    success: success ?? false,
    message: message ?? "",
    updatedAt: updatedAt,
    usernameUpdated: usernameUpdated ?? false,
    passwordUpdated: passwordUpdated ?? false,
    updatedUsername: updatedUsername ?? "",
    passwordHistoryCount: passwordHistoryCount ?? 0,
  );
}
