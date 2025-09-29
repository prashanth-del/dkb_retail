import 'package:flutter/material.dart';

Widget FloatingSearchBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    margin: const EdgeInsets.symmetric(horizontal: 60),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(32),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search, color: Colors.black, size: 24),
        SizedBox(width: 8),
        Text(
          'Tap to Search',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ],
    ),
  );
}
