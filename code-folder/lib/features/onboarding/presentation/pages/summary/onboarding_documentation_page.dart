import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_input_field_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';
import '../../widget/builf_info_row_message.dart';

@RoutePage()
class OnboardingDocumentationPage extends ConsumerStatefulWidget {
  const OnboardingDocumentationPage({super.key});

  @override
  ConsumerState<OnboardingDocumentationPage> createState() =>
      _OnboardingDocumentationPageState();
}

class _OnboardingDocumentationPageState
    extends ConsumerState<OnboardingDocumentationPage> {
  bool isCheckBoxEnabled = false;
  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "DOC_T&C");

    return Scaffold(
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Documentation",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UiHeaderSubHeaderRetail(
                  title: "Documentation",
                  description:
                      "Read and agree the documents below regarding the opening of your Dukhan Bank account.",
                ),

                const SizedBox(height: 20),
                buildInfoMessage1(),
                // const Spacer(),
                // _buildAgreeNotes(context),
                // const SizedBox(height: 20,),
                // _buildSendCodeButton(context),
              ],
            ),
            Spacer(),
            _buildAgreeNotes(context),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,

              child: UIButton.rounded(
                label: 'CONTINUE',
                width: double.infinity,
                isDisabled: !isCheckBoxEnabled,
                onPressed: () async {
                  bool value = await ref
                      .read(onboardingSaveStageDataNotifierProvider.notifier)
                      .fetch(
                        custJourneyId: ref.watch(customerJourneyId),
                        stageId: "${currentStage?.stageId}",
                        data: {"Documentation & Terms and conditions": "YES"},
                      );

                  if (value == true) {
                    context.router.push(OnboardingSignatureRoute());
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
      ),
    );
  }

  Widget _buildAgreeNotes(BuildContext context) {
    return UiAgreeNotes(
      agreeNoteActive: true,
      text: "I agree to terms & conditions",
      substringIndex: 10,
      onUserAgreed: (_) {
        setState(() {
          isCheckBoxEnabled = !isCheckBoxEnabled;
        });
      },
      openTermsAndConditions: () {},
    );
  }
}

Widget _buildHeaderText() {
  return const UiTextNew.customRubik(
    "Insert QID & Phone Number",
    fontSize: 18,
    color: Colors.black,
  );
}

Widget _buildInputField(String label) {
  return UIInputFieldRetail.underlined(
    hintText: label,
    label: label,
    height: 65,
  );
}

Widget buildInfoMessage1() {
  return Container(
    color: const Color(0xFFFEFDED),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRowMessage(" •  ", "The Terms & Conditions for the Account"),
        buildInfoRowMessage(
          " •  ",
          "The Terms & Conditions for the Debit Card",
        ),
        buildInfoRowMessage(
          " •  ",
          "The Terms & Conditions for the Dukhan Bank Mobile Banking Services",
        ),
        buildInfoRowMessage(" •  ", "The Terms & Conditions in general."),
      ],
    ),
  );
}
