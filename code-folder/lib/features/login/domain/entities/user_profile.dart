import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

enum UserRoleType {
  maker,
  verifier,
  approver,
}

@freezed
class UserProfile with _$UserProfile {
  factory UserProfile({
    required String userName,
    required String customerNumber,
    required String? dcUserName,
    required UserRoleType? userRole,
  }) = _UserProfile;
}

UserRoleType? mapStringToUserRoleType(String? role) {
  switch (role?.toLowerCase()) {
    case 'maker':
      return UserRoleType.maker;
    case 'verifier':
      return UserRoleType.verifier;
    case 'approver':
      return UserRoleType.approver;
    default:
      return null;
  }
}
