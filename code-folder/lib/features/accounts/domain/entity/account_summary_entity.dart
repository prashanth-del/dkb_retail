import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/account_summary_model.dart';

part 'account_summary_entity.freezed.dart';

@freezed
class AccountSummaryEntity with _$AccountSummaryEntity {
  const factory AccountSummaryEntity({
    required List<Map<String, String>> totalAvailBalance,
    required List<AccountDetailsA> accountDetails,
  }) = _AccountSummaryEntity;
}
