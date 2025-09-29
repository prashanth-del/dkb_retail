import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/login_model.dart';

part 'login_entity.freezed.dart';
@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    required String status,
    required String message,
    required LoginData data,
    // required String email,
    // required int phone,
    // required bool isEmailVerified,
    // required bool isAuthenticated,
  }) = _LoginEntity;
}




