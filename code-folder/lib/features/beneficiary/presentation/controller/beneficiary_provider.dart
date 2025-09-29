import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeTabIndex = StateProvider<int>((ref) => 0);
final cardResetProvider = StateProvider<bool>((ref) => false);
final isAddBeneficiaryProvider = StateProvider<bool>((ref) => false);
final isIndiaCountryProvider = StateProvider<bool>((ref) => false);
final isBangladeshCountryProvider = StateProvider<bool>((ref) => false);


