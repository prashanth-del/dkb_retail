import 'package:flutter/material.dart';

class UiSearch extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final String? hintText;
  final Color borderColorOfSearch;
  final FocusNode? focusNode; // Add FocusNode parameter
  final bool readOnly;

  const UiSearch({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText = "Search",
    this.readOnly = false,
    this.borderColorOfSearch = const Color(0xFFC6E2FA),
    this.focusNode, // Initialize FocusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: borderColorOfSearch),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode, // Assign FocusNode to TextField
              onChanged: onChanged,
              maxLines: 1,
              readOnly: readOnly,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: const EdgeInsets.only(bottom: 4),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                prefixIconConstraints: const BoxConstraints(),
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                isDense: true, // Compact layout
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ],
      ),
    );
  }
}
