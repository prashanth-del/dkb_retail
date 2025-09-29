import 'package:dkb_retail/features/login/presentation/controller/login_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordBottomSheet extends ConsumerWidget {
  final String cardNumber; // full 12 digit card number
  final void Function(String pin) onSubmit;

  const ForgotPasswordBottomSheet({
    super.key,
    required this.cardNumber,
    required this.onSubmit,
  });

  /// Mask card number but show last 4
  String getMaskedCardNumber() {
    if (cardNumber.length < 4) return cardNumber;
    return "**** **** **** ${cardNumber.substring(cardNumber.length - 4)}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pin = ref.watch(forgetPasswordDebitCardPinProvider);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            "Forgot Password ?",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 4),

          Text(
            "Enter your card details",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          /// Card number field (masked)
          TextFormField(
            readOnly: true,
            initialValue: getMaskedCardNumber(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              labelText: "Your debit/prepaid card number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// PIN input
          TextFormField(
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            onChanged: (value) =>
                ref.read(forgetPasswordDebitCardPinProvider.notifier).state =
                    value,
            decoration: InputDecoration(
              counterText: "", // hide char counter
              labelText: "Your Debit/Prepaid card PIN",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.3),

          /// Submit button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.grey.shade400,
                backgroundColor: pin.isNotEmpty
                    ? Colors.blue
                    : Colors.grey.shade400,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: pin.isNotEmpty
                  ? () {
                      onSubmit(pin);
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text(
                "Get OTP",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
