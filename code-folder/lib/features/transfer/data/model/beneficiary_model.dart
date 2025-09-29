import 'flag_model.dart';

class BeneficiaryModel {
  final String id;
  final String name;
  final String accountNumber;
  final String ifsc;
  final String bankName;
  final Flag flag;

  BeneficiaryModel({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.ifsc,
    required this.bankName,
    required this.flag,
  });

  static Future<List<BeneficiaryModel>> loadDummyBeneficiaries() async {
    List<Flag> flags;
    try {
      flags = await Flag.loadFlags();
    } catch (e) {
      throw Exception("Failed to load beneficiaries due to flag loading error: $e");
    }

    if (flags.isEmpty) {
      throw Exception("No flags available to assign to beneficiaries.");
    }

    return List.generate(10, (index) {
      final flag = flags[index % flags.length];

      return BeneficiaryModel(
        id: 'B${index + 1}',
        name: 'Beneficiary ${index + 1}',
        accountNumber: 'QA45-DOHB-0210-3199-000${index + 1}',
        ifsc: '7896500${index + 1}',
        bankName: 'Bank ${index + 1}',
        flag: flag,
      );
    });
  }
}