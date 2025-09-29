import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/src/components/retail/ui_label_dropdown_retail.dart';
import 'package:db_uicomponents/src/components/retail/ui_radio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../../../common/dialog/ui_dialogs.dart';
import '../controller/notifier/onboarding_save_stage_data_notifier.dart';
import '../provider/onboarding_provider.dart';

@RoutePage()
class OnboardingSelectBranchPage extends ConsumerStatefulWidget {
  const OnboardingSelectBranchPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingSelectBranchPage> createState() => _OnboardingSelectBranchPageState();
}

class _OnboardingSelectBranchPageState extends ConsumerState<OnboardingSelectBranchPage> {
  String selectedAccountType = "savings"; // Default selected value
  int _selectedIndex = 0;

  TextEditingController currencyController = TextEditingController();

   String selectedBranch = "";

  final List<String> branches = [
    "Please Select",
    "Dukhan Bank - City Center Branchggggggggggggggggggggggggggggggggggggggggggggggggg",
    "Dukhan Bank - City Center Branch 1",
    "Dukhan Bank - City Center Branch 2",
    "Dukhan Bank - City Center Branch 3",
  ];

  @override
  void dispose() {
    // Dispose the TextEditingController to free up resources.
    currencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = getStageById(ref, "PRODUCTION_SELECTION");

    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: const Color(0xFFF0F0F3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [ Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reusable AccountOption widget
                  const UiTextNew.customRubik(
                    "Select Dukhan Bank Product",
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20,),

                  const UiTextNew.customRubik(
                    "Product Type",
                    fontSize: 16,
                    color: DefaultColors.white_800,
                  ),

                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the text field
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF6E80B8)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Color(0xFF6E80B8).withOpacity(0.1),
                      //     spreadRadius: 0.5,
                      //     blurRadius: 6,
                      //     offset: const Offset(0, 4), // Shadow direction
                      //   ),
                      // ],
                    ),
                    padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 11),
                    child: Column(
                      children: [

                        // const SizedBox(height: 16),
                        AccountSelector(
                          options: _options,
                          selectedIndex: _selectedIndex,
                          onChanged: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  _buildBranchListUi(context),
                  SizedBox(height: 20,),

                ],
              ),
            ),
          ),
            // Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: UIButton.rounded(
                label: 'CONTINUE',
                maxWidth: double.maxFinite,
                isDisabled: selectedBranch.isEmpty && currencyController.text.isEmpty ,
                onPressed: ()async {
                  // ref.read(isSubmittedRequestProvider.notifier).state = false;
                  //
                  bool value = await ref.read(onboardingSaveStageDataNotifierProvider.notifier).fetch(
                      custJourneyId: ref.watch(customerJourneyId),
                      stageId: "${currentStage?.stageId}",
                      data: {
                        "Product_Type": _selectedIndex != 0 ? "Current Account" : "Savings Account",
                        "Branch_Selected" : selectedBranch.isEmpty ? currencyController.text : selectedBranch,
                      });
                  if(value == true) {
                    context.router.push(OnboardingIdentificationRoute());
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
            )
            ]
        ),
      ),
    );
  }
  Widget _buildBranchListUi (BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(branches.length > 5)
          UIFormTextField.outlined(
            hintText: "Please Select",
            labelHintTextStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                fontFamily: 'Rubik',
                color: DefaultColors.grayB3
            ),
            borderColor: DefaultColors.grayE6,
            labelUiText: UiTextNew.h4Regular(
              "Branch List",
              color: DefaultColors.white_800,
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value == "Please Select") {
                return "This field is required";
              }
              return null;
            },
            controller: currencyController,
            suffixIcon: IconButton(onPressed: (){
              _showBranchBottomSheet(context);
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              //   ),
              //   builder: (context) {
              //     return CountrySelectionBottomSheet(
              //       allCountries: branches,
              //       selectedCountries: [],
              //       isCheckBoxNotShown: "true",
              //       bottomButtonNotShown: "true",
              //       onSelectionChanged: (updatedSelection) {
              //         setState(() {
              //           // countries = updatedSelection;
              //         });
              //       },
              //     );
              //   },
              // );

            },
                icon: Icon(Icons.keyboard_arrow_down, color: DefaultColors.blue9D, size: 30,)),
            labelTextStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                color: DefaultColors.white_800
            ),
          ),



        if(branches.length <= 5)
          UiLabelDropdownRetail(
            label: "Branch List",
            options: branches,
            onChanged: (String? value) {
              setState(() {
                selectedBranch = ((value == 'Please Select') ? '' : value)!;
              });
            },
          ),

      ],
    );
  }

  void _showBranchBottomSheet (BuildContext context) {
    return  UiBottomSheet.customSheet(
      showBottomButton: false,
      context: context,
      title: "Branch List",
      child: _buildBranchList(),
    );

  }

  Widget _buildBranchList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          UiSearch(),
          SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
              itemCount: branches.length,
              // physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final list = branches[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: DefaultColors.grayE6.withOpacity(0.3),
                          //Color(0xFFECE6F0)
                          borderRadius: BorderRadius.circular(8),
                        ),
                      child: UiTextNew.customRubik(
                         list,
                        fontSize: 16,
                        color: DefaultColors.black,
                      ),
                        ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        currencyController.text = list == 'Please Select' ? '' : list;
                      });
                    },
                  ), // Render each transaction tile
                );
              },
            ),
          )


        ],
      ),
    );
  }

}


// Build the app bar
UIAppBar _buildAppBar() {
  return const UIAppBar.secondary(
    title: "Product Selection",
    autoLeadingWidget: const AutoLeadingWidget(),
    iconWidth: 20,
    iconHeight: 20,
  );
}

final List<AccountOption> _options = [
  AccountOption(
    title: "Savings Account",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec quam a urna egestas mattis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec quam a urna egestas mattis. ",
  ),
  AccountOption(
    title: "Current Account",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nec quam a urna egestas mattis. dipiscing elit. Morbi nec quam a urna egestas mattis.",
  ),
];

