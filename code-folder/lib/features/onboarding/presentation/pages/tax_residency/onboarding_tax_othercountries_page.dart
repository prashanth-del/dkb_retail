import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_button_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_header_subheader_retail.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../common/components/auto_leading_widget.dart';
import '../../../../common/dialog/ui_dialogs.dart';
import '../../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../../provider/onboarding_provider.dart';
import 'onboarding_country_selection_page.dart';

@RoutePage()
class OnboardingTaxOtherCountriesPage extends ConsumerStatefulWidget {
  @override
  _OnboardingTaxOtherCountriesPageState createState() =>
      _OnboardingTaxOtherCountriesPageState();
}

class _OnboardingTaxOtherCountriesPageState
    extends ConsumerState<OnboardingTaxOtherCountriesPage> {
  TextEditingController countryController = TextEditingController();

  List<String> countries = ['United States of America'];
  final List<String> allCountries = [
    "Jordan",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
  ];

  void addCountry() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Country'),
        content: TextField(
          controller: countryController,
          decoration: InputDecoration(hintText: 'Enter country name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                countries.add(countryController.text);
              });
              countryController.clear();
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void updateCountry(int index) {
    countryController.text = countries[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Country'),
        content: TextField(
          controller: countryController,
          decoration: InputDecoration(hintText: 'Enter country name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                countries[index] = countryController.text;
              });
              countryController.clear();
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void deleteCountry(int index) {
    setState(() {
      countries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "TAX_RESIDENCY2");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const UIAppBar.secondary(
        autoLeadingWidget: AutoLeadingWidget(),
        title: "Tax Residency",
        appBarColor: DefaultColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UiHeaderSubHeaderRetail(
              title: "Other Countries of Tax Residency",
              description:
                  "If you have any other countries of tax residency besides Qatar, add them below. You can add up to 4 countries.",
            ),
            const SizedBox(height: 15),
            // Row containing ListView and ADD COUNTRY button
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ListView.builder inside Flexible
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: UiTextNew.customRubik(
                              countries[index],
                              fontSize: 14,
                              color: DefaultColors.white_800,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                    AssetPath.icon.onboardingEditIcon,
                                  ),
                                  onPressed: () => updateCountry(index),
                                ),
                                if (index != 0)
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      AssetPath.icon.onboardingDeleteIcon,
                                    ),
                                    onPressed: () => deleteCountry(index),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),

                    ActionButtonWidget(
                      text: 'ADD COUNTRY',
                      textColor: DefaultColors.blue9D,
                      buttonColor: DefaultColors.blue_02,
                      onPressed: () {
                        showCountrySelectionBottomSheet();
                        // context.router.push(OnboardingTaxOtherCountriesRoute());
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16.0),
            ActionButtonWidget(
              text: 'CONTINUE',
              onPressed: () async {
                bool value = await ref
                    .read(onboardingSaveStageDataNotifierProvider.notifier)
                    .fetch(
                      custJourneyId: ref.watch(customerJourneyId),
                      stageId: "${currentStage?.stageId}",
                      data: {"Other_Countries_Tax_Residency": countries},
                    );

                if (value == true) {
                  _showDialogForConfirm();
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
      ),
    );
  }

  void showCountrySelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CountrySelectionBottomSheet(
          allCountries: allCountries,
          selectedCountries: countries,
          onSelectionChanged: (updatedSelection) {
            setState(() {
              countries = updatedSelection;
            });
          },
        );
      },
    );
  }

  void _showDialogForConfirm() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        children: [
          // const UiSpace.vertical(10),
          SvgPicture.asset(
            AssetPath
                .icon
                .onboardingErrorIcon, // Replace with the actual image path
            height: 100,
            width: 100,
            alignment: Alignment.center,
          ),
          const UiSpace.vertical(20),
          const UiHeaderSubHeaderRetail(
            alignment: TextAlign.center,
            title:
                "Are you sure you don’t have an additional country of Tax Residence?",
            description:
                "Please note that by providing incorrect/incomplete/false tax residency information, the account opening proceed may lead to delays or even closure of the account.",
          ),

          const UiSpace.vertical(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ActionButtonWidget(
                  text: 'NO, GO BACK',
                  textColor: DefaultColors.blue9D,
                  buttonColor: DefaultColors.blue_02,
                  onPressed: () {
                    context.router.maybePop();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ActionButtonWidget(
                  text: 'YES, CONTINUE',
                  onPressed: () {
                    context.router.maybePop();
                    context.router.push(OnboardingTaxHomeCountryRoute());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
