import 'package:freezed_annotation/freezed_annotation.dart';


part 'update_password_model.freezed.dart';

@freezed
class UpdatePasswordModel with _$UpdatePasswordModel {
  const factory UpdatePasswordModel({
    required bool success,
    required String message,
    required dynamic updatedAt,
    required bool usernameUpdated,
    required bool passwordUpdated,
    required String updatedUsername,
    required int passwordHistoryCount,
  }) = _UpdatePasswordModel;
}
