import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegistrationCardInactivePage extends ConsumerWidget {
  const RegistrationCardInactivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: UiBackgroundWrapper(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: UiTextNew.h1Semibold(
                    'You card is inactive\nKindly activate your\ncard to register',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                UiSpace.vertical(40),
                CommonAuthAppBar(title: 'Register'),
              ],
            ),
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
                  backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.push(CreatePinRoute());
                  },
                  label: 'Activate Now',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
