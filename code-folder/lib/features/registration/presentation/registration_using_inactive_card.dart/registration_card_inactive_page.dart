import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/extensions/context_extension.dart';
import 'package:dkb_retail/features/common/presentation/components/auth_header_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegistrationCardInactivePage extends ConsumerWidget {
  const RegistrationCardInactivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AuthHeaderWrapper(
        headerText: DefaultString.instance.registrationCard,

        child: SizedBox(
          height: context.height(90),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: UiTextNew.custom(
                  DefaultString.instance.oopsYourCardIsInactive,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              Center(
                child: UiTextNew.b1Regular(
                  DefaultString.instance.cardInactiveMessage,
                  textAlign: TextAlign.center,
                ),
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
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.push(CreatePinRoute());
                  },
                  label: DefaultString.instance.activateNow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
