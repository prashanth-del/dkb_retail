import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/theme/tokens/theme_extension.dart';
import 'package:dkb_retail/features/product_offering/domain/entities/apply_products.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/product_offering_providers.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/state/product_offering_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductOfferingPage extends ConsumerStatefulWidget {
  const ProductOfferingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductOfferingPageState();
}

class _ProductOfferingPageState extends ConsumerState<ProductOfferingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(productOfferingNotifierProvider.notifier).getProductsOffering();
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = ref.watch(productOfferingNotifierProvider);
    bool isLoading = ref.watch(productsloadingProvider);
    return Scaffold(
      // body: data.when(
      //   data: (data) {
      //     return bankProducts(data: data, isLoading: isLoading);
      //   },
      //   loading: () => Center(
      //     child: UiLoader(
      //       loadingText: ref.getLocaleString(
      //         "Loading",
      //         defaultValue: "Loading...",
      //       ),
      //     ),
      //   ),
      //   error: (e, st) => Center(child: Text('$e')),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiSpace.vertical(40),
            Row(
              children: [
                Expanded(child: CommonAuthAppBar(title: 'Products')),
                // IconButton(
                //   onPressed: () {
                //     showModalBottomSheet(
                //       context: context,
                //       builder: (context) => ThemeToggleSheet(),
                //     );
                //   },
                //   icon: Icon(
                //     Icons.color_lens,
                //     color: context.colorScheme.onSurface,
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: UiTextNew.h5Medium(
                'Smart, secure, and tailored products for your lifestyle—choose from amazing range of Credit Card offers, Deposit instruments and more...',
              ),
            ),
            UiSpace.vertical(80),
            GestureDetector(
              onTap: () {
                context.router.push(ProductOfferingDetailsRoute());
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: 'product',
                    child: Container(
                      height: 170,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xff334546), Color(0xff212132)],
                        ),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: UiTextNew.b14Medium(
                              'Smart, secure cards built for every lifestyle.',
                              color: context.bankTheme.cardColor,
                            ),
                          ),
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.colorScheme.surface,
                            ),
                            child: Transform.rotate(
                              angle: 46,
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Image.asset(AssetPath.image.productCards),
                  ),
                ],
              ),
            ),
            UiSpace.vertical(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: UiTextNew.b1Semibold('Cards'),
            ),
            UiSpace.vertical(40),
            Row(
              children: [
                UiSpace.horizontal(16),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.router.push(ProductOfferingDetailsRoute());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              height: 210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff334546),
                                    Color(0xff212132),
                                  ],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: UiTextNew.b14Medium(
                                      'Safe, reliable deposits to grow your wealth.',
                                      color: context.bankTheme.cardColor,
                                    ),
                                  ),
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colorScheme.surface,
                                    ),
                                    child: Transform.rotate(
                                      angle: 46,
                                      child: Icon(Icons.arrow_back),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 45,
                              left: 0,
                              right: 0,
                              child: Image.asset(AssetPath.image.productImg),
                            ),
                          ],
                        ),
                        UiSpace.vertical(12),
                        UiTextNew.b1Semibold('Deposits'),
                      ],
                    ),
                  ),
                ),
                UiSpace.horizontal(16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.router.push(ProductOfferingDetailsRoute());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              height: 210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff334546),
                                    Color(0xff212132),
                                  ],
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: UiTextNew.b14Medium(
                                      'Flexible finance solutions to make dreams come true.',

                                      color: context.bankTheme.cardColor,
                                    ),
                                  ),
                                  Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.colorScheme.surface,
                                    ),
                                    child: Transform.rotate(
                                      angle: 46,
                                      child: Icon(Icons.arrow_back),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 45,
                              left: 0,
                              right: 0,
                              child: Image.asset(AssetPath.image.productImg),
                            ),
                          ],
                        ),
                        UiSpace.vertical(12),
                        UiTextNew.b1Semibold('Finance'),
                      ],
                    ),
                  ),
                ),
                UiSpace.horizontal(16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bankProducts({
    required List<ApplyProducts> data,
    required bool isLoading,
  }) {
    return Center(child: Text('data ${data.length}'));
  }
}
