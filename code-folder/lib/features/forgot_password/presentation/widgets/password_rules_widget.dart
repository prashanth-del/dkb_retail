import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/features/registration/data/modals/password_validation.dart';
import 'package:flutter/material.dart';

List<Widget> passwordRulesWidget(PasswordValidation validation) {
  final rules = [
    {"text": "At least 8 characters", "valid": validation.hasMinLength},
    {"text": "Lower case letters (a-z)", "valid": validation.hasLowercase},
    {"text": "Upper case letters (A-Z)", "valid": validation.hasUppercase},
    {"text": "Contains numbers", "valid": validation.hasNumber},
    {
      "text": "1 special character (!@#\$&*)",
      "valid": validation.hasSpecialChar,
    },
  ];

  return [
    /// Progress bar + Strength
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value:
                  (rules.where((e) => e["valid"] as bool).length /
                  rules.length),
              backgroundColor: DefaultColors.gray96,
              valueColor: AlwaysStoppedAnimation(
                validation.isStrong ? Colors.green : Colors.red,
              ),
            ),
          ),
          const UiSpace.horizontal(8),
          Builder(
            builder: (_) {
              final completed = rules.where((e) => e["valid"] as bool).length;

              String strength;
              Color strengthColor;

              if (completed <= 2) {
                strength = "Weak";
                strengthColor = Colors.red;
              } else if (completed == 3 || completed == 4) {
                strength = "Medium";
                strengthColor = Colors.orange;
              } else {
                strength = "Strong";
                strengthColor = Colors.green;
              }

              return UiTextNew.custom(
                strength,
                fontSize: 12,
                color: strengthColor,
                fontWeight: FontWeight.w600,
              );
            },
          ),
        ],
      ),
    ),
    UiSpace.vertical(10),

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 2, // 2 columns
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 6,
        crossAxisSpacing: 12,
        childAspectRatio: 12,
        children: rules
            .map((r) => _buildRule(r["text"] as String, r["valid"] as bool))
            .toList(),
      ),
    ),
  ];
}

Widget _buildRule(String text, bool isValid) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        isValid ? Icons.check_circle : Icons.cancel,
        color: isValid ? Colors.green : Colors.red,
        size: 15,
      ),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 10,
          ),
        ),
      ),
    ],
  );
}
