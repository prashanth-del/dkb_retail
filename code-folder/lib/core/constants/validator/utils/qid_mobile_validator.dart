import 'package:dkb_retail/core/constants/validator/utils/validators/fx_amount_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_currency_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_date_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_narration_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_tenor_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/fx_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/mobile_number_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/qid_mobile_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/qid_validator.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qid_mobile_validator.g.dart';

@riverpod
class QidMobileValidatorNotifier extends _$QidMobileValidatorNotifier {
  @override
  QidMobileValidator build() {
    return _buildQidMobileValidator(ref);
  }

  // Extracted method to build the FormValidator
  static QidMobileValidator _buildQidMobileValidator(Ref ref) {
    return QidMobileValidator(
      qidValidator: ref.watch(qidValidator),
      mobileNumberValidator: ref.watch(mobileNumberValidator),
    );
  }

  String? validateQid(String? value) {
    return state.qidValidation(value);
  }

  String? validateMobileNumber(String? value) {
    return state.mobileNumberValidation(value);
  }
}
