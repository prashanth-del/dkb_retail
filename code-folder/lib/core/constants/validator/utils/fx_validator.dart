import 'package:dkb_retail/core/constants/validator/utils/validators/fx_amount_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_currency_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_date_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_narration_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_tenor_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_validator.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fx_validator.g.dart';

@riverpod
class FxValidatorNotifier extends _$FxValidatorNotifier {
  @override
  FxValidator build() {
    return _buildFxValidator(ref);
  }

  // Extracted method to build the FormValidator
  static FxValidator _buildFxValidator(Ref ref) {
    return FxValidator(
      fxCurrencyValidator: ref.watch(fxCurrencyValidator),
      fxNarrationValidator: ref.watch(fxNarrationValidator),
      fxTenorValidator: ref.watch(fxTenorValidator),
      fxDateValidator: ref.watch(fxDateValidator),
      fxAmountValidator: ref.watch(fxAmountValidator),
    );
  }

  String? validateFxCurrency(String? value) {
    return state.fxCurrencyValidaton(value);
  }

  String? validateFxNarration(String? value) {
    return state.fxNarrationValidaton(value);
  }

  String? validateFxTenor(String? value) {
    return state.fxTenorValidaton(value);
  }

  String? validateFxDate(String? value) {
    return state.fxDateValidaton(value);
  }

  String? validateFxAmount(String? value) {
    return state.fxAmountValidaton(value);
  }
}
