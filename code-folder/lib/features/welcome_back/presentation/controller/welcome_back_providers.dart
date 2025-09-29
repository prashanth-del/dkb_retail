import 'package:flutter_riverpod/flutter_riverpod.dart';

final showAccountBalanceProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
