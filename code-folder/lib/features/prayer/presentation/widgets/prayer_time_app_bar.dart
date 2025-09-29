import 'package:flutter/material.dart';

class PrayerTimesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;
  final bool showSettings;
  final Color textColor;

  const PrayerTimesAppBar({
    super.key,
    this.title = "Prayer Timings",
    this.onBack,
    this.onSettings,
    this.showSettings = true,
    this.textColor = Colors.white,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: onBack ?? () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: textColor, size: 23),
          ),
          SizedBox(width: size.width * 0.02),
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.w900,
              color: textColor,
            ),
          ),
        ],
      ),
      actions: showSettings
          ? [
              GestureDetector(
                onTap: onSettings,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.settings, color: textColor),
                ),
              ),
            ]
          : null,
    );
  }
}
