import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/constants/asset_path/asset_path.dart';

class DashboardSlider extends ConsumerWidget {
  const DashboardSlider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLang = ref.getCurrentLang();
    final imageAssets = ImageAssets().dashboardSlideRetail;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    double sliderHeight;

    // if (screenWidth > 600) { // This is generally considered a tablet size
    //   isPortrait ?  sliderHeight = context.screenHeight / 3.85 : sliderHeight = context.screenHeight / 1.5;
    // } else {
    //   sliderHeight = context.screenHeight / 5.5; // Mobile screen height
    // }

    List<Widget> list = imageAssets.map((path) {
      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: GestureDetector(
          onTap: () {
            // var url = "https://qa.dohabank.com/$currentLang/wholesale/";
            // launchUrlString(url);
          },
          child: SizedBox(
            // height:  sliderHeight,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(path, fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }).toList();
    return UiSwiper<Widget>.swiper1(
      elements: list,
      itemBuilder: (context, index) {
        return list[index];
      },
      //height: context.screenHeight / 5.5,
      //height: sliderHeight,
      height: isPortrait
          ? screenWidth > 600
                ? screenWidth * 0.35
                : screenWidth * 0.38
          : screenHeight * 0.35,
    );
  }
}
