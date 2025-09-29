import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegisterationUsingInactiveCardPage extends ConsumerStatefulWidget {
  const RegisterationUsingInactiveCardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterationUsingInactiveCardPageState();
}

class _RegisterationUsingInactiveCardPageState
    extends ConsumerState<RegisterationUsingInactiveCardPage> {
  final cardController = TextEditingController();
  final cvvController = TextEditingController();
  final qidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isVisible = ref.watch(isCVVVisibleProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 2,
                  colors: [Color.fromARGB(255, 216, 231, 247), Colors.white],
                  stops: [0.0, 0.5],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiSpace.vertical(35),

                Row(
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                      child: IconButton(
                        onPressed: () {
                          context.router.maybePop();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    UiTextNew.h2Semibold(
                      ref.getLocaleString('Register', defaultValue: 'Register'),
                      color: DefaultColors.blue9D,
                    ),
                  ],
                ),

                UiSpace.vertical(16),
                UiTextField(
                  autoFocus: true,
                  controller: cardController,
                  label: ref.getLocaleString(
                    'Enter debit/perpaid card number',
                    defaultValue: 'Enter debit/perpaid card number',
                  ),
                  maxLength: 16,
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (value) async {
                    if (value.length == 16) {
                      ref.read(isCVVVisibleProvider.notifier).state = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        FocusScope.of(context).nextFocus();
                      });
                      await Future.delayed(Duration(milliseconds: 100), () {
                        setState(() {});
                      });
                    } else {
                      ref.read(isCVVVisibleProvider.notifier).state = false;
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                UiSpace.vertical(16),
                isVisible
                    ? UiTextField(
                        controller: cvvController,
                        label: ref.getLocaleString(
                          'Enter CVV',
                          defaultValue: 'Enter CVV',
                        ),
                        maxLength: 3,
                        obscureText: true,
                        keyboardType: TextInputType.numberWithOptions(),
                        onChanged: (value) async {},
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                      )
                    : SizedBox(),
                UiSpace.vertical(16),
                isVisible
                    ? UiTextField(
                        controller: qidController,
                        label: ref.getLocaleString(
                          'Enter QID',
                          defaultValue: 'Enter QID',
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: isVisible
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: DefaultColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        text: ref.getLocaleString(
                          'By clicking on Next you accept our ',
                          defaultValue: 'By clicking on Next you accept our ',
                        ),
                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: DefaultColors.blue60,
                              decoration: TextDecoration.underline,
                            ),
                            text: ref.getLocaleString(
                              'Terms and Conditions',
                              defaultValue: 'Terms and Conditions',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // UiSpace.vertical(12),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: UIButton.rounded(
                        height: 48,
                        btnCurve: 30,
                        isDisabled:
                            cardController.text.isEmpty ||
                                cvvController.text.isEmpty ||
                                qidController.text.isEmpty
                            ? true
                            : false,
                        backgroundColor: DefaultColors.blue9D,
                        onPressed: () {
                          context.router.push(CreatePinRoute());
                        },
                        label: ref.getLocaleString(
                          'Next',
                          defaultValue: 'Next',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
