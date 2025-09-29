import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final int? maxLength;
  final TextInputType keyboardType;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {}); // rebuild to update border color
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color _borderColor(BuildContext context) {
    if (!widget.enabled) return Colors.grey.shade400;
    if (_focusNode.hasFocus) return Colors.blue;
    return Colors.grey.shade600;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _borderColor(context), width: 1.5),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          counterText: "", // hides maxLength counter
          border: InputBorder.none, // removes underline + outline
        ),
      ),
    );
  }
}
