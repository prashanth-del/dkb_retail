import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/update_password_entites/update_password_model.dart';

part 'update_password2_state.freezed.dart';

@freezed
class UpdatePassword2State with _$UpdatePassword2State {
  const factory UpdatePassword2State.initial() = _Initial;
  const factory UpdatePassword2State.loading() = _Loading;
  const factory UpdatePassword2State.success(UpdatePasswordModel? data) =
      _Success;
  const factory UpdatePassword2State.failure(String message) = _Failure;
}
