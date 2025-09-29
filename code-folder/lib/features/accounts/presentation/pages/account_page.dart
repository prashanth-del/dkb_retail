import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/accounts/presentation/widget/searchbar_filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/components/auto_leading_widget.dart';
import '../widget/account_info_card.dart';
import '../widget/bottomWidget.dart';
import '../widget/manage_service_card.dart';
import '../widget/quick_actions_card.dart';
import '../widget/transaction_list.dart';

@RoutePage()
class AccountPage extends ConsumerWidget {
  final int index;
  const AccountPage({super.key, @PathParam('index') required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final double topCardHeight = size.height * 0.3;
    final double titleFontSize = size.width * 0.03;
    final double balanceFontSize = size.width * 0.06;
    final double nameFontSize = size.width * 0.035;
    final double contentMargin = size.height * 0.27;

    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      appBar: const UIAppBar.secondary(
        title: "Accounts",
        autoLeadingWidget: AutoLeadingWidget(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Hero(
              tag: index,
              child: Container(
                width: double.infinity,
                height: topCardHeight,
                padding: EdgeInsets.all(size.width * 0.05),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 2, 56, 100),
                      Colors.deepPurpleAccent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "saving accounts · 123123123",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: titleFontSize,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "5000 QAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: balanceFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: size.width * 0.025),
                        Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.white.withOpacity(0.8),
                          size: size.width * 0.05,
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.012),
                    Text(
                      "Chetan Joshi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: nameFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: contentMargin),
              decoration: const BoxDecoration(
                color: DefaultColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.025),
                    child: quickActionCard(),
                  ),
                  _ExpandedSheet(size: size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandedSheet extends StatelessWidget {
  final Size size;
  const _ExpandedSheet({required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.height * 0.02,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UiTextNew.customRubik(
            'Transaction History',
            color: DefaultColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          SizedBox(height: 10),
          SearchBarWithFilters(),
          SizedBox(height: 10),
          Column(
            children: [
              RecentTabContent(
                title: "Today",
                transactions: [
                  {
                    'date': '2025-01-22',
                    'title': 'Transaction A',
                    'amount': '150.00',
                    'isCredit': true,
                  },
                  {
                    'date': '2025-01-23',
                    'title': 'Transaction B',
                    'amount': '300.00',
                    'isCredit': false,
                  },
                  {
                    'date': '2025-01-22',
                    'title': 'Transaction A',
                    'amount': '150.00',
                    'isCredit': true,
                  },
                ],
              ),
              SizedBox(height: 20),
              RecentTabContent(
                title: "2025-01-22",
                transactions: [
                  {
                    'date': '2025-01-22',
                    'title': 'Transaction A',
                    'amount': '150.00',
                    'isCredit': true,
                  },
                  {
                    'date': '2025-01-23',
                    'title': 'Transaction B',
                    'amount': '300.00',
                    'isCredit': false,
                  },
                  {
                    'date': '2025-01-22',
                    'title': 'Transaction A',
                    'amount': '150.00',
                    'isCredit': true,
                  },
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CommonBottomSheet(
      title: "Account Details",
      content: [
        _buildDetailRow("Savings Account", "210-439505-1-10-0"),
        _buildDetailRow("IBAN", "QA45 DOHB 0210 0439 5050 0100 1000 0"),
        _buildDetailRow("Account Opening Date", "Wednesday, June 29, 2016"),
        _buildDetailRow("Currency", "Qatari Riyal (QAR)"),
        _buildDetailRow("Available Balance", "QAR 449.99"),
        _buildDetailRow("Current Balance", "QAR 449.99"),
        _buildDetailRow("Cleared Balance", "QAR 449.99"),
      ],
      actionButton: ElevatedButton.icon(
        onPressed: () {
          // Action for Share Account Details
        },
        icon: const Icon(Icons.share),
        label: const Text("Share Account Details"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue[900],
          backgroundColor: Colors.blue[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    ),
  );
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
