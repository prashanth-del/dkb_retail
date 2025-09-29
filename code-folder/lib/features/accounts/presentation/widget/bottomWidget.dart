import 'package:flutter/material.dart';

class CommonBottomSheet extends StatelessWidget {
  final String title;
  final List<Widget> content;
  final Widget? actionButton;
  final VoidCallback? onClose;

  const CommonBottomSheet({
    Key? key,
    required this.title,
    required this.content,
    this.actionButton,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.6, // Set a static height for the bottom sheet
      decoration: const BoxDecoration(
        color: Colors.white, // Set background to white
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0), // Rounded corners at the top
          topRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title Row with Close Icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    if (onClose != null) {
                      onClose!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey, // Divider color
            thickness: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...content,
                ],
              ),
            ),
          ),
          // Action Button
          if (actionButton != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: actionButton!,
              ),
            ),
        ],
      ),
    );
  }
}
