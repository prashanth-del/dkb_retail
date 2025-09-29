import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/registration/presentation/controller/username_notifier.dart';
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
  }

  List availableUsernames = ['userName1', 'userName2', 'userName3'];
  bool isAvailable = false;
  bool isDisabled = true;

  @override
  Widget build(BuildContext context) {
    final usernameState = ref.watch(usernamevalidationProvider);
    final usernameNotifier = ref.read(usernamevalidationProvider.notifier);
    isDisabled = usernameState.isValid;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: DefaultColors.white,
      body: SingleChildScrollView(
        child: UiBackgroundWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(40),
              CommonAuthAppBar(
                title: ref.getLocaleString(
                  "Create Username",
                  defaultValue: "Create Username",
                ),
              ),

              UiSpace.vertical(16),
              UiTextField(
                autoFocus: true,
                controller: userNameController,
                label: ref.getLocaleString(
                  'Create Username',
                  defaultValue: 'Create Username',
                ),
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
                    : SizedBox(),
              ),

              UiSpace.vertical(20),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: UiTextNew.h5Medium(
                  ref.getLocaleString(
                    'Available usernames for you',
                    defaultValue: 'Available usernames for you',
                  ),
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
                        title: ref.getLocaleString(
                          "Set New Password",
                          defaultValue: "Set New Password",
                        ),
                        // description:,
                        buttonLabel: ref.getLocaleString(
                          "Confirm Password",
                          defaultValue: "Confirm Password",
                        ),
                        onConfirmed: (password) {
                          context.router.push(UserInterestsRoute());
                        },
                      ),
                    );
                  },
                  label: ref.getLocaleString('Next', defaultValue: 'Next'),
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
