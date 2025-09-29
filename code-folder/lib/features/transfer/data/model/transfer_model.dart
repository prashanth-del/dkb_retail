class TransactionHelper {
  static Map<String, List<Map<String, String>>> getTransactionDetails(
      TransferSelection? selectedTransfer, {bool isNextPage = false, bool isSendLater = false}) {

    List<Map<String, String>> details = [];
    List<Map<String, String>> chargeDetails = [];

    // Default case: "domestic"
    switch (selectedTransfer?.classification) {
      case "donation":
        switch (selectedTransfer?.index) {
          case 1:
            details = [
              {"Transfer to": "Qatar Red Crescent"},
              {"From Account": "Savings Account 123-1234567-1-23-0"},
              {"Amount": "QAR 5.0"},
            ];
            break;

          default:
            details = [
              {"Transfer to": "Qatar Red Crescent"},
              {"From Account": "Savings Account 123-1234567-1-23-0"},
              {"Amount": "QAR 5.0"},
            ];
            break;
        }
      case "Western Union Money Transfer":
        switch (selectedTransfer?.index) {
          case 0:
            details = [
              {"Status From Western Union": "--"},
              {"MTCN": "1157821120"},
              {"Transaction Date": "Jan 17, Friday, 2020"},
              {"Beneficiary First Name": "Cherian"},
              {"Beneficiary Last Name": "002-test avenue"},
              {"Remittance Amount": "QAR 1,500.00"},
              {"Promotion Discount": "QAR 1,500.00"},
              {"Total Remittance Amount": "QAR 1,500.00"},
              {"Destination Country": "India"},
              {"Destination State": "--"},
              {"Destination City": "--"},
              {"Destination Currency": "Indian Rupee"},
            ];
            break;

            default:
            details = [
              {"Status From Western Union": "--"},
              {"MTCN": "1157821120"},
              {"Transaction Date": "Jan 17, Friday, 2020"},
              {"Beneficiary First Name": "Cherian"},
              {"Beneficiary Last Name": "002-test avenue"},
              {"Remittance Amount": "QAR 1,500.00"},
              {"Promotion Discount": "QAR 1,500.00"},
              {"Total Remittance Amount": "QAR 1,500.00"},
              {"Destination Country": "India"},
              {"Destination State": "--"},
              {"Destination City": "--"},
              {"Destination Currency": "Indian Rupee"},
            ];
            break;
        }
        break;

      case "domestic":
        switch (selectedTransfer?.index) {
          case 0:
            details = [
              {"From Account": "Savings 202-234567-4-1-90-0"},
              {"To Account": "Current 202-234567-4-1-90-0"},
              {"Transfer Amount": "QAR 15000"},
              {"Transaction Remarks": "April 2023 Fees"},
            ];
            break;
          case 1:
            details = [
              {"From Account": "Savings 202-234567-4-1-90-0"},
              {"To Beneficiary": "Ahmed Ansari \nQA45 DOHB 0210 0439 5050 0100 1000 0"},
              {"Transfer Amount": "QAR 15000"},
              {"Purpose": "School Fees"},
              {"Transaction Remarks": "April 2023 Fees"},
            ];
            break;
          case 2:
            details = [
              {"From Account": "Savings 202-234567-4-1-90-0"},
              {"To Beneficiary": "Ahmed Ansari \nQA45 DOHB 0210 0439 5050 0100 1000 0"},
              {"Transfer Amount": "QAR 15000"},
              {"Purpose": "School Fees"},
              {"Transaction Remarks": "April 2023 Fees"},
            ];
            break;
          default:
            details = [
              {"From Account": "Savings 202-234567-4-1-90-0"},
              {"To Account": "Current 202-234567-4-1-90-0"},
              {"Transfer Amount": "QAR 15000"},
              {"Transaction Remarks": "April 2023 Fees"},
            ];
            break;
        }
        break;

      case "ift":
        switch (selectedTransfer?.index) {
          case 0:
            details = [
              {"From Account": "Current Account 202-234567-4-1-90-0"},
              {"To Account": "Bank of China \n 210-439505-1-10-0"},
              {"Charge Type": "All charges borne by me"},
              {"Transaction Remarks": "Test"},
            ];
            chargeDetails = [
              {
                "title": "Correspondent Bank Charges",
                "currency": "QAR",
                "value": "0",
              },
              {
                "title": "Dukhan Bank Charges",
                "currency": "QAR",
                "value": "10",
              },
              {
                "title": "Total Charges",
                "currency": "QAR",
                "value": "10",
              },
            ];
            break;
          case 1:
            details = [
              {"From Account": "Current Account 202-234567-4-1-90-0"},
              {"To Bank": "Exim Bank"},
              {"Transaction Remarks": "Test"},
            ];
            chargeDetails = [
              {
                "title": "Correspondent Bank Charges",
                "currency": "QAR",
                "value": "0",
              },
              {
                "title": "Dukhan Bank Charges",
                "currency": "QAR",
                "value": "10",
              },
              {
                "title": "Total Charges",
                "currency": "QAR",
                "value": "10",
              },
            ];
            break;
          case 2:
            details = [
              {"From Account": "202-1207005-1-30-0"},
              {"Transaction Remarks": "Test"},

            ];
            chargeDetails = [
              {
                "title": "Transaction Charges",
                "currency": "QAR",
                "value": "15",
              },
              {
                "title": "Promotional Discount",
                "currency": "QAR",
                "value": "0",
              },
            ];
            break;
          case 3:
            details = [
              {"From Account": "Current Account 202-234567-4-1-90-0"},
              {"Transaction Remarks": "9790 2345"},
              {"Payer Name": "Transfast Cash pickup Anywhere"},

            ];
            chargeDetails = [
              {
                "title": "Transaction Charges",
                "currency": "QAR",
                "value": "15",
              },
            ];
            break;
          default:
            details = [
              {"From Account": "Savings 202-234567-4-1-90-0"},
              {"To Account": "Current 202-234567-4-1-90-0"},
              {"Transfer Amount": "QAR 25000"},
              {"Transaction Remarks": "IFT Default Transaction"},
            ];
            chargeDetails = [
              {
                "title": "Bank Charges",
                "currency": "QAR",
                "value": "100",
              },
              {
                "title": "Exchange Rate",
                "currency": "QAR",
                "value": "1 QAR",
              },
              {
                "title": "Total Deduction",
                "currency": "QAR",
                "value": "25050",
              },
            ];
            break;
        }
        break;


      default:
        details = [
          {"From Account": "Savings 202-234567-4-1-90-0"},
          {"To Account": "Current 202-234567-4-1-90-0"},
          {"Transfer Amount": "QAR 15000"},
          {"Transaction Remarks": "April 2023 Fees"},
        ];
        break;
    }

    if (isNextPage) {
      details.add({"Reference Number": "75"});
    }
    if (isSendLater) {
      details.add({"Transaction Date": "21 Dec 2023"});
      details.add({"No of Transfers": "2"});
      details.add({"Frequency": "Monthly"});
    }

    return {
      "details": details,
      "chargeDetails": chargeDetails,
    };
  }
}



class TransferSelection {
  final String classification;
  final int index;

  TransferSelection({required this.classification, required this.index});
}
