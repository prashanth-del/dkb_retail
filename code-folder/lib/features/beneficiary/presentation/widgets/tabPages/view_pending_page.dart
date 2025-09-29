import 'package:dkb_retail/features/beneficiary/presentation/widgets/tabPages/beneficiary_user_card.dart';
import 'package:flutter/material.dart';

class ViewPendingPage extends StatefulWidget {
  const ViewPendingPage({super.key});

  @override
  State<ViewPendingPage> createState() => _ViewPendingPageState();
}

class _ViewPendingPageState extends State<ViewPendingPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          BeneficiaryUserCard(
            statusType: "Pending",
            users: [
              UserModel(
                initials: "K",
                name: "Krishna Ketan Nagu",
                accountDetails: "HDFC Bank   000056789043",
              ),
              UserModel(
                initials: "F",
                name: "Faisal Mubarak Shaul Hameed",
                accountDetails: "SBI Bank   000987654321",
              ),
              UserModel(
                initials: "R",
                name: "Ramesh Muthiah",
                accountDetails: "SBI Bank   000987654321",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
