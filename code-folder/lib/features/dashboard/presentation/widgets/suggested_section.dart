import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/cupertino.dart';

class SuggestedSection extends StatelessWidget {
  const SuggestedSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> slider = List.generate(3, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          height: context.screenHeight / 4.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPath.image.slider),
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: UiTextNew.customRubik(
            "Suggested for you!",
            color: DefaultColors.white_800,
            fontSize: 16,
          ),
        ),
        const UiSpace.vertical(10),
        UiSwiper<Widget>.swiper2(
          elements: slider,
          itemBuilder: (context, index) {
            return slider[index];
          },
          height: context.screenHeight / 4.1,
        ),
      ],
    );
  }
}
