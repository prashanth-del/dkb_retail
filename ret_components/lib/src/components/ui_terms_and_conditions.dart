import 'package:flutter/material.dart';

const String heading = "By choosing the e-Statement option with respect to "
    "your accounts, you hereby agree to the following terms and conditions and any other terms and conditions relevant to this accounts.";

final List<String> body = [
  "Sending of printed bank statement to the accounts "
      "holders' given address will be stopped accordingly.",
  "The accounts holder understands that the Bank will send or deliver an "
      "e-Statement of accounts(s) at the authorized e-mail ID at least once "
      "every month. (In respect of any accounts that has, in the sole opinion of the Bank, been inactive for a period of one year or more such e-Statement of accounts will be sent or delivered by the Bank annually). The e-Statements) of accounts (s) issued by the bank clarifies the due balance of the accounts) at any time and if not rejected by the system within fifteen days from the e-Statement was sent will be considered as accepted by the client.",
  "e-Statements facility Is currently Free-of-Charge* and for any future changes in the fees and charges structure, corresponding service notice will be displayed accordingly."
];

const String feesAndCharges = "* Fees and Charges structure subject to change.";
const String additionalTerms = "In additions to the terms and conditions of "
    "your accounts, the regular terms, conditions and general provisions for other accounts apply. Exception being paper statements are replaced with electronic statements";

class UiTermsAndConditions extends StatelessWidget {
  const UiTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(heading),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("1."),
                Expanded(child: Text(body[0])),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("2."),
                Expanded(child: Text(body[1])),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("3."),
                Expanded(child: Text(body[2])),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(feesAndCharges),
        const SizedBox(
          height: 10,
        ),
        const Text(additionalTerms),
      ],
    );
  }
}

class UiTermsAndConditionsCreditCardEStatement extends StatelessWidget {
  const UiTermsAndConditionsCreditCardEStatement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Credit Card e-Statement Terms and Conditions - ",
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "e-Statement: Statement of Customer Credit Card Account at Dukhan "
          "Bank sent through electronic methods such as; but not limited to"
          " e-mails.",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Text("The Customer has chosen to convert to Credit Card e-Statement "
            "and he/she complies with the Terms & Conditions mentioned below and any other Terms and Conditions applied by Dukhan Bank in the general Credit Card Contract which was previously signed by the customer. "),
        SizedBox(height: 10),
        Text("By choosing the Credit Card e-Statement option with respect to "
            "a particular Credit Card accounts, you hereby agree to the following Terms and Conditions and any other Terms and Conditions relevant to this Credit Card accounts. "),
        SizedBox(height: 10),
        Text("1. The Credit Card accounts holder understands that the Bank "
            "will send or deliver an e-Statement of Credit Card accounts(s) to the authorized e-mail ID at least every six months. (In respect of any Credit Card accounts that has, in the sole opinion of the Bank, been inactive for a period of one year or more, such e-Statement of Credit Card accounts will be sent or delivered by the Bank annually). The e-Statement(s) of Credit Card accounts(s) issued by the Bank clarifies the due balance of the Credit Card accounts(s) at any time and if not objected by the customer within fifteen days from the e-Statement was sent will be considered as accepted by the client. "),
        Text("2. The e-Statement facility is currently Free-of-Charge*. The "
            "Bank reserves the right for any future changes in the fees and charges structure with or without prior notice to the customer. "),
        Text("3. The electronic delivery notice of e-Statement will be "
            "considered as legal evidence of customer acknowledgment, and will be taken as a base of counting all formal and legal durations. "),
        Text("4. In case the customer’s e-mail ID accounts has been closed, "
            "changed, lost, hacked, erased or been subject to any circumstances that lead the customer to lose control over his e-mail accounts, the Bank shall not be held responsible for any e-Statement abuse, secret disclosure, damage, claim or indemnity may arouse from such action, all formal and legal durations will be applied unless the Bank receives a formal written notice from the customer of such circumstances. "),
        SizedBox(height: 10),
        Text("* The above Terms and Conditions are an integral part of Dukhan "
            "Bank's Personal Credit Card Contract. "),
        SizedBox(height: 10),
        Text("In addition to the Terms and Conditions of your Credit Card "
            "Account, the regular terms, conditions and general provisions of Dukhan Bank Credit Card Contract shall apply. Exception the word statement(s) will be replaced with electronic statements."),
      ],
    );
  }
}
