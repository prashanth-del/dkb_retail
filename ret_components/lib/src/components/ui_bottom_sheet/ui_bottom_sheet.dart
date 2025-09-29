library ui_bottom_sheet;

import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'src/ui_sort_bottom_sheet.dart';

part 'src/ui_location_bottom_sheet.dart';

class _BottomSheetPersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Color? color;

  _BottomSheetPersistentHeader({
    required this.child,
    this.color,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: color ?? Theme.of(context).colorScheme.surface, child: child);
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class ViewableSheetContent {
  final String title;
  final String description;

  ViewableSheetContent({required this.title, required this.description});
}

class UiBottomSheet {
  static const List<String> downloadList = ['PDF'];
  static const List<String> sortList = [];

  static showDownloadAsBottomSheet({
    required BuildContext context,
    List<String> downloadList = downloadList,
    String description = "Are you sure you want to download this file?",
    String download = "Download",
    String cancel = "Cancel",
    String? title,
    required ValueChanged<int> onDownload,
  }) =>
      UIPopupDialog().showBottomSheet(
        context: context,
        minHeight: 0,
        child: Builder(builder: (context) {
          int selectedOption = 0;
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                      UiTextNew.b1Semibold(download,
                          color: DefaultColors.white_800),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close,
                            color: DefaultColors.gray8A, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(builder: (context, setState) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UiTextNew.h3Semibold(title ?? ""),
                          UiTextNew.b2Regular(
                            description,
                            color: DefaultColors.gray7D,
                          )
                        ],
                      ),
                    );
                  }),
                  Row(
                    children: [
                      UIButton.primary(
                        maxWidth: 350,
                        height: 35,
                        isRoundedButton: true,
                        label: cancel,
                        txtColor: DefaultColors.blue9D,
                        backgroundColor:
                            DefaultColors.white_500.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ).expanded(),
                      const UiSpace.horizontal(10),
                      UIButton.primary(
                        maxWidth: 350,
                        height: 35,
                        isRoundedButton: true,
                        label: download,
                        onPressed: () {
                          onDownload(0);
                          Navigator.of(context).pop();
                        },
                      ).expanded(),
                    ],
                  ),
                  const UiSpace.vertical(10)
                ],
              ),
            ),
          );
        }),
      );

  static _showConfirmationDownloadSheet({
    required BuildContext context,
    List<String> downloadList = downloadList,
    required String title,
  }) =>
      UIPopupDialog().showBottomSheet(
        context: context,
        minHeight: 0,
        barrierColor: DefaultColors.transparent,
        child: Builder(builder: (context) {
          int selectedOption = 0;
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                      const UiTextNew.b1Semibold("Download",
                          color: DefaultColors.white_800),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        },
                        child: const Icon(Icons.close,
                            color: DefaultColors.gray8A, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1.5,
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(builder: (context, setState) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UiTextNew.h3Semibold(title),
                          const UiTextNew.b2Regular(
                            "Are you sure want to download this file?",
                            color: DefaultColors.gray7D,
                          )
                        ],
                      ),
                    );
                  }),
                  Row(
                    children: [
                      UIButton.primary(
                        maxWidth: 350,
                        height: 35,
                        isRoundedButton: true,
                        label: 'Cancel',
                        txtColor: DefaultColors.blue9D,
                        backgroundColor:
                            DefaultColors.white_500.withOpacity(0.5),
                        onPressed: () {
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        },
                      ).expanded(),
                      const UiSpace.horizontal(10),
                      UIButton.primary(
                        maxWidth: 350,
                        height: 35,
                        isRoundedButton: true,
                        label: 'Download',
                        onPressed: () {
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        },
                      ).expanded(),
                    ],
                  ),
                  const UiSpace.vertical(10)
                ],
              ),
            ),
          );
        }),
      );

  static showSortByBottomSheet({
    required BuildContext context,
    List<String> sortList = sortList,
    required ValueChanged<int> onSelect,
  }) =>
      UIPopupDialog().showBottomSheet(
        context: context,
        child: SizedBox(
          height: 430,
          child: Builder(builder: (context) {
            int selectedOption = 0;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      const UiTextNew.b1Semibold("Sort By",
                          color: DefaultColors.white_800),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close,
                            color: DefaultColors.gray8A, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 350,
                  child: Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: StatefulBuilder(builder: (context, setState) {
                    return ListView.builder(
                      shrinkWrap: false,
                      itemCount: sortList.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedOption == index;
                        return UiCard(
                          onTap: () {
                            setState(() {
                              selectedOption = index;
                            });
                          },
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          cardColor: isSelected
                              ? DefaultColors.blue_200.withOpacity(0.3)
                              : DefaultColors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              if (isSelected)
                                const UIIconButton(
                                  icon: Icons.check,
                                  iconColor: DefaultColors.gray9D,
                                ),
                              const UiSpace.horizontal(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    isSelected
                                        ? UiTextNew.b1Semibold(
                                            sortList[index],
                                            color: DefaultColors.gray9D,
                                          )
                                        : UiTextNew.b1Semibold(
                                            sortList[index],
                                            color: DefaultColors.white_700,
                                          ),

                                    // if(isSelected)
                                    // UiTextNew.b1Semibold(downloadList[index],
                                    //   color:
                                    //       DefaultColors.blue_600
                                    //      ),
                                    // UiTextNew.b1Regular(downloadList[index],
                                    //   color:
                                    //       DefaultColors.black, ),

                                    const UiSpace.vertical(4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: UIButton.primary(
                    maxWidth: 350,
                    height: 40,
                    label: 'Select',
                    onPressed: () {
                      print("selectedOption-$selectedOption");
                      Navigator.pop(context);
                      onSelect(selectedOption);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      );

  static viewableSheet({
    required BuildContext context,
    required List<ViewableSheetContent> content,
    required String title,
  }) {
    final viewSize = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints(
        /// min height of bottom sheet
        minHeight: viewSize.height * 0.1,

        /// max height of bottom sheet
        maxHeight: viewSize.height * 0.5,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            /// title bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _BottomSheetPersistentHeader(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Expanded(
                              child: UiTextNew.b1Semibold(
                            title,
                          )),
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close))
                        ],
                      ),
                    ),
                    const Divider(
                      color: DefaultColors.blue_02,
                    ),
                  ],
                ),
              ),
            ),

            /// contents
            SliverList.separated(
              itemCount: content.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UiTextNew.b2Regular(content[index].title,
                      color: DefaultColors.white_700),
                  UiTextNew.b1Semibold(content[index].description,
                      color: DefaultColors.blue9D)
                ],
              ),
            ),

            /// bottom space
            const SliverToBoxAdapter(
              child: UiSpace.vertical(16),
            )
          ],
        ),
      ),
    );
  }

  @Deprecated("for content scroll, where button is pinned to bottom use "
      "[selectableScrollSheet]")
  static selectableSheet({
    required BuildContext context,
    required List<String> content,
    required String title,
    required String confirmButtonTitle,
    required ValueChanged<int> onSelectedConfirm,
    int selectedIndex = 0,
  }) {
    final viewSize = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints(
        /// min height of bottom sheet
        minHeight: viewSize.height * 0.1,

        /// max height of bottom sheet
        maxHeight: viewSize.height * 0.5,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        int selectedOption = selectedIndex;

        final scrollController = ScrollController();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            controller: scrollController,
            shrinkWrap: true,
            slivers: [
              /// title bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _BottomSheetPersistentHeader(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32, bottom: 4),
                        child: SizedBox(
                          height: 24,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.chevron_left,
                                ),
                              ),
                              UiTextNew.b1Semibold(
                                title,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0xFF7D7D7D),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: DefaultColors.blue_02,
                      ),
                    ],
                  ),
                ),
              ),
              // todo : add search bar below the title bar
              /// contents
              StatefulBuilder(
                builder: (context, setState) {
                  return SliverList.separated(
                    itemCount: content.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 12,
                    ),
                    itemBuilder: (context, index) {
                      bool isSelected = selectedOption == index;
                      return UiCard(
                        onTap: () {
                          setState(() {
                            selectedOption = index;
                          });
                        },
                        // margin: const EdgeInsets.symmetric(
                        //     vertical: 5, horizontal: 15),
                        cardColor: isSelected
                            ? DefaultColors.blue_200.withOpacity(0.3)
                            : DefaultColors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                // Adjust the padding values as needed
                                child: UIIconButton(
                                  icon: Icons.check,
                                  iconColor: DefaultColors.blue_600,
                                ),
                              ),
                            const UiSpace.horizontal(15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (isSelected)
                                    UiTextNew.b1Semibold(
                                      content[index],
                                      color: DefaultColors.blue_600,
                                    ),
                                  if (!isSelected)
                                    UiTextNew.b1Regular(
                                      content[index],
                                      color: DefaultColors.black,
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              /// footer
              // todo : keep the footer pinned to bottom
              SliverToBoxAdapter(
                child: UIButton.primary(
                  height: 40,
                  label: confirmButtonTitle,
                  isRoundedButton: true,
                  onPressed: () {
                    Navigator.pop(context);
                    onSelectedConfirm(selectedOption);
                  },
                ),
              )
              // /// bottom space
              // const SliverToBoxAdapter(
              //   child: UiSpace.vertical(16),
              // )
            ],
          ),
        );
      },
    );
  }

  static selectableScrollSheet({
    required BuildContext context,
    required List<String> content,
    required String title,
    required String confirmButtonTitle,
    required ValueChanged<int> onSelectedConfirm,
    List<Widget> childrenAboveBottomButton = const [],
    bool showBottomButton = true,
    int selectedIndex = 0,
  }) {
    final viewSize = MediaQuery.sizeOf(context);
    return showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints(
        /// min height of bottom sheet
        minHeight: viewSize.height * 0.1,

        /// max height of bottom sheet
        maxHeight: viewSize.height * 0.5,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        int selectedOption = selectedIndex;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: UiTextNew.b1Semibold(
                          title,
                        )),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  const Divider(
                    color: DefaultColors.blue_02,
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: content.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemBuilder: (context, index) {
                        bool isSelected = selectedOption == index;
                        return UiCard(
                          onTap: () {
                            setState(() {
                              selectedOption = index;
                            });
                          },
                          // margin: const EdgeInsets.symmetric(
                          //     vertical: 5, horizontal: 15),
                          cardColor: isSelected
                              ? DefaultColors.blue_200
                              : DefaultColors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12.0),
                          child: Row(
                            children: [
                              if (isSelected)
                                const UIIconButton(
                                  icon: Icons.check,
                                  iconColor: DefaultColors.blue_600,
                                ),
                              const UiSpace.horizontal(15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UiTextNew.b1Semibold(
                                      content[index],
                                      color: isSelected
                                          ? DefaultColors.blue_600
                                          : DefaultColors.gray7D,
                                    )

                                    // Text(
                                    //   content[index],
                                    //   style: TextStyle(
                                    //     fontSize: 16,
                                    //     color: isSelected
                                    //         ? DefaultColors.blue_600
                                    //         : DefaultColors.black,
                                    //     fontWeight: isSelected
                                    //         ? FontWeight.w600
                                    //         : FontWeight.w400,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              ...childrenAboveBottomButton,
              const UiSpace.vertical(8.0),
              Visibility(
                visible: showBottomButton,
                child: UIButton.rounded(
                  onPressed: () {},
                  margin: const EdgeInsets.all(2.0),
                ),
              ),
              const UiSpace.vertical(8.0),
            ],
          ),
        );
      },
    );
  }

  static customSheet({
    required BuildContext context,
    required String title,
    required Widget child,
    List<Widget> childrenAboveBottomButton = const [],
    bool showBottomButton = true,
    Color? titlecolor,
    Color? iconColor,
    String backIconPath = "assets/svg/Right.svg",
    String closeIconPath = "assets/icons/close.svg",
    bool hasKeyboardInteractions = false,
  }) {
    final viewSize = MediaQuery.sizeOf(context);

    showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints(
        /// min height of bottom sheet
        minHeight: viewSize.height * 0.1,

        /// max height of bottom sheet
        maxHeight:
            hasKeyboardInteractions ? viewSize.height : viewSize.height * 0.6,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        final viewInsets = MediaQuery.viewInsetsOf(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20) +
              EdgeInsets.only(bottom: viewInsets.bottom, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Row(
                      children: [
                        UISvgIcon(
                          assetPath: backIconPath,
                          color: iconColor ?? Colors.grey,
                          onTap: () => Navigator.pop(context),
                        ).toDirectional(context),
                        const UiSpace.horizontal(10),
                        Expanded(
                            child: UiTextNew.b1Semibold(
                          title,
                          color: titlecolor ?? Colors.black,
                        )),
                        UISvgIcon(
                          assetPath: closeIconPath,
                          color: iconColor ?? Colors.grey,
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: DefaultColors.blue_02,
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: child,
              ),
              ...childrenAboveBottomButton,
              Visibility(
                visible: showBottomButton,
                child: UIButton.rounded(
                  onPressed: () {},
                  margin: const EdgeInsets.all(2.0),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static showTransactionTypeSheet(BuildContext context, elements,
      String selectedType, ValueChanged<String> onSelection,
      {String title = "Transactions", required List<String> displayTitles}) {
    UiBottomSheet.customSheet(
        context: context,
        title: title,
        child: Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: StatefulBuilder(builder: (context, updateState) {
            return UIListView(
                elements: elements,
                scrollPhysics: const AlwaysScrollableScrollPhysics(),
                direction: Axis.vertical,
                itemBuilder: (context, index) {
                  String currentType = elements[index];
                  bool isSelected = currentType == selectedType;
                  return UiCard(
                    onTap: () {
                      updateState(() {
                        onSelection(currentType);
                        Navigator.pop(context);
                      });
                    },
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    cardColor: isSelected
                        ? DefaultColors.blue_100
                        : DefaultColors.white,
                    child: Row(
                      children: [
                        if (isSelected) ...[
                          const Icon(Icons.check, color: DefaultColors.blue9D),
                          const UiSpace.horizontal(10),
                        ],
                        isSelected
                            ? UiTextNew.b1Semibold(
                                displayTitles[index],
                                color: isSelected
                                    ? DefaultColors.blue9D
                                    : DefaultColors.black,
                              )
                            : UiTextNew.b1Regular(
                                displayTitles[index],
                                color: isSelected
                                    ? DefaultColors.blue9D
                                    : DefaultColors.black,
                              ),
                      ],
                    ),
                  );
                });
          }),
        ),
        showBottomButton: false);
  }

  static basicSheet({
    required BuildContext context,
    required String title,
    required Widget child,
    required backIconPath,
    Color backgroundColor = DefaultColors.white,
    double maxHeightPercentage = 0.5,
  }) {
    final viewSize = MediaQuery.sizeOf(context);
    ScrollController _scrollController = ScrollController();
    showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints(
        /// min height of bottom sheet
        minHeight: viewSize.height * 0.1,

        /// max height of bottom sheet
        maxHeight: viewSize.height * maxHeightPercentage,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -2),
                  leading: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: UISvgIcon(
                        assetPath: backIconPath,
                        height: 15,
                        width: 12,
                      )),
                  title: UiTextNew.b1Semibold(
                    title,
                    textAlign: TextAlign.start,
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: DefaultColors.grey_05,
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  onTap: () => Navigator.of(context).pop(),
                ),
                const UiSpace.vertical(10),
                const Divider(
                  color: DefaultColors.blue_02,
                  // indent: viewSize.width * 0.05,
                  // endIndent: viewSize.width * 0.05,
                ),
              ],
            ),
            Expanded(
              child: UiScrollBar(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16.0), // Optional padding
                    child: child,
                  ),
                ),
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static sortBy(
      {required BuildContext context,
      required List<String> items,
      String? title,
      String? selectedValue,
      int? selectedIndex,
      String confirmButtonTitle = "Select",
      required ValueChanged<int> onItemSelected}) {
    final viewSize = MediaQuery.sizeOf(context);
    showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: viewSize.height * 0.1,
        maxHeight: viewSize.height,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UiSortBottomSheet(
            context: context,
            selectedValue: selectedValue,
            items: items,
            title: title,
            initialSelectedIndex: selectedIndex ?? 0,
            confirmButtonTitle: confirmButtonTitle,
            onItemSelected: onItemSelected);
      },
    );
  }

  static locationSheet(
      {required BuildContext context,
      required List<String> items,
      String? title,
      int? selectedIndex,
      required ValueChanged<int> onItemSelected}) {
    final viewSize = MediaQuery.sizeOf(context);
    showModalBottomSheet(
      enableDrag: false,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: viewSize.height * 0.1,
        maxHeight: viewSize.height * 0.5,
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UiLocationBottomSheet(
            context: context,
            items: items,
            title: title,
            initialSelectedIndex: selectedIndex,
            confirmButtonTitle: "Select",
            onItemSelected: onItemSelected);
      },
    );
  }
}
