import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bank_info.dart';

part 'fetch_bank_info_state.freezed.dart';

@freezed
class FetchBankInfoState with _$FetchBankInfoState {
  const factory FetchBankInfoState.initial() = _Initial;
  const factory FetchBankInfoState.loading() = _Loading;
  const factory FetchBankInfoState.success(BankInfo? data) = _Success;
  const factory FetchBankInfoState.failure(String message) = _Failure;
}
