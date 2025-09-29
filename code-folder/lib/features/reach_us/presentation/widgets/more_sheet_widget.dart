import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart' hide DefaultColors;
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/colors.dart' show DefaultColors;
import 'package:flutter/material.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/router/app_router.dart';

class MoreSheetWidget extends StatefulWidget {
  const MoreSheetWidget({super.key});

  @override
  State<MoreSheetWidget> createState() => _MoreSheetWidgetState();
}

class _MoreSheetWidgetState extends State<MoreSheetWidget> {
  List<Map<String, dynamic>> moreActionList = [
    {
      "title": DefaultString.instance.chequeBookRequest,
      "subTitle": "Request",
      "icon": AssetPath.image.defualtImage,
    },
    {
      "title": "Download ",
      "subTitle": "Statement",
      "icon": AssetPath.image.defualtImage,
    },
    {
      "title": "Quick ",
      "subTitle": "link",
      "icon": AssetPath.image.defualtImage,
    },
    {
      "title": "Quick ",
      "subTitle": "link",
      "icon": AssetPath.image.defualtImage,
    },
    {"title": "Reach Us", "subTitle": "", "icon": AssetPath.image.reachImage},
    {
      "title": "My Book ",
      "subTitle": "Offers",
      "icon": AssetPath.image.defualtImage,
    },
    {
      "title": "Switch to",
      "subTitle": "Corporate",
      "icon": AssetPath.image.defualtImage,
    },
    {
      "title": "Quick",
      "subTitle": "link",
      "icon": AssetPath.image.defualtImage,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSheetWidget(
          withCloseIcon: false,
          titleSheet: "More Services",
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SizedBox(),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 4),
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //         child: Icon(Icons.close, color: DefaultColors.white, size: 28),
          //       ),
          //     ),
          //   ],
          // ),
          // UiSpace.vertical(10),
          contentSheet: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10, // vertical
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.78, // square
                  shrinkWrap: true,

                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(moreActionList.length, (index) {
                    return Container(
                      //  width: 84,
                      // color: Colors.red,
                      child: GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              // Action for first item
                              print("Quick link 0 clicked");
                              break;
                            case 1:
                              // Action for second item
                              print("Quick link 1 clicked");
                              break;
                            case 4:
                              // Reach Us
                              context.router.push(ReachUsPageRoute());
                              break;
                            default:
                            // print("${moreActionList[index]["title"]} clicked");
                          }
                        },
                        child: Container(
                          //color: Colors.red,
                          // width: 84,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                //  color: Colors.yellow,
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: DefaultColors.white_500.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                  alignment: Alignment
                                      .center, // ensures image is centered
                                  child: Image.asset(
                                    moreActionList[index]["icon"],
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit
                                        .contain, // keeps aspect ratio within 24x24
                                  ),
                                ),
                              ),
                              UiSpace.vertical(5),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    UiTextNew.custom(
                                      moreActionList[index]["title"],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      textAlign: TextAlign.center,
                                    ),
                                    UiTextNew.custom(
                                      moreActionList[index]["subTitle"],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                UiSpace.vertical(20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContentCommonSheet extends StatelessWidget {
  final Widget contentSheet;
  const ContentCommonSheet({super.key, required this.contentSheet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: DefaultColors.grayLightBase,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Icon(
                          Icons.close,
                          color: DefaultColors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                UiSpace.vertical(10),
                contentSheet,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderSheetWidget extends StatelessWidget {
  final Widget contentSheet;
  final String? titleSheet;
  final bool withCloseIcon;

  const HeaderSheetWidget({
    super.key,
    required this.contentSheet,
    this.titleSheet,
    this.withCloseIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.mediaQuery.size.height - 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: DefaultColors.grayLightBase,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max, // 👈 IMPORTANT
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // DividerSheetCommon(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleSheet != null
                      ? UiTextNew.customRubik(
                          titleSheet!,
                          fontSize: 16,
                          color: DefaultColors.blueBase,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w700,
                        )
                      : SizedBox(),
                  withCloseIcon
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.close,
                              color: DefaultColors.black,

                              size: 22,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              UiSpace.vertical(20),
              contentSheet,
            ],
          ),
        ),
      ),
    );
  }
}
