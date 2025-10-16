import 'package:async_ui/async_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:dkb_retail/core/theme/tokens/theme_extension.dart';
import 'package:dkb_retail/extensions/image_extension.dart';
import 'package:dkb_retail/features/product_offering/data/models/fetch_apply_products_request.dart';
import 'package:dkb_retail/features/product_offering/domain/entities/bank_products.dart';
import 'package:dkb_retail/features/product_offering/presentation/controller/fetch_apply_products_notifier.dart';
import 'package:dkb_retail/features/product_offering/presentation/state/fetch_apply_products_state.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(fetchApplyProductsNotifierProvider.notifier)
          .fetchApplyProducts(request: FetchApplyProductsRequest());
    });
    getDeviceInfod();
  }

  Future<void> getDeviceInfod() async {
    final deviceData = await getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    // var data = ref.watch(productOfferingNotifierProvider);
    // var data1 = ref.watch(fetchApplyProductsNotifierProvider);
    // bool isLoading = ref.watch(productsloadingProvider);
    return Scaffold(
      body: RxView<FetchApplyProductsState, List<BankProducts>>(
        stateProvider: fetchApplyProductsNotifierProvider,
        map: (FetchApplyProductsState state) {
          return state.when(
            initial: () {
              return AsyncValue.data([]);
            },
            loading: () {
              return AsyncValue.loading();
            },
            success: (value) {
              return AsyncValue.data(value);
            },
            failure: (error) {
              //showErrorDialog(error, context, ref);
              return AsyncValue.error(error, StackTrace.current);
            },
          );
        },
        data: (BuildContext context, List<BankProducts> data) {
          return data.isNotEmpty
              ? bankProducts(data)
              : Center(child: Text('No Data Available'));
        },
        // onError: (error, stackTrace) {
        //   return showErrorDialog(error.toString(), context, ref);
        // },
        error: (context, error, stackTrace) {
          return Center(
            child: UiErrorDialog(
              title: "Error",
              message: error.toString(),
              buttonText: "OK",
              onOk: () {
                context.router.maybePop();
              },
            ),
          );
        },
      ),
      // body: data1.when(
      //   initial: () {
      //     return Center(child: Text('initial'));
      //   },
      //   loading: () {
      //     return Center(child: UiLoader());
      //   },
      //   success: (data) {
      //     return bankProducts(data);
      //   },
      //   failure: (v) {
      //     return Text('error $v');
      //   },
      // ),

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
    );
  }

  Widget bankProducts(List<BankProducts> data) {
    final List<BankProducts> cardProducts = data
        .where((p) => p.productCategory == 'Cards')
        .toList();

    final List<BankProducts> otherProducts = data
        .where((p) => p.productCategory != 'Cards')
        .toList();

    return SingleChildScrollView(
      child: data.isEmpty
          ? Center(child: Text('No Products Avaiable'))
          : Column(
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
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      DefaultString.instance.products,
                      style: TextStyle(
                        fontSize: 20,
                        color: DefaultColors.blue9D,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Expanded(child: CommonAuthAppBar(title: 'Products')),
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
                UiSpace.vertical(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: UiTextNew.custom(
                    'Smart, secure, and tailored products for your lifestyle—choose from amazing range of Credit Card offers, Deposit instruments and more...',
                    maxLines: 3,
                    fontSize: 12,
                    color: Color(0xff828080),
                  ),
                ),
                UiSpace.vertical(80),
                buildCardWidget(cardProducts),

                // cardProducts.map((field) {
                //     // if (field.productCategory == 'Cards') {
                //     //   return ;
                //     // }
                //     return buildCardWidget(cardProducts);
                //   }).toList()
                UiSpace.vertical(40),
                buildOtherProducts(otherProducts),
                // Row(
                //   children: [
                //     UiSpace.horizontal(16),

                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           context.router.push(
                //             ProductOfferingDetailsRoute(title: 'Deposits'),
                //           );
                //         },
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Stack(
                //               clipBehavior: Clip.none,
                //               children: [
                //                 Hero(
                //                   tag: 'Deposits',
                //                   child: Container(
                //                     alignment: Alignment.bottomCenter,
                //                     padding: EdgeInsets.symmetric(
                //                       horizontal: 12,
                //                       vertical: 12,
                //                     ),
                //                     height: 210,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(16),
                //                       gradient: LinearGradient(
                //                         begin: Alignment.bottomLeft,
                //                         end: Alignment.topRight,
                //                         colors: [
                //                           Color(0xff334546),
                //                           Color(0xff212132),
                //                         ],
                //                       ),
                //                     ),
                //                     child: Row(
                //                       children: [
                //                         Flexible(
                //                           child: UiTextNew.custom(
                //                             'Safe, reliable deposits to grow your wealth.',
                //                             color: context.bankTheme.cardColor,
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.w500,
                //                             maxLines: 3,
                //                             overflow: TextOverflow.fade,
                //                           ),
                //                         ),
                //                         Container(
                //                           height: 32,
                //                           width: 32,
                //                           decoration: BoxDecoration(
                //                             shape: BoxShape.circle,
                //                             color: context.colorScheme.surface,
                //                           ),
                //                           child: Transform.rotate(
                //                             angle: 46,
                //                             child: Icon(Icons.arrow_back),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 Positioned(
                //                   bottom: 45,
                //                   left: 0,
                //                   right: 0,
                //                   child: Image.asset(AssetPath.image.productImg),
                //                 ),
                //               ],
                //             ),
                //             UiSpace.vertical(12),
                //             UiTextNew.b1Semibold('Deposits'),
                //           ],
                //         ),
                //       ),
                //     ),
                //     UiSpace.horizontal(16),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           context.router.push(
                //             ProductOfferingDetailsRoute(title: 'Finance'),
                //           );
                //         },
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Stack(
                //               clipBehavior: Clip.none,
                //               children: [
                //                 Hero(
                //                   tag: 'Finance',
                //                   child: Container(
                //                     alignment: Alignment.bottomCenter,
                //                     padding: EdgeInsets.symmetric(
                //                       horizontal: 12,
                //                       vertical: 12,
                //                     ),
                //                     height: 210,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(16),
                //                       gradient: LinearGradient(
                //                         begin: Alignment.bottomLeft,
                //                         end: Alignment.topRight,
                //                         colors: [
                //                           Color(0xff334546),
                //                           Color(0xff212132),
                //                         ],
                //                       ),
                //                     ),
                //                     child: Row(
                //                       children: [
                //                         Flexible(
                //                           child: UiTextNew.custom(
                //                             'Flexible finance solutions to make dreams come true.',
                //                             color: context.bankTheme.cardColor,
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.w500,
                //                             maxLines: 3,
                //                             overflow: TextOverflow.fade,
                //                           ),
                //                         ),
                //                         Container(
                //                           height: 32,
                //                           width: 32,
                //                           decoration: BoxDecoration(
                //                             shape: BoxShape.circle,
                //                             color: context.colorScheme.surface,
                //                           ),
                //                           child: Transform.rotate(
                //                             angle: 46,
                //                             child: Icon(Icons.arrow_back),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 Positioned(
                //                   bottom: 70,
                //                   left: 0,
                //                   right: 0,
                //                   child: Image.asset(
                //                     AssetPath.image.financeimg,
                //                     // fit: BoxFit.cover,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             UiSpace.vertical(12),
                //             UiTextNew.b1Semibold('Finance'),
                //           ],
                //         ),
                //       ),
                //     ),
                //     UiSpace.horizontal(16),
                //   ],
                // ),
              ],
            ),
    );
  }

  Widget buildOtherProducts(List<BankProducts> data) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 4.5,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.router.push(
              ProductOfferingDetailsRoute(
                title: data[index].productName,
                products: data[index].subProducts,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Hero(
                    tag: data[index].productName,
                    child: Container(
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
                          colors: [Color(0xff334546), Color(0xff212132)],
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: UiTextNew.custom(
                              // 'Safe, reliable deposits to grow your wealth.',
                              data[index].productCategory,
                              color: context.bankTheme.cardColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
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
                    top: -25,
                    left: 20,
                    right: 20,
                    // child: Image.asset(AssetPath.image.productImg),
                    child: SizedBox(
                      height: 155,
                      width: 100,
                      // color: Colors.red,
                      child:
                          data[index].productImage.toImageWidget(
                            context: context,
                            height: 155,
                            width: 100,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  AssetPath.image.productImg,
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ) ??
                          Container(),
                    ),
                  ),
                ],
              ),
              UiSpace.vertical(12),
              UiTextNew.b1Semibold(data[index].productName),
            ],
          ),
        );
      },
    );
  }

  Widget buildCardWidget(List<BankProducts> data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.router.push(
              ProductOfferingDetailsRoute(
                title: data.first.productName,
                products: data.first.subProducts,
              ),
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Hero(
                tag: data.first.productName,
                child: Container(
                  height: 170,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                      Expanded(
                        child: UiTextNew.custom(
                          //'Smart, secure cards built for every lifestyle.',
                          data.first.productCategory,
                          color: context.bankTheme.cardColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                left: 40,
                right: 40,
                bottom: 70,
                // child: Image.asset(AssetPath.image.productCards),
                child: SizedBox(
                  height: 165,
                  width: 100,
                  child:
                      data.first.productImage.toImageWidget(
                        context: context,
                        height: 165,
                        width: 100,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              AssetPath.image.productImg,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ) ??
                      Container(),
                ),
              ),
            ],
          ),
        ),
        UiSpace.vertical(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: UiTextNew.b1Semibold(data.first.productCategory),
        ),
      ],
    );
  }
}
