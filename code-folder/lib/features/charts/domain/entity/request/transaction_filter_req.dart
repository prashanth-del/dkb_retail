import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_filter_req.freezed.dart';

@freezed
class TransactionFilterReq with _$TransactionFilterReq {
  const factory TransactionFilterReq({
    String? startDate,
    String? endDate,
    List<String>? channels,
    List<String>? serviceTypes,
    String? type,
  }) = _TransactionFilterReq;
}
