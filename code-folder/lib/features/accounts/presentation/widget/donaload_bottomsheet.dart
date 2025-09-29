import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/features/accounts/presentation/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constants/colors.dart';

class DownloadStatementBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime? _startDate;
    DateTime? _endDate;

    void _showDatePicker(
      BuildContext context,
      ValueChanged<DateTime> onDateSelected, {
      DateTime? initialDate,
    }) {
      showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 3)),
        lastDate: DateTime.now(),
      ).then((selectedDate) {
        if (selectedDate != null) {
          onDateSelected(selectedDate);
        }
      });
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UiTextNew.customRubik(
                "Download Statement",
                color: DefaultColors.black15,
                fontSize: 18,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          const Divider(height: 10.0, color: DefaultColors.grey),
          const SizedBox(height: 16),

          // Date Picker Row
          Row(
            children: [
              // From Date Input
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _showDatePicker(context, (date) {
                      _startDate = date;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _startDate != null
                              ? _startDate.toString().split(' ')[0]
                              : "From",
                        ),
                        const Icon(Icons.calendar_today, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // To Date Input
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _showDatePicker(context, (date) {
                      _endDate = date;
                    }, initialDate: _startDate);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _endDate != null
                              ? _endDate.toString().split(' ')[0]
                              : "To",
                        ),
                        const Icon(Icons.calendar_today, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Send Mail Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // Updated radius
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                      ),
                      builder: (_) => EmailStatementBottomSheet(),
                    );
                  },
                  child: UiTextNew.h5Regular(
                    "SEND MAIL",
                    color: DefaultColors.blue88,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Download Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.blue9C, // Changed to blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // Updated radius
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return DynamicPopup(
                          title: "Success",
                          message: "Account Statement downloaded successfully",
                          imagePath:
                              "assets/images/successIcon.jpeg", // Replace with your dynamic image path
                          onDismiss: () => Navigator.of(context).pop(),
                          onView: () {
                            Navigator.of(context).pop();
                            // Add your "view" action here
                          },
                        );
                      },
                    );
                  },
                  child: UiTextNew.h5Regular(
                    "DOWNLOAD",
                    color: DefaultColors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Note Section
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Colors.black54, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: UiTextNew.h5Regular(
                  'Transactions can be viewed up to 1 year.\nMaximum transaction period at once is 3 months.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class EmailStatementBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row with Cross Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const UiTextNew.customRubik(
                "Email Statement",
                color: DefaultColors.black,
                fontSize: 18,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: const Icon(Icons.close, color: DefaultColors.gray54),
              ),
            ],
          ),
          const Divider(height: 30.0, color: DefaultColors.grey),

          // Static Data Fields
          const UiTextNew.h4Regular(
            "Account Holder Name",
            color: DefaultColors.gray54,
          ),
          const UiTextNew.customRubik(
            "VINOD ANAND ANAND VIHAR VINOD ANAND",
            color: DefaultColors.white_800,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),

          const UiTextNew.h4Regular(
            "Account Number",
            color: DefaultColors.gray54,
          ),
          const UiTextNew.customRubik(
            "202-1207053-1-10-0",
            color: DefaultColors.white_800,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),

          const UiTextNew.h4Regular(
            "Account Type",
            color: DefaultColors.gray54,
          ),
          const UiTextNew.customRubik(
            "Current Account",
            color: DefaultColors.white_800,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 12),

          const UiTextNew.h4Regular("Email ID", color: DefaultColors.gray54),
          const UiTextNew.customRubik(
            "Mohammed2456@gmail.com",
            color: DefaultColors.white_800,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: UiTextNew.h5Regular(
                    "CANCEL",
                    color: DefaultColors.blue9B,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Send Email Button
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.blue9B,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return DynamicPopup(
                          title: "Success",
                          message:
                              "Account Statement sent successfully to Mohammed2456@gmail.com",
                          imagePath:
                              "assets/images/successIcon.jpeg", // Replace with your dynamic image path
                          onDismiss: () => Navigator.of(context).pop(),
                          onView: () {
                            Navigator.of(context).pop();
                            // Add your "view" action here
                          },
                        );
                      },
                    );
                  },
                  child: UiTextNew.h5Regular(
                    "SEND EMAIL",
                    color: DefaultColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
