import 'package:db_uicomponents/components.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({required this.isActive, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 6.0,
      width: 6.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? DefaultColors.blue9D : DefaultColors.grayB3,
      ),
    );
  }
}

class imageSliderView extends StatefulWidget {
  final List<String> images;
  final double height;

  const imageSliderView({
    required this.images,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  _imageSliderViewState createState() => _imageSliderViewState();
}

class _imageSliderViewState extends State<imageSliderView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: widget.images.length
                ,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final image = widget.images[index];
          
              return Center(
                child: Image.asset(image,
                fit: BoxFit.contain,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        // Dots Indicator
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                    (index) => DotIndicator(isActive: currentIndex == index),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
