import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CommonCreateUsernamePage extends ConsumerStatefulWidget {
  final String title;
  final void Function(String username) onSubmit;

  const CommonCreateUsernamePage({
    super.key,
    required this.title,
    required this.onSubmit,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommonCreateUsernamePageState();
}

class _CommonCreateUsernamePageState
    extends ConsumerState<CommonCreateUsernamePage> {
  final FocusNode usernameFocusNode = FocusNode();
  final TextEditingController userNameController = TextEditingController();
  bool isAvailable = false;
  List availableUsernames = ['userName1', 'userName2', 'userName3'];

  @override
  void initState() {
    super.initState();
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

  bool isDisabled = true;

  @override
  Widget build(BuildContext context) {
    final usernameState = ref.watch(usernamevalidationProvider);
    final usernameNotifier = ref.read(usernamevalidationProvider.notifier);
    isDisabled = usernameState.isValid;
    consoleLog('isDisbale : $isDisabled');
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
                autoFocus: true,
                controller: userNameController,
                label: 'Create Username',
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  usernameNotifier.validate(value);
                  if (value.length > 7) {
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
                    : const SizedBox(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[a-zA-Z0-9]+$'),
                  ), // only a-z
                ],
              ),

              UiSpace.vertical(20),

              // Suggested usernames
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: UiTextNew.h5Medium('Available usernames for you'),
              ),
              UiSpace.vertical(6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  children: [
                    ...availableUsernames.map((item) {
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
                    }),
                  ],
                ),
              ),
              UiSpace.vertical(26),

              if (!usernameState.isEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    runSpacing: 6,
                    spacing: 12,
                    children: [
                      /// Rules
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

      // Bottom button
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
              isDisabled: !isDisabled,
              backgroundColor: DefaultColors.blue9D,
              onPressed: () {
                widget.onSubmit(userNameController.text.trim());
              },
              label: 'Next',
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
