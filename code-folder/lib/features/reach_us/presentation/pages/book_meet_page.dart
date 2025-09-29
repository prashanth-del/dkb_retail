import 'package:auto_route/annotations.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/utils.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/ui_components/auto_leading_widget.dart';
import '../../../common/dialog/custom_sheet.dart';
import '../widgets/book_meet_sheet.dart';
import '../widgets/custom_button.dart';
import '../widgets/select_branch_sheet.dart';
import '../widgets/service_type_widget.dart';
import '../widgets/suffix_dropdown_widget.dart';

@RoutePage(name: "BookAndMeetPageRoute")
class BookAndMeetPage extends StatefulWidget {
  const BookAndMeetPage({super.key});

  @override
  State<BookAndMeetPage> createState() => _BookAndMeetPageState();
}

class _BookAndMeetPageState extends State<BookAndMeetPage> {
  late TextEditingController serviceTypeController;
  late TextEditingController mobileNumberController;
  late TextEditingController branchController;
  bool isServiceTypeDropdownOpen = false;
  bool isBranchDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    serviceTypeController = TextEditingController();
    mobileNumberController = TextEditingController();
    branchController = TextEditingController();
    serviceTypeController.addListener(() => setState(() {}));
    mobileNumberController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    serviceTypeController.dispose();
    mobileNumberController.dispose();
    branchController.dispose();
  }

  DateTime? selectedDateTime;
  final times = [
    "08:00 AM",
    "08:30 PM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.white,
      appBar: UIAppBar.secondary(
        title: '',
        autoLeadingWidget: LeadingWidget(title: "Book and Meet"),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  UiTextField(
                    keyboardType: TextInputType.number,
                    controller: mobileNumberController,
                    label: "Mobile Number",
                    obscureText: false,
                  ),

                  SizedBox(height: 12),
                  UiTextField(
                    onTap: () {
                      setState(
                        () => isServiceTypeDropdownOpen = true,
                      ); // open state
                      CustomSheet.show(
                        context: context,
                        child: SelectTypeSheetWidget(
                          currentReason: serviceTypeController
                              .text, // 👈 pass current value
                          serviceTypeSelected: (val) {
                            if (val != null) {
                              serviceTypeController.text = val;
                              setState(() {
                                isServiceTypeDropdownOpen =
                                    false; // close after selecting
                              });
                            }
                          },
                        ),
                      ).then((_) {
                        setState(
                          () => isServiceTypeDropdownOpen = false,
                        ); // reset when closed
                      });
                    },
                    isReadOnly: true,
                    controller: serviceTypeController,
                    label: "Service Type",
                    suffix: SuffixCommonIcon(
                      isDropdown: isServiceTypeDropdownOpen,
                    ),
                  ),
                  SizedBox(height: 12),
                  UiTextField(
                    onTap: () {
                      setState(() => isBranchDropdownOpen = true); // open state
                      CustomSheet.show(
                        // barrierColor: Colors.white,
                        context: context,
                        heightSheet: context.mediaQuery.size.height - 80,
                        child: Container(
                          height: context.mediaQuery.size.height - 80,
                          child: SelectBranchSheetWidget(
                            currentReason:
                                branchController.text, // 👈 pass current value
                            serviceTypeSelected: (val) {
                              if (val != null) {
                                branchController.text = val;
                                setState(() {
                                  isBranchDropdownOpen =
                                      false; // close after selecting
                                });
                              }
                            },
                          ),
                        ),
                      ).then((_) {
                        setState(
                          () => isBranchDropdownOpen = false,
                        ); // reset when closed
                      });
                    },
                    isReadOnly: true,
                    controller: branchController,
                    label: "Select Branch",
                    suffix: SuffixCommonIcon(isDropdown: isBranchDropdownOpen),
                  ),
                  SizedBox(height: 12),
                  (branchController.text.isNotEmpty &&
                          branchController.text != null)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: DefaultColors.grayBase),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UiTextNew.customRubik(
                                    "Date",
                                    fontSize: 12,
                                    color: DefaultColors.grayBase,
                                  ),
                                  EasyDateTimeLinePicker(
                                    headerOptions: HeaderOptions(
                                      headerType: HeaderType
                                          .none, // removes month/year selector
                                    ),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030, 3, 18),
                                    focusedDate:
                                        selectedDateTime ?? DateTime.now(),
                                    onDateChange: (date) {
                                      selectedDateTime = date;
                                      setState(() {});
                                    },
                                    itemExtent: 55, // width of each day item
                                    timelineOptions: TimelineOptions(
                                      height: 70, // set item height here
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                    ),
                                  ),
                                  // EasyDateTimeLinePicker(
                                  //   //  currentDate: DateTime.now(),
                                  //   firstDate: DateTime.now(),
                                  //   lastDate: DateTime(2030, 3, 18),
                                  //   focusedDate: selectedDateTime ?? DateTime.now(),
                                  //   onDateChange: (date) {
                                  //     if (date != null) {
                                  //       selectedDateTime = date;
                                  //       print(selectedDateTime);
                                  //       setState(() {});
                                  //     }
                                  //     // Handle the selected date.
                                  //   },
                                  // ),
                                  SizedBox(height: 12),
                                  TimeSelectorWidget(times: times),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            CustomButtonNewWidget(
              onPress: () {
                if (serviceTypeController.text.isNotEmpty &&
                    branchController.text.isNotEmpty &&
                    mobileNumberController.text.isNotEmpty) {
                  CustomSheet.show(context: context, child: BookAndMeetSheet());
                }
              },
              title: "Next",
              buttonColor:
                  serviceTypeController.text.isNotEmpty &&
                      branchController.text.isNotEmpty &&
                      mobileNumberController.text.isNotEmpty
                  ? DefaultColors.blueBase
                  : DefaultColors.grayMedBase,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class TimeSelectorWidget extends StatefulWidget {
  final List<String> times;
  const TimeSelectorWidget({super.key, required this.times});

  @override
  State<TimeSelectorWidget> createState() => _TimeSelectorWidgetState();
}

class _TimeSelectorWidgetState extends State<TimeSelectorWidget> {
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.customRubik(
          "Time",
          fontSize: 12,
          color: DefaultColors.grayBase,
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8, // horizontal spacing
          runSpacing: 8, // vertical spacing
          children: widget.times.map((time) {
            final isSelected = time == selectedTime;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTime = time;
                });
              },
              child: Container(
                width: 63,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? DefaultColors.blueLightBase
                        : DefaultColors.grayLightBase,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: UiTextNew.customRubik(
                  time,
                  fontSize: 10,
                  color: isSelected
                      ? DefaultColors.blueLightBase
                      : DefaultColors.black,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
