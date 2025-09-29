import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/components/auto_leading_widget.dart';
import '../../data/models/onboard_model.dart';

@RoutePage()
class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  List<OnBoardModel> mySlides = <OnBoardModel>[];

  //Keep track of if we are last page or not
  bool onLastPage = false;

  int slideIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    mySlides = getSlides();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: DefaultColors.white_f3,
        appBar: const UIAppBar.secondary(
          title: "Select Account",
          autoLeadingWidget: null,
        ),
        body: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 8,
          onPageChanged: (int index) {
            setState(() {
              slideIndex = index;
            });
          },
          itemBuilder: (_, i) {
            debugPrint(mySlides[i].getVectorPath().toString());
            return SizedBox.expand(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          UiCard(
                            child: Column(
                              children: [
                                if (mySlides[i].getVectorPath() != null)
                                  Image.asset(
                                    mySlides[i].getVectorPath()!,
                                    alignment: Alignment.topCenter,
                                    width: context.screenWidth,
                                    height: context.screenHeight / 1.8,
                                    fit: BoxFit.fill,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: slideIndex == 7
                                            ? null
                                            : () {
                                                _pageController.animateToPage(
                                                  slideIndex + 1,
                                                  duration: const Duration(
                                                    milliseconds: 100,
                                                  ),
                                                  curve: Curves.linear,
                                                );
                                              },
                                        child: const UiTextNew.b15Medium(
                                          'Learn More',
                                          color: DefaultColors.primaryBlue,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.router.replace(
                                            const LoginRoute(),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: DefaultColors.primaryBlue,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                          ),
                                          child: const UiTextNew.b15Semibold(
                                            'Apply Now',
                                            color: DefaultColors.primaryBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const UiSpace.vertical(20),
                  SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 8,
                    effect: ExpandingDotsEffect(
                      // paintStyle: PaintingStyle.stroke,
                      activeDotColor: DefaultColors.primaryBlue,
                      dotColor: DefaultColors.primaryBlue.withOpacity(0.2),
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                  const UiSpace.vertical(50),
                ],
              ),
            );
            // return Stack(children: [
            //   if (mySlides[i].getVectorPath() != null)
            //     SvgPicture.asset(
            //       mySlides[i].getVectorPath()!,
            //       alignment: Alignment.bottomLeft,
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height,
            //     ),
            //
            //   // title & body
            //   Positioned(
            //       width: MediaQuery.of(context).size.width,
            //       child: Container(
            //         margin: const EdgeInsets.all(16.0),
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               Container(
            //                 margin: EdgeInsets.only(
            //                     top: context.screenHeight * 0.1),
            //                 child: Column(
            //                   children: [
            //                     if (mySlides[i].getTitle() != null &&
            //                         mySlides[i].getSub() != null &&
            //                         mySlides[i].getBody() != null)
            //                       RichText(
            //                         text: TextSpan(
            //                           text: mySlides[i].getTitle(),
            //                           style: AppText.of(context)
            //                               .headingStyle1(
            //                               color: AppColor.of(context)
            //                                   .txtColor2,
            //                               size: 22)
            //                               .copyWith(
            //                               fontWeight: FontWeight.bold),
            //                           children: <TextSpan>[
            //                             TextSpan(
            //                               text: mySlides[i].getSub(),
            //                               style: AppText.of(context)
            //                                   .headingStyle1(
            //                                   color: AppColor.of(context)
            //                                       .primary,
            //                                   size: 22)
            //                                   .copyWith(
            //                                   fontWeight:
            //                                   FontWeight.bold),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                     const SizedBox(
            //                       height: 5,
            //                     ),
            //                     if (mySlides[i].getBody() != null)
            //                       Text(
            //                         mySlides[i].getBody()!,
            //                         textAlign: TextAlign.center,
            //                         style: AppText.of(context).headingStyle1(
            //                             color: AppColor.of(context).txtColor,
            //                             size: 15),
            //                       ),
            //                   ],
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 20,
            //               ),
            //             ]),
            //       )),
            //
            //   // image
            //   if (mySlides[i].getImageAssetPath() != null)
            //     Positioned(
            //       top: screenSize(context).height / 2.8,
            //       left: 10,
            //       right: 10,
            //       child: Image.asset(
            //         mySlides[i].getImageAssetPath()!,
            //         height: 220,
            //       ),
            //     ),
            //
            //   // indicator
            //   Positioned(
            //     bottom: 150,
            //     right: 50,
            //     child: SmoothPageIndicator(
            //       controller: _pageController, // PageController
            //       count: 4,
            //       effect: ExpandingDotsEffect(
            //         // paintStyle: PaintingStyle.stroke,
            //           activeDotColor: AppColor.of(context).primary,
            //           dotColor: AppColor.of(context).grey,
            //           dotHeight: 6,
            //           dotWidth: 6),
            //     ),
            //   ),
            //
            //   // button
            //   Positioned.fill(
            //     bottom: 30,
            //     child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 20),
            //         child: Row(
            //           mainAxisAlignment: slideIndex == 3
            //               ? MainAxisAlignment.end
            //               : MainAxisAlignment.spaceBetween,
            //           children: [
            //             if (slideIndex != 3)
            //               TextButton(
            //                 onPressed: () async {
            //                   final error =
            //                   await BlocProvider.of<AuthCubit>(context)
            //                       .setOnboardSeen();
            //                   if (error != null) {
            //                     showBottomMsg(
            //                         context: context, msg: error.toString());
            //                   }
            //                 },
            //                 child: Text(
            //                   AppConstant.of(context).skip,
            //                   style: AppText.of(context)
            //                       .bodyStyle1(
            //                       color: AppColor.of(context).white,
            //                       size: 15)
            //                       .copyWith(fontFamily: poppins),
            //                 ),
            //               ),
            //             if (slideIndex != 3)
            //               SizedBox.fromSize(
            //                 size:
            //                 const Size(45, 45), // button width and height
            //                 child: ClipOval(
            //                   child: Material(
            //                     elevation: 20,
            //                     color: Colors.white,
            //                     child: InkWell(
            //                       onTap: () {
            //                         _pageController.animateToPage(
            //                             slideIndex + 1,
            //                             duration:
            //                             const Duration(milliseconds: 100),
            //                             curve: Curves.linear);
            //                         // _pageController.nextPage(duration:Duration(milliseconds:200), curve: Curves.easeOut);
            //                       }, // button pressed
            //                       child: Column(
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.center,
            //                         children: <Widget>[
            //                           Icon(
            //                             Icons.navigate_next,
            //                             color:
            //                             AppColor.of(context).txtBodyColor,
            //                           ), // icon
            //                           // text
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             if (slideIndex == 3)
            //               InkWell(
            //                 onTap: (() async {
            //                   final error =
            //                   await BlocProvider.of<AuthCubit>(context)
            //                       .setOnboardSeen();
            //                   if (error != null) {
            //                     showBottomMsg(
            //                         context: context, msg: error.toString());
            //                   }
            //                 }),
            //                 child: Container(
            //                   height: 45,
            //                   decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       borderRadius: BorderRadius.circular(200)),
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 10),
            //                     child: Center(
            //                       child: Row(
            //                         children: [
            //                           Text(
            //                             AppConstant.of(context).getStart,
            //                             style: AppText.of(context)
            //                                 .headingStyle1(
            //                                 color: AppColor.of(context)
            //                                     .txtBodyColor,
            //                                 size: 14)
            //                                 .copyWith(fontFamily: poppins),
            //                           ),
            //                           const SizedBox(
            //                             width: 4,
            //                           ),
            //                           Icon(
            //                             Icons.navigate_next,
            //                             color:
            //                             AppColor.of(context).txtBodyColor,
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               )
            //           ],
            //         ),
            //       ),
            //     ),
            //   )
            // ]);
          },
        ),
      ),
    );
  }
}
