import 'package:flutter/material.dart';

class UiError extends StatelessWidget {
  final String errorMessage;

  UiError({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red, // White color for the icon
          size: 30,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            errorMessage,
            style: TextStyle(
              color: Colors.black, // White text color for visibility
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
