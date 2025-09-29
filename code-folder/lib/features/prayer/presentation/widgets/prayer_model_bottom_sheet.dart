import 'package:flutter/material.dart';
import 'package:db_uicomponents/db_uicomponents.dart';

class PrayerMethodBottomSheet extends StatelessWidget {
  final List<String> methods;
  final Function(String) onSelect;

  const PrayerMethodBottomSheet({
    super.key,
    required this.methods,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: UiTextNew.h1Semibold(
                    "Method",
                    color: Color(0xFF0D3E7F),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: methods.map((method) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: UiCard(
                        borderColor: Colors.grey.shade50,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: UiTextNew.customRubik(
                            method,
                            fontSize: 14,
                            color: Color(0xFF404040),
                            fontWeight: FontWeight.w700,
                          ),
                          onTap: () {
                            onSelect(method);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: -40,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ),
        ),
      ],
    );
  }
}
