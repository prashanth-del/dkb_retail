import 'package:dkb_retail/features/transfer/data/model/transfer_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/src/transfer_module_info.dart';
import '../../modules/src/transfer_module_map.dart';

// domestic
final domesticListProvider = StateProvider<List<TransferModuleInfo>>((ref) {
  final moduleMap = ref.watch(domesticMapProvider);
  return moduleMap.values.toList();
});

// ift
final iftListProvider = StateProvider<List<TransferModuleInfo>>((ref) {
  final moduleMap = ref.watch(iftMapProvider);
  return moduleMap.values.toList();
});

// fawran
final fawranListProvider = StateProvider<List<TransferModuleInfo>>((ref) {
  final moduleMap = ref.watch(fawranMapProvider);
  return moduleMap.values.toList();
});

// transaction
final transactionListProvider = StateProvider<List<TransferModuleInfo>>((ref) {
  final moduleMap = ref.watch(transactionMapProvider);
  return moduleMap.values.toList();
});
final transactionIFTListProvider = StateProvider<List<TransferModuleInfo>>((
  ref,
) {
  final moduleMap = ref.watch(transactionMapIFTProvider);
  return moduleMap.values.toList();
});

// fav
final favListProvider = StateProvider<List<TransferModuleInfo>>((ref) {
  final moduleMap = ref.watch(favMapProvider);
  return moduleMap.values.toList();
});

// beneficiary
final benListProvider = StateProvider<List<TransferModuleInfo>>((ref) {
  final moduleMap = ref.watch(benMapProvider);
  return moduleMap.values.toList();
});

List<String> info = [
  "Maximum limit per transaction is QAR 55,000.00",
  "Transactions can be done in QAR only",
  "Transaction charge of QAR 0.60 with be deducted per transfer",
  "All transactions shall be processed 24 X 7",
  "All transactions shall be processed subject to availability of funds in account",
];

List<String> dCardInfo = [
  "> Total Daily Limit : QAR 1000",
  "> Total Used Amount : QAR 0",
  "> Total Available limit: QAR 1000",
];

List<String> iftInfo = [
  "The exchange rate displayed is indicative.The account will be debited at the prevailing exchange rate at the time of processing this request.",
  "The processing of this request will take 1-2 business days in accordance with our cut-off timings. The instructions placed on Thursday afternoon and during official holidays will be processed on the next working day.",
  "Kindly re-verify the beneficiary Account Number/IBAN prior to performing a transaction in order to avoid unforeseen rejections by recipient bank.",
  "Charges will be recovered at the time of processing the transaction.",
  "Maximum limit per transaction / day is QAR 100,000/-",
  "Transactions performed after 11:30 AM (Qatar local time) / weekends / public holidays will be processed on the next working days.",
];

class TransactionData {
  String fromAccount;
  String toAccount;
  String amount;
  String remarks;

  TransactionData({
    required this.fromAccount,
    required this.toAccount,
    required this.amount,
    required this.remarks,
  });
}

class TransactionNotifier extends Notifier<TransactionData> {
  @override
  TransactionData build() {
    return TransactionData(
      fromAccount: "",
      toAccount: "",
      amount: "",
      remarks: "",
    );
  }

  void updateTransaction({
    String? fromAccount,
    String? toAccount,
    String? amount,
    String? remarks,
  }) {
    state = TransactionData(
      fromAccount: fromAccount ?? state.fromAccount,
      toAccount: toAccount ?? state.toAccount,
      amount: amount ?? state.amount,
      remarks: remarks ?? state.remarks,
    );
  }
}

final transactionProvider =
    NotifierProvider<TransactionNotifier, TransactionData>(
      () => TransactionNotifier(),
    );

final currentStepProvider = StateProvider<int>((ref) => 0);
final isNextPageProvider = StateProvider<bool>((ref) => false);
final isFavProvider = StateProvider<bool>((ref) => false);
final selectedTransferProvider = StateProvider<TransferSelection?>(
  (ref) => null,
);
