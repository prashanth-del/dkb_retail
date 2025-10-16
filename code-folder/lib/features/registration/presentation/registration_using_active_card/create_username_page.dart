import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/registration/presentation/controller/state/username_validation_state.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_notifier.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_rule_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CreateUsernamePage extends ConsumerStatefulWidget {
  const CreateUsernamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateUsernamePageState();
}

class _CreateUsernamePageState extends ConsumerState<CreateUsernamePage> {
  final FocusNode usernameFocusNode = FocusNode();
  TextEditingController userNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(usernameFocusNode);
    });

    Future.microtask(() {
      ref.watch(usernameRuleNotifierProvider.notifier).getUsernameValidations();
    });
  }

  List availableUsernames = ['userName1', 'userName2', 'userName3'];
  bool isAvailable = false;
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    final usernameState = ref.watch(usernamevalidationProvider);
    final usernameNotifier = ref.read(usernamevalidationProvider.notifier);
    final rules = ref.watch(usernamerulesProvider);
    final validationState = ref.watch(usernamevalidationNotifierProvider);
    consoleLog('rules $rules');

    // isDisabled = usernameState.isValid;
    isDisabled = rules.isEmpty ? false : validationState.isValid;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthHeaderWrapper(
        headerText: DefaultString.instance.createUsername,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiSpace.vertical(30),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: UiTextNew.b1Semibold(
                DefaultString.instance.createOrSelectAUsername,
              ),
            ),
            UiSpace.vertical(30),
            UiTextField(
              autoFocus: true,
              controller: userNameController,
              label: DefaultString.instance.createUsername,
              keyboardType: TextInputType.name,
              // inputFormatters: [NoSpaceInputFormatter()],
              onChanged: (value) {
                if (rules.isNotEmpty) {
                  ref
                      .read(usernamevalidationNotifierProvider.notifier)
                      .validate(value, rules);
                }
                // usernameNotifier.validate(value);
                if (value.trim().length > 8) {
                  isAvailable = true;
                  setState(() {});
                } else if (value.isEmpty) {
                  isAvailable = false;
                  setState(() {});
                }
              },
              suffix: isAvailable
                  ? Icon(
                      size: 18,
                      Icons.check_circle,
                      color: DefaultColors.green89,
                    )
                  : SizedBox(),
            ),

            UiSpace.vertical(20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: UiTextNew.h5Medium(
                DefaultString.instance.availableUsernames,
              ),
            ),
            UiSpace.vertical(6),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Wrap(
                children: [
                  ...availableUsernames.map((item) {
                    return GestureDetector(
                      onTap: () {
                        userNameController.text = item;
                        usernameNotifier.validate(item);

                        isAvailable = true;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 6, top: 6),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: DefaultColors.blue60),
                        ),
                        child: UiTextNew.h5Medium(
                          item,
                          color: DefaultColors.blue60,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            UiSpace.vertical(26),

            // if (!usernameState.isEmpty) ...[
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     child: Wrap(
            //       runSpacing: 6,
            //       spacing: 12,
            //       children: [
            //         /// Rules
            //         _buildRuleItem(
            //           "Between a-z characters",
            //           usernameState.hasChars,
            //         ),
            //         _buildRuleItem("No space", usernameState.hasNoSpace),
            //         _buildRuleItem(
            //           "No special characters",
            //           usernameState.hasNoSpecialChars,
            //         ),
            //       ],
            //     ),
            //   ),
            // ],
            rules.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      runSpacing: 6,
                      spacing: 12,
                      children: rules.map((rule) {
                        // Color iconColor;
                        // bool isPassed = false;
                        // if (validationState.failedRules.isEmpty) {
                        //   // Initial state
                        //   iconColor = Colors.grey;
                        // } else {
                        //   // After validation
                        //   isPassed = !validationState.failedRules.contains(
                        //     rule.ruleDescription,
                        //   );
                        //   iconColor = isPassed ? Colors.green : Colors.red;
                        // }
                        final isPassed = !validationState.failedRules.contains(
                          rule.ruleDescription,
                        );
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPassed
                                  ? Icons.check_circle
                                  : Icons.cancel_outlined,

                              color: validationState.input.isEmpty
                                  ? Colors.grey
                                  : isPassed
                                  ? Colors.green
                                  : Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              rule.ruleDescription ?? '',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  )
                : SizedBox(),

            //  ...rules.map((rule) {
            //       final isPassed =
            //           !validationState.failedRules.contains(rule.ruleDescription);
            //       return Row(
            //         children: [
            //           Icon(
            //             isPassed ? Icons.check_circle : Icons.cancel,
            //             color: isPassed ? Colors.green : Colors.red,
            //             size: 18,
            //           ),
            //           const SizedBox(width: 8),
            //           Text(rule.ruleDescription),
            //         ],
            //       );
            //     }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: UIButton.rounded(
                  height: 48,
                  btnCurve: 30,
                  isDisabled: !isDisabled,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.push(
                      CommonSetPasswordRoute(
                        title: DefaultString.instance.setNewPassword,
                        buttonLabel: DefaultString.instance.confirmPassword,
                        onConfirmed: (password) {
                          context.router.push(UserInterestsRoute());
                        },
                      ),
                    );
                  },
                  label: DefaultString.instance.nextTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem(String text, bool isValid) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel_outlined,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 6),
        UiTextNew.h5Medium(text),
      ],
    );
  }
}
