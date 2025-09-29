import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ForgotPasswordCreateUsernamePage extends ConsumerStatefulWidget {
  final String title;
  final void Function(String username) onSubmit;

  const ForgotPasswordCreateUsernamePage({
    super.key,
    required this.title,
    required this.onSubmit,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordCreateUsernamePageState();
}

class _ForgotPasswordCreateUsernamePageState
    extends ConsumerState<ForgotPasswordCreateUsernamePage> {
  final FocusNode usernameFocusNode = FocusNode();
  final String defaultUsername = 'username';
  late TextEditingController userNameController;
  String? errorText;

  bool isAvailable = false;

  bool firstTimeClicked = true;

  final List<String> availableUsernames = [
    'userName1',
    'userName2',
    'userName3',
  ];

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: defaultUsername);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(usernameFocusNode);
    });
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    userNameController.dispose();
    super.dispose();
  }

  void _onUsernameChanged(String value, UsernameNotifier notifier) {
    notifier.validate(value);

    // Simple availability logic (replace with real API call if needed)
    if (value.length > 7) {
      isAvailable = true;
    } else {
      isAvailable = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final usernameState = ref.watch(usernamevalidationProvider);
    final usernameNotifier = ref.read(usernamevalidationProvider.notifier);

    final isFormValid = usernameState.isValid && isAvailable;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: UiBackgroundWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(40),
              CommonAuthAppBar(title: widget.title),
              UiSpace.vertical(16),

              // Username field
              UiTextField(
                controller: userNameController,
                focusNode: usernameFocusNode,
                label: 'Username',
                // validator: (value) {
                //   if (firstTimeClicked &&
                //       ((value?.length ?? 0) > (7)) &&
                //       value != defaultUsername) {
                //     return 'Username not available'; // Skip validation if first time and default username
                //   }
                //   return null;
                // },
                onChanged: (value) =>
                    _onUsernameChanged(value, usernameNotifier),
                suffix: firstTimeClicked
                    ? null
                    : isAvailable
                    ? errorText == userNameController.text
                          ? null
                          : Icon(
                              Icons.check_circle,
                              color: DefaultColors.green89,
                              size: 18,
                            )
                    : const SizedBox(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                ],
              ),
              if (errorText == userNameController.text)
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 4),
                  child: Text(
                    'Username not available',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              UiSpace.vertical(20),
              if (!firstTimeClicked &&
                  defaultUsername != userNameController.text) ...[
                // Suggested usernames
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: UiTextNew.h5Medium('Available usernames for you'),
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
                          setState(() => isAvailable = true);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    runSpacing: 6,
                    spacing: 12,
                    children: [
                      _buildRuleItem(
                        "Between a-z characters",
                        usernameState.hasChars,
                      ),
                      _buildRuleItem("No space", usernameState.hasNoSpace),
                      _buildRuleItem(
                        "No special characters",
                        usernameState.hasNoSpecialChars,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: UIButton.rounded(
              height: 48,
              btnCurve: 30,
              isDisabled: firstTimeClicked && userNameController.text.length > 7
                  ? false
                  : errorText == userNameController.text
                  ? true
                  : !isFormValid,
              backgroundColor: DefaultColors.blue9D,
              onPressed: firstTimeClicked
                  ? () {
                      firstTimeClicked = false;
                      if (defaultUsername == userNameController.text) {
                        widget.onSubmit(userNameController.text.trim());
                      }
                      errorText = userNameController.text;
                      setState(() {});
                    }
                  : () {
                      widget.onSubmit(userNameController.text.trim());
                    },
              label: 'Next',
              txtColor: Colors.white,
              //test//
            ),
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
