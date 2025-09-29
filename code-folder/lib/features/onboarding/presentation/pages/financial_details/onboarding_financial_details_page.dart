import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../common/components/auto_leading_widget.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';

import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingFinancialDetailsPage extends ConsumerStatefulWidget {
  const OnboardingFinancialDetailsPage({super.key});

  @override
  ConsumerState<OnboardingFinancialDetailsPage> createState() => _OnboardingFinancialDetailsPageState();
}

class _OnboardingFinancialDetailsPageState extends ConsumerState<OnboardingFinancialDetailsPage> {
  String selectedOption = 'Loan';

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "FINANTIAL_DTL2");

    return Scaffold(
        appBar: const UIAppBar.secondary(
          autoLeadingWidget: AutoLeadingWidget(),
          title: "Financial",
          appBarColor: DefaultColors.white,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              const UiHeaderSubHeaderRetail(
                title: "Financial Details",
                description: "What is your main purpose for using the account?",
              ),
              SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRadioOption('Loan'),
                  buildRadioOption('Savings'),
                  buildRadioOption('Transfer outside Qatar'),
                  buildRadioOption('Investment'),
                  buildRadioOption('Received Salary'),
                  buildRadioOption('Credit Facilities'),
                  buildRadioOption('Other'),
                ],
              ),
          Spacer(),
          ActionButtonWidget(text: 'CONTINUE', onPressed: ()async {
            bool value = await ref.read(
                onboardingSaveStageDataNotifierProvider.notifier).fetch(
                custJourneyId: ref.watch(customerJourneyId),
                stageId: "${currentStage?.stageId}",
                data: {
                  "Financial_details": selectedOption,
                });

            if (value == true) {
              context.router.push(OnboardingProminentFormRoute());

            } else {
              UiDialogs.showErrorDialog(
                context: context,
                description: "Data Not Saved",
                bknOkPressed: () {
                  context.router.maybePop();
                },
              );
            }

          },
          )

            ],
          ),
        )
    );
  }
  Widget buildRadioOption(String title) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Radio<String>(
            value: title,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),
          UiTextNew.h5Regular(
            title,
            color: DefaultColors.black,
          ),
        ],
      ),
    );
  }


}


