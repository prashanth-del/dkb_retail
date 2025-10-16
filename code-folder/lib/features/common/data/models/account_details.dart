import 'dart:convert';

class AccountDetails {
  final String holderName;
  final String accountType;
  final String accountNumber;
  final String balance;
  final String currency;

  const AccountDetails({
    required this.holderName,
    required this.accountType,
    required this.accountNumber,
    required this.balance,
    required this.currency,
  });

  /// Convert JSON map → AccountDetails
  factory AccountDetails.fromJson(Map<String, dynamic> json) {
    return AccountDetails(
      holderName: json['holderName'] as String? ?? '',
      accountType: json['accountType'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      balance: json['balance'] as String? ?? '0',
      currency: json['currency'] as String? ?? '',
    );
  }

  /// Convert AccountDetails → JSON map
  Map<String, dynamic> toJson() {
    return {
      'holderName': holderName,
      'accountType': accountType,
      'accountNumber': accountNumber,
      'balance': balance,
      'currency': currency,
    };
  }

  /// Create a copy with modified fields
  AccountDetails copyWith({
    String? holderName,
    String? accountType,
    String? accountNumber,
    String? balance,
    String? currency,
  }) {
    return AccountDetails(
      holderName: holderName ?? this.holderName,
      accountType: accountType ?? this.accountType,
      accountNumber: accountNumber ?? this.accountNumber,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
    );
  }

  /// For debugging
  @override
  String toString() => jsonEncode(toJson());
}
