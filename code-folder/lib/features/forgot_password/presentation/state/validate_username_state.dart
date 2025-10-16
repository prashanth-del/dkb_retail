import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/validate_username_response.dart';

part 'validate_username_state.freezed.dart';

@freezed
class ValidateUsernameState with _$ValidateUsernameState {
  const factory ValidateUsernameState.initial() = _Initial;
  const factory ValidateUsernameState.loading() = _Loading;
  const factory ValidateUsernameState.success(ValidateUsernameResponse? data) = _Success;
  const factory ValidateUsernameState.failure(String message) = _Failure;
}
