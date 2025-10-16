import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:dkb_retail/features/common/presentation/components/common_set_password_page.dart';
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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.microtask(() {
  //     ref.watch(registrationNotifierProvider.notifier).getCardValidations();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final qidpassController = ref.watch(qidpassportProvider);
    final mobileController = ref.watch(userMobileProvider);

    final isDisable = ref.watch(isqidFormValidProvider);

    consoleLog(isDisable);

    return Scaffold(
      body: AuthHeaderWrapper(
        headerText: DefaultString.instance.registrationCard,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiSpace.vertical(30),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: UiTextNew.b1Semibold(
                  DefaultString.instance.enterQidPassportAndMobileNumber,
                ),
              ),

              UiSpace.vertical(30),
              UiTextField(
                autoFocus: true,
                controller: qidpassController,
                maxLength: 11,
                label: DefaultString.instance.registrationQIDPassport,
                keyboardType: TextInputType.name,
                inputFormatters: [NoSpaceInputFormatter()],

                onChanged: (value) {},
                validator: (value) => requiredTextValidator(value),
              ),
              UiSpace.vertical(16),
              UiTextField(
                controller: mobileController,
                label: DefaultString.instance.enterRegisteredMobileNumber,
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (value) {
                  // if (value.length >= 8) {
                  //   setState(() {});
                  // } else if (value.isEmpty) {
                  //   setState(() {});
                  // }
                },
                prefix: UiTextNew.customRubik(
                  "+974-",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
                  label: DefaultString.instance.nextTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
