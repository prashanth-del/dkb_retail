import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/common/components/common_set_password_page.dart';
import 'package:dkb_retail/features/registration/presentation/controller/registration_active_controllers.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegistrationStartPage extends ConsumerStatefulWidget {
  const RegistrationStartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationStartPageState();
}

class _RegistrationStartPageState extends ConsumerState<RegistrationStartPage> {
  // TextEditingController qidpassController = TextEditingController();
  // TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final qidpassController = ref.watch(qidpassportProvider);
    final mobileController = ref.watch(userMobileProvider);

    final isDisable = ref.watch(isqidFormValidProvider);

    consoleLog(isDisable);

    return Scaffold(
      body: SingleChildScrollView(
        child: UiBackgroundWrapper(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                UiSpace.vertical(40),
                CommonAuthAppBar(
                  title: ref.getLocaleString(
                    "Register Using Your Card",
                    defaultValue: "Register Using Your Card",
                  ),
                ),
                UiSpace.vertical(16),
                UiTextField(
                  controller: qidpassController,
                  maxLength: 11,
                  label: ref.getLocaleString(
                    "Enter QID/passport",
                    defaultValue: "Enter QID/passport",
                  ),
                  keyboardType: TextInputType.name,
                  inputFormatters: [NoSpaceInputFormatter()],

                  onChanged: (value) {},
                  validator: (value) => requiredTextValidator(value),
                ),
                UiSpace.vertical(16),
                UiTextField(
                  controller: mobileController,
                  label: ref.getLocaleString(
                    "Enter Registered Mobile number",
                    defaultValue: "Enter Registered Mobile number",
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    // if (value.length >= 8) {
                    //   setState(() {});
                    // } else if (value.isEmpty) {
                    //   setState(() {});
                    // }
                  },
                  maxLength: 8,
                  inputFormatters: [
                    // FilteringTextInputFormatter.allow(RegExp(r'^\+[0-9]+$')),RegExp(r'[0-9]')
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Please enter mobile number";
                  //   }
                  //   if (value.length != 8) {
                  //     return "Mobile number must be 8 digits";
                  //   }
                  //   return null;
                  // },
                  validator: (value) => qatarMobileValidator(value),
                ),
              ],
            ),
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
                  isDisabled: !isDisable,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.router.push(RegisterationUsingActiveCardRoute());
                    }
                  },
                  label: 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
