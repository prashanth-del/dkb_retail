import 'package:dkb_retail/core/constants/validator/utils/validators/mobile_number_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/qid_mobile_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/qid_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/tin_form_validator.dart';
import 'package:dkb_retail/core/constants/validator/utils/validators/tin_validator.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tin_form_validator.g.dart';

@riverpod
class TinFormValidatorNotifier extends _$TinFormValidatorNotifier {
  @override
  TinFormValidator build() {
    return _buildTinFormValidator(ref);
  }

  // Extracted method to build the FormValidator
  static TinFormValidator _buildTinFormValidator(Ref ref) {
    return TinFormValidator(
      tinValidator: ref.watch(tinValidator),
    );
  }

  String? validateTin(String? value) {
    return state.tinValidation(value);
  }

}
