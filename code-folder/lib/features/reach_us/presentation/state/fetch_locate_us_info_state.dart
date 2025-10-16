import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/locate_us_info.dart';

part 'fetch_locate_us_info_state.freezed.dart';

@freezed
class FetchLocateUsInfoState with _$FetchLocateUsInfoState {
  const factory FetchLocateUsInfoState.initial() = _Initial;
  const factory FetchLocateUsInfoState.loading() = _Loading;
  const factory FetchLocateUsInfoState.success(List<LocateUsInfo> data) = _Success;
  const factory FetchLocateUsInfoState.failure(String message) = _Failure;
}
