import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/onboarding/presentation/controller/notifier/onboarding_retrieve_journey_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/asset_path/asset_path.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingSummaryPage extends ConsumerStatefulWidget {
  OnboardingSummaryPage({super.key});

  @override
  ConsumerState<OnboardingSummaryPage> createState() =>
      _OnboardingSummaryPageState();
}

class _OnboardingSummaryPageState extends ConsumerState<OnboardingSummaryPage> {
  List<bool> _isOpen = List.generate(6, (index) => false);
  // Track open state for each card
  final List<String> titles = [
    "Product Selection",
    "Basic Details",
    "Additional Info Details",
    "Personal/Residence/Mailing Address",
    "Work and Home Country/Residence/Mailing Address",
    "Financial Information",
  ];

  @override
  Widget build(BuildContext context) {
    final getSummaryData = ref.watch(
      getOnboardingRetrieveJourneyNotifierProvider,
    );
    final currentStage = getStageById(ref, "SUMMARY");

    return Scaffold(
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Summary",
        appBarColor: DefaultColors.white,
      ),
      body: getSummaryData.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const UiHeaderSubHeaderRetail(
                  title: "Confirm your Information",
                  description:
                      "After verifying your e-mail, you’ll receive this documentation in your inbox.",
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0.0,
                          vertical: 8.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 6.0,
                                spreadRadius: 1.0,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: UiTextNew.customRubik(
                                  titles[index],
                                  fontSize: 14,
                                ),
                                trailing: Icon(
                                  _isOpen[index]
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: DefaultColors.blue9D,
                                  size: 24,
                                ),
                                onTap: () {
                                  setState(() {
                                    _isOpen[index] = !_isOpen[index];
                                  });
                                },
                              ),
                              if (_isOpen[index])
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                  color: Colors.grey.shade50,
                                  child: _buildDetails(
                                    index,
                                    data.data.dataSummary![getTitleString(
                                      index,
                                    )]!,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ActionButtonWidget(
                  text: 'CONTINUE',
                  onPressed: () async {
                    bool value = await ref
                        .read(onboardingSaveStageDataNotifierProvider.notifier)
                        .fetch(
                          custJourneyId: ref.watch(customerJourneyId),
                          stageId: "${currentStage?.stageId}",
                          data: {"Summary": data},
                        );

                    if (value == true) {
                      context.router.push(OnboardingDocumentationRoute());
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
              ],
            ),
          );
        },
        error: (error, _) {
          // setHeaderVisibility(headerVisibility);
          // final i18Title = ref.getLocaleString("No_Records_Found",
          //     defaultValue: "No Records Found");
          final i18Title = "Data not loaded";
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
        },
        loading: () => Center(
          child: UiLoader(
            loadingText: ref.getLocaleString(
              "Loading",
              defaultValue: "Loading...",
            ),
          ),
        ),
      ),
    );
  }

  String getTitleString(int index) {
    switch (index) {
      case 0:
        // Logic for index 0
        return 'PRODUCTION_SELECTION';
      case 1:
        // Logic for index 1
        return 'IDENTIFICATION_DTL';
      case 2:
        // Logic for index 2
        return 'IDENTIFICATION_INFO';
      case 3:
        // Logic for index 3
        return 'IDENTIFICATION_RESIDENT';
      case 4:
        // Logic for index 3
        return 'IDENTIFICATION_ADDRESS';
      case 5:
        // Logic for index 3
        return 'FINANTIAL_DTL';

      default:
        // Fallback for any other index not explicitly handled
        return 'FINANTIAL_DTL';
    }
  }

  Widget _buildDetails(int index, Map<String, dynamic> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiTextNew.customRubik("${entry.key}: ", fontSize: 14),
              Expanded(
                child: Text(
                  entry.value.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // if (detail is Map<String, dynamic>) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: detail.entries.map((entry) {
  //       return Padding(
  //         padding: const EdgeInsets.only(bottom: 10),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "${entry.key}: ",
  //               style: const TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //             Expanded(
  //               child: Text(entry.value.toString(), softWrap: true),
  //             ),
  //           ],
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }
  //
  // return Text(details.toString());
}

Widget _setFormInputField(String label) {
  return UIFormTextField.outlined(
    hintText: label,
    borderColor: DefaultColors.grayE6,
    labelUiText: UiTextNew.h4Regular(label, color: DefaultColors.white_800),
    labelTextStyle: const TextStyle(
      fontSize: 14,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w500,
      color: DefaultColors.white_800,
    ),
  );
}
