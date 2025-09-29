import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/onboarding/presentation/controller/notifier/onboarding_block_journey_notifier.dart';
import 'package:dkb_retail/features/onboarding/presentation/provider/onboarding_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../controller/notifier/onboarding_file_upload_notifier.dart';
import '../controller/notifier/onboarding_save_stage_data_notifier.dart';

@RoutePage()
class OnboardingVerifyIdentificationPage extends ConsumerWidget {
  const OnboardingVerifyIdentificationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentStage = getStageById(ref, "IDENTIFICATION_SCAN_SUM");
    final fileUploadData = ref.watch(getOnboardingFileUploadNotifierProvider);


    ref.listen(onboardingBlockJourneyNotifierProvider, (previous, next) {
      next.maybeWhen(
        data: (response) {
          // Handle successful response
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
          context.router.replace(LoginRoute());
        },
        error:(error, stackError) =>
            UiDialogs.showErrorDialog(
              context: context,
              description: "$error",
              bknOkPressed: () {
                context.router.maybePop();
              },
            ),
        loading: () {
          // Optionally handle loading state
          Center(
              child: UiLoader(
                  loadingText: ref.getLocaleString("Loading",
                      defaultValue: "Loading...")));
        },
        orElse: () {},
      );
    });
    //


    return Scaffold(
      appBar: UIAppBar.secondary(title: "Identification", autoLeadingWidget: null),
      body: fileUploadData.when(
          data: (data) {
            // QidDetails details = data;
            return Container(
              color: const Color(0xFFF0F0F3),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UiTextNew.customRubik(
                    'Identify Verification',
                    color: DefaultColors.black,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 8),
                  const UiTextNew.h4Regular(
                    'Confirm if all the information below is correct.\nIf not, scan again.',
                    color: DefaultColors.white_800,
                  ),
                  const SizedBox(height: 32),

                  // Info fields
                  _buildInfoField('Full Name', "${data.data["fullName"]}"),
                  _buildInfoField('QID Number', "${data.data["QIDNumber"]}"),
                  _buildInfoField('Expiration Date', "${data.data["expirationDate"]}"),
                  _buildInfoField('Date of Birth', "${data.data["dateOfBirth"]}"),
                  _buildInfoField('Nationality', "${data.data["Nationality"]}"),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ActionButtonWidget(
                          text: 'SCAN AGAIN',
                          textColor: DefaultColors.blue9D,
                          buttonColor: DefaultColors.blue_02,
                          onPressed: () {
                            int scanAttempts = ref.watch(scanAgainAttemptsProvider) + 1;
                            if(scanAttempts >= 6) {

                              ref.read(scanAgainAttemptsProvider.notifier).state = 0;
                              ref.read(onboardingBlockJourneyNotifierProvider.notifier).fetch(
                                  mobileNumber: ref.watch(getMobileNumber),
                                  blockPeriod: "${ref.watch(customerJourneyId)}",
                                  nationalId: ref.watch(getQidNumber),
                                  blockReason: "QID Scan");
//block
                            } else {
                              ref
                                  .read(scanAgainAttemptsProvider.notifier)
                                  .state = scanAttempts;
                              context.router.maybePop();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ActionButtonWidget(
                          text: 'CONFIRM',
                          onPressed: ()async {
                            // ref.read(isSubmittedRequestProvider.notifier).state = false;
                            //
                            bool value = await ref.read(onboardingSaveStageDataNotifierProvider.notifier).fetch(
                                custJourneyId: ref.watch(customerJourneyId),
                                stageId: "${currentStage?.stageId}",
                                data: {
                                 "fullName" : "${data.data["fullName"]}",
                                  'QIDNumber' : "${data.data["QIDNumber"]}",
                                  'expirationDate': "${data.data["expirationDate"]}",
                                  'dateOfBirth': "${data.data["dateOfBirth"]}",
                                  'Nationality': "${data.data["Nationality"]}"
                                });
                            if(value == true) {
                              context.router.push(OnboardingVerifyIdentifySelfieRoute());
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

          }
      ,
      error: (error, _) {
        // setHeaderVisibility(headerVisibility);
        // final i18Title = ref.getLocaleString("No_Records_Found",
        //     defaultValue: "No Records Found");
        final i18Title = ref.getLocaleString(
            "Data_not_loaded",
            defaultValue: "Data not loaded");
        return Column(
          children: [
            const UiSpace.vertical(20),
            UINoContent(
              lottieAsset: AssetPath.lottie.empty,
              animHeight: 30,
              showHeight: false,
              title: i18Title,
              // description: i18Description,
            ),
            const UiSpace.vertical(20),
          ],
        );
      }, loading: () =>
          Center(
              child: UiLoader(
                  loadingText: ref.getLocaleString("Loading",
                      defaultValue: "Loading..."))),
      )     );
  }

  Widget _buildInfoField(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           UiTextNew.h4Regular(
            title,
            color: DefaultColors.white_800,

          ),
          const SizedBox(height: 4),
          UiTextNew.customRubik(
            value,
            fontSize: 16,
            color: DefaultColors.white_800,

          ),
        ],
      ),
    );
  }
}
