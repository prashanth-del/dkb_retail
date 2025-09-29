import 'package:db_uicomponents/components.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class RecentTabContent extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> transactions;

  const RecentTabContent({
    super.key,
    required this.title,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiTextNew.customRubik(
          title,
          fontSize: 15,
          fontWeight: FontWeight.normal,
        ),
        const UiSpace.vertical(5),
        ListView.builder(
          shrinkWrap: true,
          itemCount: transactions.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TransactionTile(
                  title: transaction['title'],
                  date: transaction['date'],
                  amount: transaction['amount'],
                  isCredit: transaction['isCredit'],
                ),
              ),
            );
          },
        ),
        DottedLine(),
      ],
    );
  }
}

class DateTabContent extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const DateTabContent({Key? key, required this.transactions})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? _startDate;
    DateTime? _endDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // From and To Date Inputs
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              // From Date Input
              Expanded(
                child: DatePickerContainer(
                  yearCount: 3,
                  label: "From",
                  suffixIcon: const Icon(Icons.calendar_today),
                  onDateSelected: (date) {
                    _startDate = date;
                    if (_endDate != null && _startDate != null) {
                      // Perform actions if both dates are selected
                    }
                  },
                  selectedDate: null,
                ),
              ),
              const SizedBox(width: 8),

              // To Date Input
              Expanded(
                child: DatePickerContainer(
                  yearCount: 3,
                  label: "To",
                  suffixIcon: const Icon(Icons.calendar_today),
                  initialDate: _startDate,
                  onDateSelected: (date) {
                    _endDate = date;
                    if (_startDate != null && _endDate != null) {
                      // Perform actions if both dates are selected
                    }
                  },
                  selectedDate: null,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Note Section Below Date Inputs
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            color: const Color(0xFFFEFDED),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
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
        ),

        // Transactions List Section
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? Colors.grey.withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TransactionTile(
                    title: transaction['title'],
                    date: transaction['date'],
                    amount: transaction['amount'],
                    isCredit: transaction['isCredit'],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isCredit;

  const TransactionTile({
    Key? key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isCredit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show BottomSheet on click
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          backgroundColor: Colors.white, // Set the background color to white
          isScrollControlled: true,
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row with Close Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const UiTextNew.customRubik(
                            "Transaction Details",
                            color: DefaultColors.white_800,
                            fontSize: 16,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context); // Close BottomSheet
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      const Divider(
                        color: DefaultColors
                            .grey_05, // Set the color of the divider
                        thickness: 1, // Set the thickness of the divider
                      ),
                      const SizedBox(height: 8),
                      // Transaction Date
                      const UiTextNew.h5Regular(
                        "Transaction Date",
                        color: DefaultColors.grey,
                      ),
                      const SizedBox(height: 8),
                      UiTextNew.customRubik(
                        date,
                        color: DefaultColors.white_800,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 16),

                      // Transaction Amount
                      const UiTextNew.h5Regular(
                        "Amount",
                        color: DefaultColors.grey,
                      ),
                      const SizedBox(height: 8),
                      UiTextNew.customRubik(
                        "QAR $amount",
                        color: DefaultColors.white_800,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 16),

                      // Available Balance
                      const UiTextNew.h5Regular(
                        "Available Balance",
                        color: DefaultColors.grey,
                      ),
                      const SizedBox(height: 8),
                      const UiTextNew.customRubik(
                        "QAR 123,456,787,500.00", // Replace with dynamic value
                        color: DefaultColors.white_800,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 16),

                      // Explanation
                      const UiTextNew.h5Regular(
                        "Explanation",
                        color: DefaultColors.grey,
                      ),
                      const SizedBox(height: 8),
                      const UiTextNew.customRubik(
                        "DBANK TRANSFER A/C TO A/C - FROM: ...",
                        color: DefaultColors.white_800,
                        fontSize: 16,
                      ),
                      const SizedBox(height: 16),

                      // Sequence Number
                      const UiTextNew.h5Regular(
                        "Sequence No.",
                        color: DefaultColors.grey,
                      ),
                      const SizedBox(height: 8),
                      const UiTextNew.customRubik(
                        "153", // Replace with dynamic value
                        color: DefaultColors.white_800,
                        fontSize: 16,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DefaultColors.yellow40.withAlpha(50),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const UiTextNew.h5Regular("Benificary"),
                ),
                UiTextNew.customRubik(
                  title,
                  color: DefaultColors.white_800,
                  fontSize: 16,
                ),
                const SizedBox(height: 4),
                const UiTextNew.customRubik(
                  "123123123123",
                  color: DefaultColors.white_800,
                  fontSize: 10,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Transaction Amount
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UiTextNew.b15Semibold(
                    isCredit ? "+ " : "- ",
                    color: isCredit
                        ? DefaultColors.green49
                        : DefaultColors.red_09,
                  ),
                  UiTextNew.b15Semibold(amount, color: DefaultColors.white_800),
                  const UiSpace.horizontal(4),
                  const UiTextNew.b15Semibold(
                    "QAR",
                    color: DefaultColors.black,
                  ),
                ],
              ),
              UiTextNew.h5Regular(date, color: DefaultColors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
