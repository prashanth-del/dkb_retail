import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/components/auto_leading_widget.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingWelcomePage extends ConsumerWidget {
  const OnboardingWelcomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStageIndex = ref.watch(currentStageProvider); // Current stage index
    final stageDataProvider = ref.watch(stageSumProvider);
    final currentStage = getStageById(ref, "OPEN_NEW_ACC_REQ");
    // final currentStage = getStageByPriority(ref, currentStageIndex);

    // ref.listen(onboardingSaveStageDataNotifierProvider, (previous, next) {
    //   if(!(ref.watch(isSubmittedRequestProvider))) {
    //     next.maybeWhen(
    //       data: (response) {
    //         // Handle successful response
    //         ref
    //             .read(isSubmittedRequestProvider.notifier)
    //             .state = true;
    //
    //         context.router.push(OnboardingDetailsRoute());
    //       },
    //       error: (error, stackError) =>
    //           UiDialogs.showErrorDialog(
    //             context: context,
    //             description: "$error",
    //             bknOkPressed: () {
    //               context.router.maybePop();
    //             },
    //           ),
    //       loading: () {
    //         // Optionally handle loading state
    //         Center(
    //             child: UiLoader(
    //                 loadingText: ref.getLocaleString("Loading",
    //                     defaultValue: "Loading...")));
    //       },
    //       orElse: () {},
    //     );
    //   }
    // });

    return  Scaffold(
      appBar: const UIAppBar.secondary(
        autoLeadingWidget:  AutoLeadingWidget(),
        title: "Open New Account",
        appBarColor: DefaultColors.white,
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    const UiTextNew.customRubik(
                      'Welcome to New Digital Account Opening from Dukhan Bank',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      child: Column(
                        children: [
                          const UiTextNew.customRubik(
                            'Before we begin the simple steps to open Saving account, please make sure that you have the below documentation handy,',
                            fontSize: 14,
                            color: DefaultColors.white_800,
                          ),
                          const SizedBox(height: 20,),
                          _buildRow('1.  ', 'Are you a Qatari or a Qatar resident with valid ID?'),
                          _buildRow('2.  ', 'You are above the age of 18'),
                          _buildRow('3.  ', 'You have a valid passport (Expatriates only)'),
                          _buildRow('4.  ', 'Salary certificate from your Employer (For current account only)'),
                          _buildRow('5.  ', 'A document with your signature as per passport'),
                          _buildRow('6.  ', 'Tax residency information'),
                          _buildRow('7.  ', 'Proof of Address'),
                          _buildRow('8.  ', 'A smiley face...!'),

                          // Spacer(),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: UIButton.rounded(onPressed: () async {
                bool value = await ref.read(onboardingSaveStageDataNotifierProvider.notifier).fetch(
                    custJourneyId: ref.watch(customerJourneyId),
                    stageId: "${currentStage?.stageId}",
                    data: {
                      "requirements": "${currentStage?.stageDesc}"
                    });
                if(value) {
                  context.router.push(const OnboardingDetailsRoute());
                }else {
                  UiDialogs.showErrorDialog(
                    context: context,
                    description: "Data Not Saved",
                    bknOkPressed: () {
                      context.router.maybePop();
                    },
                  );
                }
              }, label: 'Next',maxWidth: context.screenWidth,height: 45,),
            ),
          ],
        ),
      ),
    );
  }
}



Widget _buildRow(String text1, String text2) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      UiTextNew.h4Regular(
        text1,
        color: DefaultColors.white_800,// Bold number with period
      ),
      // const SizedBox(width: 8), // Space between number and text
      Expanded(
        child: Wrap(
            children:[
              UiTextNew.h4Regular(
                text2,
                color: DefaultColors.white_800,// Bold number with period
              ),
            ]
        ),
      ),
    ],
  );
}