import 'package:dkb_retail/features/common/domain/entities/password_rules_entites/password_rules.dart';
import 'package:dkb_retail/features/common/presentation/controllers/common_notifier.dart';
import 'package:riverpod/riverpod.dart';

final passwordRulesProvider = Provider.autoDispose<List<PasswordRules>>((ref) {
  final data = ref.watch(commonNotifierProvider);
  return data.when(
    data: (data) {
      return data as List<PasswordRules>;
    },
    loading: () => [],
    error: (_, e) {
      return [];
    },
  );
});
