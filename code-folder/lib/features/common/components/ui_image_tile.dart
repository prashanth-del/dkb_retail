import 'package:flutter/material.dart';

class UiImageTile extends StatelessWidget {
  final String imageName;
  final String title;
  final String? subtitle;
  final Function()? ontap;
  const UiImageTile({
    super.key,
    required this.title,
    required this.imageName,
    this.subtitle,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: ontap,
      child: Container(
        width: width,
        height: height * 0.15,
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Left Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageName,
                width: width * 0.25,
                height: height,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: width * 0.04),

            // Right Text
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.045, // responsive font
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  if (subtitle?.isNotEmpty ?? false) ...[
                    SizedBox(height: height * 0.005),
                    Text(
                      "If you don’t have banking account with us.",
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
