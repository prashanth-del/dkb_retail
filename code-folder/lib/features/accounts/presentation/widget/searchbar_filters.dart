import 'package:flutter/material.dart';

class SearchBarWithFilters extends StatelessWidget {
  const SearchBarWithFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search bar
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.black26, width: 1),
            ),
            child: const TextField(
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.black54),
                contentPadding: EdgeInsets.only(left: 20, top: 5),
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search, color: Colors.black54),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Filter button
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.tune, color: Colors.black87),
        ),
        const SizedBox(width: 10),

        // Download button
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.download, color: Colors.black87),
        ),
      ],
    );
  }
}
