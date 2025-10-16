import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/common/data/models/otp_validate_models/validate_otp_request_request_info_dto.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/forgot_password/domain/entities/validate_card_entites/validate_card_response_data.dart';
import 'package:dkb_retail/features/forgot_password/presentation/providers/forgot_password_validator.dart';
import 'package:dkb_retail/features/forgot_password/presentation/providers/state/forgot_password_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings/default_string.dart';
import '../../../common/data/models/otp_generate_models/generate_otp_request.dart';
import '../../../common/data/models/otp_generate_models/generate_otp_request_request_info_dto.dart';
import '../../../common/data/models/otp_validate_models/validate_otp_request.dart';
import '../../../common/domain/locators/common_locators.dart';
import '../../../common/presentation/components/dialogs.dart';
import '../providers/forget_password_providers.dart';
import '../widgets/cardNumberFormatter.dart';

@RoutePage()
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(forgotPasswordNotifierProvider.notifier).getActiveCards();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardNumber = ref.watch(cardNumberProvider);
    final cardPin = ref.watch(pinNumberProvider);
    final validators = ref.watch(forgotPasswordValidatorProvider);
    final isVisible = ref.watch(isVisibleProvider);
    final isCardValid = ref.watch(isCardValidProvider);
    final isValid = _formKey.currentState?.validate() ?? false;
    final cardNode = ref.watch(cardFocusNodeProvider);
    final pinNode = ref.watch(pinFocusNodeProvider);

    //listerner

    ref.listen(forgotPasswordNotifierProvider, (previous, next) {
      next.maybeWhen(
        cardValidated: (data) {
          _onValidateSuccess(data);
        },
        orElse: () {},
        failure: (message) {
          showErrorDialog(message, context, ref);
        },
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: AuthHeaderWrapper(
        headerText: DefaultString.instance.forgotCredentials,
        onBack: () {
          if (isVisible && isCardValid) {
            ref.watch(isVisibleProvider.notifier).state = false;
            ref.watch(isCardValidProvider.notifier).state = false;
            ref.read(pinNumberProvider.notifier).state = null;
            ref.read(cardNumberProvider.notifier).state = null;
          } else {
            context.router.maybePop();
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UiTextNew.custom(
                  DefaultString.instance.enterYourCardDetails,
                  color: DefaultColors.grey_07,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              UiSpace.vertical(16),

              /// Card input
              UiTextField(
                label: DefaultString.instance.enterCardNumber,
                focusNode: cardNode,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  CardNumberFormatter(),
                ],
                validator: (value) {
                  if (cardNode.hasFocus) {
                    return validators.validateCardNumber(value, context);
                  }
                  return null;
                },
                maxLength: 16 + 3,
                onTap: () => FocusScope.of(context).requestFocus(cardNode),
                keyboardType: const TextInputType.numberWithOptions(),
                onChanged: (value) async {
                  ref.read(cardNumberProvider.notifier).state = value;

                  if (value.length == 19) {
                    // 🔹 Check if card number is actually valid before showing PIN
                    final validationMessage = validators.validateCardNumber(
                      value,
                      context,
                    );

                    if (validationMessage == null) {
                      // ✅ Card number is valid
                      ref.read(isVisibleProvider.notifier).state = true;
                      ref.read(isCardValidProvider.notifier).state = true;

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted && pinNode.canRequestFocus) {
                          FocusScope.of(context).requestFocus(pinNode);
                        }
                      });
                    } else {
                      // ❌ Invalid card — hide PIN
                      ref.read(isVisibleProvider.notifier).state = false;
                      ref.read(isCardValidProvider.notifier).state = false;
                    }
                  } else {
                    ref.read(isVisibleProvider.notifier).state = false;
                    ref.read(isCardValidProvider.notifier).state = false;
                  }
                },
              ),

              UiSpace.vertical(20),

              if (isVisible)
                if (isCardValid)
                  UiTextField(
                    label: DefaultString.instance.enterPin,
                    hintText: DefaultString.instance.pinHint,
                    focusNode: pinNode,
                    maxLength: 4,
                    obscureText: true,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (value) {
                      ref.read(pinNumberProvider.notifier).state = value;
                    },
                    onFieldSubmitted: (_) => pinNode.unfocus(),
                  ),
            ],
          ),
        ),
      ),

      /// Bottom bar → only shows when card + pin both complete
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: UIButton.rounded(
                  height: 48,
                  btnCurve: 30,
                  txtColor: DefaultColors.white,
                  isDisabled: isCardValid
                      ? !((cardPin?.length ?? 0) == 4 &&
                            (cardNumber?.length ?? 0) >= 19)
                      : !isValid || (cardNumber?.length ?? 0) < 19,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    if ((_formKey.currentState?.validate() ?? false) &&
                        (cardNumber != null) &&
                        (cardPin != null)) {
                      ref
                          .read(forgotPasswordNotifierProvider.notifier)
                          .validateCard(
                            cardNumber: cardNumber.replaceAll(
                              RegExp(r'\s+'),
                              '',
                            ),
                            cardPin: cardPin,
                          );
                    }
                  },
                  label: DefaultString.instance.getOtp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onValidateSuccess(ValidateCardResponseData data) {
    print("data on success ${data.rimNumber}");
    ref.read(forgotUsernameProvider.notifier).state =
        data.userName ?? "username";
    context.router.push(
      CommonOtpRoute(
        onResend: () {
          final request = GenerateOtpRequest(
            requestInfo: GenerateOtpRequestRequestInfoDto(
              action: "login",
              mobileNumber: "+97433333335",
            ),
          );
          ref.read(commonRepositoryProvider).generateOtp(request: request);
        },
        suffixTap: () {
          context.router.popUntil(
            (route) =>
                route.settings.name == LoginRoute.name ||
                route.settings.name == WelcomeBackRoute.name,
          );
        },
        onVerify: (value) async {
          final request = ValidateOtpRequest(
            requestInfo: ValidateOtpRequestRequestInfoDto(otp: value),
          );
          final result = await ref
              .read(commonRepositoryProvider)
              .validateOtp(request: request);
          result.fold(
            (failure) =>
                showErrorDialog(failure.description.toString(), context, ref),
            (otpValidate) {
              context.router.push(ForgotPasswordCreateUsernameRoute());
            },
          );
        },

        onCompleted: (value) async {
          final request = ValidateOtpRequest(
            requestInfo: ValidateOtpRequestRequestInfoDto(otp: value),
          );
          final result = await ref
              .read(commonRepositoryProvider)
              .validateOtp(request: request);
          result.fold(
            (failure) =>
                showErrorDialog(failure.description.toString(), context, ref),
            (otpValidate) {
              context.router.push(ForgotPasswordCreateUsernameRoute());
            },
          );
        },
        title: DefaultString.instance.enterOtp,
        description: DefaultString.instance.otpDescriptionRegisteredNumber,
      ),
    );
  }
}
