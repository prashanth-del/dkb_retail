import 'package:db_uicomponents/db_uicomponents.dart' hide DefaultColors;
import 'package:dkb_retail/common/utils.dart';
import 'package:dkb_retail/core/cache/locale_cache.dart';
import 'package:dkb_retail/core/i18n/controller/i18n_notifiers.dart';
import 'package:dkb_retail/core/i18n/localization.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:dkb_retail/features/dashboard/presentation/widgets/animated_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/constants/colors.dart';
import '../controller/login_providers.dart';
import 'language_sheet.dart';
import 'language_sheet_model.dart';

class LoginAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final bool? animatedProfile;
  const LoginAppBar({super.key, this.animatedProfile = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _LoginAppBarState extends ConsumerState<LoginAppBar> {
  final List<String> languageOptions = ["EN", "العربية"];

  Future<void> _buildLanguageSelection() async {
    final int selectedLanguageIndex = ref.watch(selectedLanguageProvider);

    final List<LangBottomSheetModel> languageOptions = [];
    languageOptions.add(
      LangBottomSheetModel(
        index: 0,
        name: ref.getLocaleString('Qatar', defaultValue: "Qatar"),
        image: 'assets/images/flags/qatar.png',
        isSelected: selectedLanguageIndex == 0,
      ),
    );
    // languageOptions.add(LangBottomSheetModel(
    //   index: 1,
    //   name: ref.getLocaleString('USA', defaultValue: "USA"),
    //   image: 'assets/images/flags/usa.png',
    //   isSelected: selectedLanguageIndex == 1,
    // ));
    languageOptions.add(
      LangBottomSheetModel(
        index: 1,
        name: ref.getLocaleString('UAE', defaultValue: "UAE"),
        image: 'assets/images/flags/uae.png',
        isSelected: selectedLanguageIndex == 1,
      ),
    );
    languageOptions.add(
      LangBottomSheetModel(
        index: 2,
        name: ref.getLocaleString('Kuwait', defaultValue: "Kuwait"),
        image: 'assets/images/flags/kuwait.png',
        isSelected: selectedLanguageIndex == 2,
      ),
    );

    final LanguageSheetModel languageSheetModel = LanguageSheetModel(
      title: ref.getLocaleString(
        'Select_Country',
        defaultValue: "Select your Country",
      ),
      itemList: languageOptions,
    );
    LangBottomSheetModel? item = await UIPopupDialog().showBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: LanguageBottomSheet(languageSheetModel: languageSheetModel),
      ),
    );
    ref.watch(canLocaleSkipProvider.notifier).state = true;
    if (item != null) {
      ref.read(selectedLangFlagProvider.notifier).state = item.image;
      ref.read(selectedLanguageProvider.notifier).state = item.index;
      // final result =
      //     await ref.switchLocale(item.index == 0 ? LocaleId.ar : LocaleId.en);
      // if (result) {
      //   ref.read(selectedLanguageProvider.notifier).state = item.index;
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedLanguageIndex = ref.watch(selectedLanguageProvider);
    final String langFlagPath = ref.watch(selectedLangFlagProvider);

    final isRtl = ref.watch(localePodProvider).languageCode == 'ar';
    final dir = isRtl ? TextDirection.rtl : TextDirection.ltr;
    consoleLog('lan index $selectedLanguageIndex, $isRtl ');

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.animatedProfile ?? false
              ? AnimatedProfilePhoto()
              : CircleAvatar(
                  radius: 20,

                  backgroundColor: Colors.black,
                  child: Image.asset(
                    AssetPath.image.loginHeaderlogo,
                    height: 40,
                  ),
                ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 118,
            height: 30,
            decoration: BoxDecoration(
              color: DefaultColors.white_500.withAlpha(50),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 1,
              ),
            ),
            alignment: Alignment.center,
            child: Stack(
              children: [
                AnimatedAlign(
                  // alignment: ref.watch(selectedLanguageProvider) == 0
                  //     ? Alignment.centerLeft
                  //     : Alignment.centerRight,
                  alignment: isRtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: isRtl ? 74 : 50,
                    decoration: BoxDecoration(
                      color: DefaultColors.white_300.withAlpha(50),
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 1,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: languageOptions
                        .mapWithIndex<Widget>(
                          (lang, index) => GestureDetector(
                            onTap: () {
                              if (LocaleCache.instance.getLocaleId() == 'en') {
                                ref.switchLocale(LocaleId.ar);
                                ref
                                        .read(selectedLanguageProvider.notifier)
                                        .state =
                                    index;
                              } else {
                                ref.switchLocale(LocaleId.en);
                                ref
                                        .read(selectedLanguageProvider.notifier)
                                        .state =
                                    index;
                              }

                              consoleLog('Language Chnage ${ref.getLocale()} ');
                            },
                            child: Text(
                              lang,
                              style: TextStyle(
                                fontSize: 14,
                                color: DefaultColors.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //     margin: const EdgeInsets.only(right: 10),
          //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //     decoration: BoxDecoration(
          //         border: Border.all(color: DefaultColors.white_500),
          //         borderRadius: const BorderRadius.all(Radius.circular(30))),
          //     child: UiTextNew.b14Semibold(
          //       ref.getLocaleString("Eng", defaultValue: "Eng"),
          //       color: DefaultColors.secondaryBlue,
          //     )),
          // UIButton.rounded(
          //   onPressed: _buildLanguageSelection,
          //   backgroundColor: DefaultColors.transparent,
          //   label: ref.getLocaleString("qatar", defaultValue: "Eng"),
          //   txtColor: DefaultColors.button_back,
          //   borderColor: DefaultColors.white_500,
          //   // iconPath: AssetPath.icon.dropDownIcon,
          //   btnCurve: 5,
          //   height: 35,
          // ),
          // const UiSpace.horizontal(5),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     UIIconContainer(
          //       imgAsset: langFlagPath,
          //       color: DefaultColors.white,
          //       size: 28,
          //     ),
          //     UIIconContainer(
          //       onTap: _buildLanguageSelection,
          //       imgAsset: AssetPath.icon.chevron_down,
          //       color: DefaultColors.white,
          //       size: 28,
          //     )
          //   ],
          // ),
          // UIIconContainer(
          //   imgAsset: langFlagPath,
          //   color: DefaultColors.whiteF3,
          //   size: 28,
          // ),
          // const UiSpace.horizontal(10),
        ],
      ),
    );
  }
}
