import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

class DepositDetailsSheet extends StatelessWidget {
  final String title;
  final String rate;
  final String maturityDate;
  final String currency;
  final String category;
  final String creationDate;
  final String tenure;

  const DepositDetailsSheet({
    super.key,
    required this.title,
    required this.rate,
    required this.maturityDate,
    required this.currency,
    required this.category,
    required this.creationDate,
    required this.tenure,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close button
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.close, color: DefaultColors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        // Title
        Container(
          padding: EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Rate card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      rate,
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Growth till date",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Maturity Date: $maturityDate",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Info grid
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                children: [
                  _buildInfoBox("Currency", currency),
                  _buildInfoBox("Category", category),
                  _buildInfoBox("Creation Date", creationDate),
                  _buildInfoBox("Tenure", tenure),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Call this bottom sheet
void showDepositDetails(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DepositDetailsSheet(
      title: "Fixed Deposit",
      rate: "0.50000%",
      maturityDate: "20/10/2020",
      currency: "QAR",
      category: "Retail",
      creationDate: "20/10/2020",
      tenure: "3 Months",
    ),
  );
}
