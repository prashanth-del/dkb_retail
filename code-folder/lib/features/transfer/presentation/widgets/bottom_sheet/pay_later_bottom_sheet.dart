import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/features/beneficiary/presentation/widgets/bottomSheet/view_bottom_sheet.dart';
import 'package:dkb_retail/features/common/styles/ui_text_styles.dart';
import 'package:dkb_retail/features/transfer/data/model/transfer_model.dart';
import 'package:dkb_retail/features/transfer/presentation/provider/transfer_provider.dart';
import 'package:dkb_retail/features/transfer/presentation/widgets/bottom_sheet/confirm_transaction_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class PayLaterBottomSheet extends ConsumerStatefulWidget {
  @override
  _PayLaterBottomSheetState createState() => _PayLaterBottomSheetState();
}

class _PayLaterBottomSheetState extends ConsumerState<PayLaterBottomSheet> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  String? repeatOption;
  int numberOfTransfers = 1;
  final TextEditingController calendarController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  void _changeMonth(int offset) {
    setState(() {
      focusedDate = DateTime(focusedDate.year, focusedDate.month + offset, 1);
    });
  }

  void _changeYear(int offset) {
    setState(() {
      focusedDate = DateTime(focusedDate.year + offset, focusedDate.month, 1);
    });
  }
  List<String> options = ['Daily', 'Weekly', 'Monthly'];
  String? selectedOption = 'Daily';
  bool _isSelected = false;
  bool _isCalendar=false;
  bool _isRadio=true;

  @override
  Widget build(BuildContext context) {
    final selectedTransfer = ref.watch(selectedTransferProvider);
    Map<String, List<Map<String, String>>> transactionDetails = TransactionHelper.getTransactionDetails(selectedTransfer,isSendLater: true);

    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            title: UiTextNew.b1Semibold("Pay Later"),
            trailing: UIIconContainer(icon: Icons.close,color: DefaultColors.transparent,iconColor: DefaultColors.black,iconSize: 18,onTap: () {
              context.router.maybePop();
            },),
          ),
          const Divider(color: DefaultColors.blue_02,
            thickness: 1,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [

                UiSpace.vertical(10),
                _buildInput(
                  label: "Select Payment Date",
                  hint: "dd/mm/yyyy ",
                  controller: calendarController,
                  isDropdown: true,
                  isEnabled: false,

                  ),
                UiSpace.vertical(10),
                if(_isCalendar)
                UiCard(
                  borderColor: DefaultColors.grayE6,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              UISvgIcon(
                               onTap: (){
                                 _changeYear(-1);
                               },
                              assetPath: SvgAssets().double_arrow_left),
                              UiSpace.horizontal(10),
                              UISvgIcon(
                                  onTap: (){
                                    _changeMonth(-1);
                                  },
                                  assetPath: SvgAssets().chevron_left),
                            ],
                          ),

                          UiTextNew.custom(
                            DateFormat('MMMM yyyy').format(focusedDate),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: DefaultColors.gray54,
                          ),
                          Row(
                            children: [
                              UISvgIcon(
                                  onTap: (){
                                    _changeMonth(1);
                                  },
                                  assetPath: SvgAssets().chevron_right),
                              UiSpace.horizontal(10),
                              UISvgIcon(
                                  onTap: (){
                                    _changeYear(1);
                                  },
                                  assetPath: SvgAssets().double_arrow_right),
                            ],
                          ),

                        ],
                      ),
                      UiSpace.vertical(10),
                      TableCalendar(
                        focusedDay: focusedDate,
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        calendarFormat: CalendarFormat.month,
                        headerVisible: false,
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedDate, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            selectedDate = selectedDay;
                            this.focusedDate = focusedDay;
                            calendarController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                          });
                        },
                        onPageChanged: (newFocusedDate) {
                          setState(() {
                            focusedDate = newFocusedDate;
                          });
                        },
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: DefaultColors.gray54,
                          ),
                          weekendStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: DefaultColors.gray54,
                          ),
                          dowTextFormatter: (date, locale) {
                            return DateFormat.E(locale).format(date).substring(0, 1); // Extracts first letter
                          },
                        ),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: DefaultColors.primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          defaultTextStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: DefaultColors.gray2D,
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                UiSpace.vertical(10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: DefaultColors.blue01,
                            width: 1,
                          ),
                        ),
                        child: _isSelected
                            ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: DefaultColors.blue01,
                            ),
                          ),
                        )
                            : null,
                      ),
                    ),
                    UiSpace.horizontal(10),
                    UiTextNew.h4Regular(
                      _isSelected?"Repeat Transfers":"Repeat Transfers?",
                      color: _isSelected?DefaultColors.primaryBlue: DefaultColors.gray2D,
                    ),
                  ],
                ),

                if(_isSelected)...{

                UiSpace.vertical(10),
                _buildInput(
                  label: "Number of Transfers",
                  hint: "Please Enter",
                  controller: countController,
                ),
                UiSpace.vertical(10),
                Row(
                  children: [
                    UiTextNew.custom(
                      "When to transfer?",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: DefaultColors.black,
                    ),
                  ],
                ),
                  UiSpace.vertical(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: options.map((option) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = option;
                        });
                      },
                      child: UiCard(
                        cardColor: selectedOption == option
                            ? DefaultColors.bluelight04
                            : DefaultColors.white,
                        borderColor: selectedOption == option
                            ? DefaultColors.primaryBlue
                            : DefaultColors.grayB3,
                        child: Container(
                          width: 100,
                          height: 30,
                          child: Center(
                            child: UiTextNew.b3Regular(
                              option,
                              color: selectedOption == option
                                  ? DefaultColors.primaryBlue
                                  : DefaultColors.grayB3,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),},
                UiSpace.vertical(10),
                Row(
                  children: [
                    Expanded(
                      child: UIButton.rounded(
                        backgroundColor: DefaultColors.blue60,
                        onPressed: (){
                          Navigator.pop(context);
                          viewBottomSheet(
                              context: context,
                              title: "Confirm Transactions",
                              heightPercentage: 0.5,
                              child: ConfirmTransactionSheet(
                                isConfirm: true,
                                transactionDetails:  transactionDetails,
                              )
                          );
                        },
                        height: 40,
                        label: "SUBMIT",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _buildInput(
      {required String label,
        required String hint,
        required TextEditingController controller,
        bool isDropdown = false,
        bool isEnabled = true,
        ValueChanged<String>? onChanged,
        int maxLines = 1,
        VoidCallback? onReset,
        Widget sheetWidget = const SizedBox.shrink()}) {
    TextStyle? textStyle = UiTextStyles.uiInfoTitleSmallBold(context)
        ?.copyWith(color: DefaultColors.gray2D);


    bool fieldEnabled = !isEnabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIFormTextField.outlined(
          borderColor: DefaultColors.grayE6,
          labelUiText: UiTextNew.b2Semibold(label),
          readOnly: fieldEnabled,
          hintText: hint,
          validator: (value) {
          },
          onChanged: (value) {
          },
          textStyle: textStyle,
          controller: controller,
          onTap: () {
            if (isDropdown) {
              setState(() {
                _isCalendar =!_isCalendar;
              });

            }
          },
          suffixIcon: isDropdown
              ? Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: UISvgIcon(
                assetPath: SvgAssets().calendar,color: DefaultColors.primaryBlue,))
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
