import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/extensions/context_extension.dart';
import 'package:dkb_retail/features/product_offering/domain/entities/bank_products_sub_product.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/product_offering_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductOfferingDetailsPage extends ConsumerStatefulWidget {
  const ProductOfferingDetailsPage({
    super.key,
    required this.title,
    required this.products,
  });

  final String title;
  final List<BankProductsSubProduct> products;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductOfferingDetailsPageState();
}

class _ProductOfferingDetailsPageState
    extends ConsumerState<ProductOfferingDetailsPage> {
  List depositProducts = [
    {
      "title": "Time\nDeposits",
      "subtitle":
          'Fixed Deposits are approved by our Shari’ah Supervisory Committee, Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.',
      "image": AssetPath.image.card1,
    },
    {
      "title": "profit in\nAdvance Deposits",
      'subtitle':
          'Our Shari’ah compliant Term Deposit account “Wadiati” gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.',
      "image": AssetPath.image.card2,
    },
    {
      'title': 'Deposits',
      'subtitle':
          'Fixed Deposits are approved by our Shari’ah Supervisory Committee, Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.',
      "image": AssetPath.image.card3,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(productIndex);
    return Scaffold(
      body: Column(
        children: [
          widget.title == 'Cards'
              ? ProductDetailsCardTopWidget(
                  productsList: widget.products,
                  title: widget.title,
                )
              : ProductDetailsTopWidget(
                  productsList: widget.products,
                  title: widget.title,
                ),
          Expanded(
            // child: ListView.builder(
            //   itemCount: depositProducts.length,
            //   padding: EdgeInsets.only(top: 16, left: 16, right: 16),
            //   itemBuilder: (context, index) {
            //     return Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         UiTextNew.custom(
            //           '${depositProducts[currentIndex]['subtitle']}',
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //         ),
            //         UiSpace.vertical(10),
            //         UiTextNew.custom(
            //           '~ Open with minimum QAR 50,000',
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //         ),
            //         UiSpace.vertical(10),
            //         UiTextNew.custom(
            //           '~ Flexible deposit methods: cash, cheque, transfer',
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ],
            //     );
            //   },
            // ),
            child: SingleChildScrollView(
              child: Html(data: widget.products[currentIndex].description),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: UIButton.rounded(
                  height: 48,
                  btnCurve: 30,

                  // backgroundColor: DefaultColors.blue9D,
                  onPressed: () {
                    context.router.push(ProductContactUsRoute());
                  },
                  label: DefaultString.instance.apply,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailsTopWidget extends ConsumerStatefulWidget {
  const ProductDetailsTopWidget({
    super.key,
    required this.productsList,
    required this.title,
  });

  final List productsList;
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsTopWidgetState();
}

class _ProductDetailsTopWidgetState
    extends ConsumerState<ProductDetailsTopWidget> {
  final PageController _pageController = PageController();
  // int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(productIndex);
    return Hero(
      tag: widget.title,
      child: Container(
        height: context.height(45),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Color(0xff334546), Color(0xff212132)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // UiSpace.vertical(25),
            // Row(
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         context.router.maybePop();
            //       },
            //       icon: Icon(Icons.arrow_back, color: DefaultColors.white),
            //     ),
            //     UiTextNew.h2Semibold('Deposits', color: DefaultColors.white),
            //   ],
            // ),
            UiSpace.vertical(40),
            Row(
              children: [
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    context.router.maybePop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: DefaultColors.white),
                ),
                Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      color: DefaultColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            // Material(
            //   color: Colors.transparent,
            //   child: CommonAuthAppBar(
            //     title: 'Deposits',
            //     iconColor: DefaultColors.white,
            //     titleStyle: TextStyle(color: DefaultColors.white),
            //   ),
            // ),
            widget.productsList.isEmpty
                ? SizedBox()
                : Expanded(
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: widget.productsList.length,
                          onPageChanged: (index) {
                            ref.read(productIndex.notifier).state = index;
                          },
                          itemBuilder: (context, index) {
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  width: double.infinity,

                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 46,
                                      top: 16,
                                    ),
                                    child: UiTextNew.h1Semibold(
                                      // widget.productsList[index]['title'],
                                      'title',
                                      color: DefaultColors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 0,
                                  child: Image.asset(
                                    AssetPath.image.productHome,
                                    // height: 100,
                                    // width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Positioned(
                          left: 46,
                          top: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.productsList.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 16,
                                ),
                                width: currentIndex == index ? 32 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? DefaultColors.white
                                      : Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsCardTopWidget extends ConsumerStatefulWidget {
  const ProductDetailsCardTopWidget({
    super.key,
    required this.productsList,
    required this.title,
  });

  final List<BankProductsSubProduct> productsList;
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsCardTopWidgetState();
}

class _ProductDetailsCardTopWidgetState
    extends ConsumerState<ProductDetailsCardTopWidget> {
  final PageController _pageController = PageController();
  // int _currentIndex = 0;

  //  @override
  // void initState() {
  //   super.initState();
  //   carouselController.addListener(() {
  //     // int index = _pageController.page!.round();
  //     if (_currentIndex != carouselController.) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     }
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(productIndex);
    return Hero(
      tag: widget.title,
      child: Stack(
        children: [
          Container(
            height: context.height(45),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Color(0xff334546), Color(0xff212132)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiSpace.vertical(40),
                Row(
                  children: [
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        context.router.maybePop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: DefaultColors.white,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          color: DefaultColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Material(
                //   color: Colors.transparent,
                //   child: CommonAuthAppBar(
                //     title: 'Deposits',
                //     iconColor: DefaultColors.white,
                //     titleStyle: TextStyle(color: DefaultColors.white),
                //   ),
                // ),
                // SizedBox(
                //   height: 200,
                //   child: CarouselView(
                //     // controller: carouselController,
                //     // padding: EdgeInsets.only(
                //     //   top: 10,
                //     //   left: 0,
                //     //   bottom: 10,
                //     //   right: 0,
                //     // ),
                //     itemExtent: 320,
                //     itemSnapping: true,
                //     shrinkExtent: 200,
                //     // backgroundColor: Colors.transparent,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(24),
                //     ),
                //     // children: List.generate(widget.productsList.length, (
                //     //   index,
                //     // ) {
                //     //   return Container(
                //     //     // margin: EdgeInsets.symmetric(horizontal: 20),
                //     //     // duration: const Duration(milliseconds: 100),
                //     //     // height: 180,
                //     //     decoration: BoxDecoration(
                //     //       borderRadius: BorderRadius.circular(24),
                //     //       // gradient: LinearGradient(
                //     //       //   colors: [
                //     //       //     DefaultColors.greenStatus,
                //     //       //     DefaultColors.green_0,
                //     //       //   ],
                //     //       // ),
                //     //       image: DecorationImage(
                //     //         image: AssetImage(AssetPath.image.card1),
                //     //         // fit: BoxFit.cover,
                //     //       ),
                //     //     ),
                //     //   );
                //     // }),
                //     children: [
                //       ...widget.productsList.asMap().entries.map((entry) {
                //         final index = entry.key; // numeric index (0, 1, 2, ...)
                //         final product = entry.value; // your list item
                //         consoleLog('index $index');
                //         return Container(
                //           // margin: EdgeInsets.symmetric(horizontal: 20),
                //           // duration: const Duration(milliseconds: 100),
                //           // height: 180,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(24),
                //             // gradient: LinearGradient(
                //             //   colors: [
                //             //     DefaultColors.greenStatus,
                //             //     DefaultColors.green_0,
                //             //   ],
                //             // ),
                //             image: DecorationImage(
                //               image: AssetImage(AssetPath.image.card1),
                //               // fit: BoxFit.cover,
                //             ),
                //           ),
                //         );
                //       }),
                //     ],
                //   ),
                // ),
                StackedPageViewExample(productsList: widget.productsList),
                Center(
                  child: UiTextNew.b14Medium(
                    'Card',
                    color: DefaultColors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 2,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.productsList.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 16,
                  ),
                  width: currentIndex == index ? 32 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? DefaultColors.white
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StackedPageViewExample extends ConsumerStatefulWidget {
  const StackedPageViewExample({super.key, required this.productsList});

  final List productsList;

  // @override
  // _StackedPageViewExampleState createState() => _StackedPageViewExampleState();
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StackedPageViewExampleState();
}

class _StackedPageViewExampleState
    extends ConsumerState<StackedPageViewExample> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: widget.productsList.isEmpty
          ? SizedBox()
          : PageView.builder(
              controller: _pageController,
              itemCount: widget.productsList.length,
              onPageChanged: (value) {
                ref.read(productIndex.notifier).state = value;
              },
              itemBuilder: (context, index) {
                bool active = index == currentPage;
                // return stackedCard(widget.productsList[index]['image'], active);
                return stackedCard('widget.productsList[index]', active);
              },
            ),
    );
  }

  Widget stackedCard(String imageUrl, bool active) {
    final double margin = active ? 10 : 20;

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(horizontal: margin, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }
}
