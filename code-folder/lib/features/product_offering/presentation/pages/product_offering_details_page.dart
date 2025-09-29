import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/extensions/context_extension.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/product_offering_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductOfferingDetailsPage extends ConsumerStatefulWidget {
  const ProductOfferingDetailsPage({super.key});

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
    },
    {
      "title": "profit in\nAdvance Deposits",
      'subtitle':
          'Our Shari’ah compliant Term Deposit account “Wadiati” gives you the great benefit of collecting your profits upon opening your account. Its has a high-profit accounts periods deposit comfortable and flexible for 6, 12 and 18 months.',
    },
    {
      'title': 'Deposits',
      'subtitle':
          'Fixed Deposits are approved by our Shari’ah Supervisory Committee, Dukhan Bank’s Fixed Deposits allow you to make the most of value-added benefits as you create wealth at low risk.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(productIndex);
    return Scaffold(
      body: Column(
        children: [
          ProductDetailsTopWidget(productsList: depositProducts),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiTextNew.b14Medium(
                      '${depositProducts[currentIndex]['subtitle']}',
                    ),
                    UiSpace.vertical(10),
                    UiTextNew.b14Medium('~ Open with minimum QAR 50,000'),
                    UiSpace.vertical(10),
                    UiTextNew.b14Medium(
                      '~ Flexible deposit methods: cash, cheque, transfer',
                    ),
                  ],
                );
              },
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
                  label: 'Apply',
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
  const ProductDetailsTopWidget({super.key, required this.productsList});

  final List productsList;

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
      tag: 'product',
      child: Container(
        height: context.height(40),
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
            Material(
              color: Colors.transparent,
              child: CommonAuthAppBar(
                title: 'Deposits',
                iconColor: DefaultColors.white,
                titleStyle: TextStyle(color: DefaultColors.white),
              ),
            ),
            Expanded(
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
                              padding: const EdgeInsets.only(left: 46),
                              child: UiTextNew.h1Semibold(
                                widget.productsList[index]['title'],
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
                        3,
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
