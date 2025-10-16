import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/cache/global_cache.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/common/presentation/components/dialogs.dart';
import 'package:dkb_retail/features/common/presentation/controllers/update_password_notifier.dart';
import 'package:dkb_retail/features/forgot_password/presentation/providers/forget_password_providers.dart';
import 'package:dkb_retail/features/forgot_password/presentation/providers/state/validate_username_notifier.dart';
import 'package:dkb_retail/features/registration/presentation/controller/state/username_validation_state.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_notifier.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_rule_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ForgotPasswordCreateUsernameScreen extends ConsumerStatefulWidget {
  const ForgotPasswordCreateUsernameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateUsernamePageState();
}

class _CreateUsernamePageState
    extends ConsumerState<ForgotPasswordCreateUsernameScreen> {
  final FocusNode usernameFocusNode = FocusNode();
  TextEditingController userNameController = TextEditingController();

  List availableUsernames = ['userName1', 'userName2', 'userName3'];
  bool isAvailable = false;
  bool isDisabled = false;
  bool hasInitialized = false;

  bool showUsernameNotAvailable = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(usernameRuleNotifierProvider.notifier).getUsernameValidations();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(usernameFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUsername = ref.watch(forgotUsernameProvider);
    final rules = ref.watch(usernamerulesProvider);
    final validationState = ref.watch(usernamevalidationNotifierProvider);
    final usernameNotifier = ref.read(usernamevalidationProvider.notifier);

    /// 🧠 Initialize field with current username once
    if (!hasInitialized &&
        currentUsername != null &&
        currentUsername.isNotEmpty) {
      userNameController.text = currentUsername;
      hasInitialized = true;
    }

    final isSameAsCurrent =
        userNameController.text.trim() == (currentUsername ?? '').trim();

    /// 🧩 Button enabling logic
    /// - If same as current username => always enabled
    /// - If changed => enabled only when all rules pass
    isDisabled = isSameAsCurrent ? true : validationState.isValid;

    ref.listen(validateUsernameNotifierProvider, (previous, next) {
      next.maybeWhen(
        failure: (message) {},
        success: (data) async {
          if (data?.exists == false) {
            isAvailable = true;
            showUsernameNotAvailable = false;
            ref.read(currentUsernameProvider.notifier).state = null;
            await GlobalCache.instance.setUsername('');
            if (context.mounted) {
              context.router.push(ForgotPasswordSetPasswordRoute());
            }
          } else {
            isAvailable = false;
            showUsernameNotAvailable = true;
            setState(() {});
          }
        },
        orElse: () {},
      );
    });

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

            /// 🧾 Username TextField
            UiTextField(
              focusNode: usernameFocusNode,
              controller: userNameController,
              label: DefaultString.instance.createUsername,
              keyboardType: TextInputType.name,
              onChanged: (value) {
                ref
                    .read(usernamevalidationNotifierProvider.notifier)
                    .validate(value, rules);

                if (value.trim().length > 8) {
                  isAvailable = true;
                } else {
                  isAvailable = false;
                }
                setState(() {});
              },
              suffix: isAvailable
                  ? const Icon(
                      size: 18,
                      Icons.check_circle,
                      color: DefaultColors.green89,
                    )
                  : showUsernameNotAvailable
                  ? const Icon(
                      size: 18,
                      Icons.block,
                      color: DefaultColors.redDB,
                    )
                  : const SizedBox(),
            ),
            if (showUsernameNotAvailable)
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                ),
                child: Text(
                  "username not available",
                  style: TextStyle(color: DefaultColors.redDB),
                ),
              ),
            UiSpace.vertical(20),

            /// 🧩 Show available usernames and rules only if user changed their username
            if (!isSameAsCurrent) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: UiTextNew.h5Medium(
                  DefaultString.instance.availableUsernames,
                ),
              ),
              UiSpace.vertical(6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  children: availableUsernames.map((item) {
                    return GestureDetector(
                      onTap: () {
                        userNameController.text = item;
                        usernameNotifier.validate(item);
                        isAvailable = true;
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 6, top: 6),
                        padding: const EdgeInsets.symmetric(
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
                  }).toList(),
                ),
              ),
              UiSpace.vertical(26),

              /// Username validation rules
              if (rules.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    runSpacing: 6,
                    spacing: 12,
                    children: rules.map((rule) {
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
                            rule.ruleDescription,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
            ],
          ],
        ),
      ),

      /// ✅ Bottom Button
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
                  isDisabled: !isDisabled,
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: _onPressedNext,
                  label: DefaultString.instance.nextTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedNext() {
    ref
        .read(validateUsernameNotifierProvider.notifier)
        .validateUsername(username: userNameController.text);
  }
}
