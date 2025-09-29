import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/new_password_providers.dart';
import '../widgets/password_rules_widget.dart';

@RoutePage()
class SetNewPasswordPage extends ConsumerStatefulWidget {
  const SetNewPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetPasswordPageState();
}

class _SetPasswordPageState extends ConsumerState<SetNewPasswordPage> {
  final TextEditingController _setPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FocusScope.of(context).requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final validation = ref.watch(validatePasswordProvider);
    final isMatch = ref.watch(isConfirmPasswordProvider);
    final isObscure = ref.watch(passwordVisibilityProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // gradient header
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
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
                UiSpace.vertical(20),

                // Back button
                SizedBox(
                  height: kToolbarHeight,
                  child: IconButton(
                    onPressed: () => context.router.pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: UiTextNew.h2Semibold(
                    'Set New Password',
                    color: DefaultColors.blue9D,
                  ),
                ),
                UiSpace.vertical(16),

                // Password field using UiTextField
                UiTextField(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  controller: _setPasswordController,
                  label: "Set Password",
                  obscureText: isObscure,
                  keyboardType: TextInputType.visiblePassword,
                  autoFocus: true,
                  onChanged: (value) {
                    ref.read(validatePasswordProvider.notifier).validate(value);
                    ref.read(passwordControllerProvider.notifier).state = value;
                  },
                  onFieldSubmitted: (_) {
                    if (validation.isStrong) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      UiToast().showToast('Enter Valid Password');
                    }
                  },

                  suffix: InkWell(
                    onTap: () {
                      ref.read(passwordVisibilityProvider.notifier).state =
                          !isObscure;
                    },
                    child: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: DefaultColors.black,
                    ),
                  ),
                ),

                UiSpace.vertical(16),

                // Confirm password field using UiTextField
                UiTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    ref.read(confirmPasswordControllerProvider.notifier).state =
                        value;
                  },
                ),

                UiSpace.vertical(16),
                ...passwordRulesWidget(validation),
              ],
            ),
          ],
        ),
      ),

      // Bottom button
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
                  txtColor: Colors.white,
                  isDisabled: !isMatch,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.push(ForgetPasswordTaskCompleteRoute());
                    ref.read(passwordControllerProvider.notifier).state = "";
                  },
                  label: 'Confirm Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
