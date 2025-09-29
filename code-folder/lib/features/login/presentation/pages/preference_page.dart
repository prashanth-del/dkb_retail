import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/utils/extensions/locale_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils.dart';
import '../../../../core/cache/global_cache.dart';
import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/i18n/localization.dart';
import '../../../../core/router/app_router.dart';
import '../controller/login_providers.dart';

@RoutePage()
class PreferencePage extends ConsumerStatefulWidget {
  static const String routeName = "/preference";

  const PreferencePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreferencePageState();
}

class _PreferencePageState extends ConsumerState<PreferencePage> {
  int _selectedCountry = 0;
  int _selectedLanguage = 0;

  bool _canSkipToLocale = false;

  final List<Map<String, dynamic>> countries = [
    // only qatar for 1st phase
    {'name': 'QATAR', 'flag': 'assets/images/flags/qatar.png'},
    {'name': 'UAE', 'flag': 'assets/images/flags/uae.png'},
    {'name': 'Kuwait', 'flag': 'assets/images/flags/kuwait.png'},
    // {
    //   'name': 'India',
    //   'flag': 'assets/images/flags/in.png',
    // },
  ];

  final List<Map<String, dynamic>> languages = [
    {'name': 'English'},
    {'name': 'العربية'},
  ];

  String version = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      version = await getAppVersion();
    });
  }

  Future<void> _handleNavigation() async {
    final isPrefSeen = ref.read(preferenceSeenProvider);
    if (!isPrefSeen) {
      await GlobalCache.instance.setPreferenceSeen();
    }
    _navigate();
  }

  void _navigate() {
    context.router.replace(const OnBoardRoute());
  }

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;

    // GlobalCache.instance.isLightTheme()
    //     ? setSystemBar(color: Colors.transparent, brightness: Brightness.dark)
    //     : setSystemBar(color: Colors.transparent, brightness: Brightness.dark);
    return Scaffold(
      backgroundColor: DefaultColors.white_f3,
      body: SizedBox.expand(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UiSpace.vertical(60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetPath.image.new_logo,
                          height: 50,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                    const UiSpace.vertical(50),
                    UiTextNew.h2Semibold(
                      ref.getLocaleString(
                        'Select_Preferences',
                        defaultValue: "Select Preferences",
                      ),
                    ),
                    const UiSpace.vertical(20),
                    UiTextNew.h4Regular(
                      ref.getLocaleString(
                        "Select_Language",
                        defaultValue: "Select Language",
                      ),
                    ),
                    const UiSpace.vertical(20),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: languages
                          .map(
                            (item) => Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedLanguage = languages.indexOf(item);
                                    _canSkipToLocale = true;
                                  });
                                  if (_selectedLanguage == 0) {
                                    consoleLog("En");
                                    ref.switchLocale(LocaleId.en);
                                  } else {
                                    consoleLog("Ar");
                                    ref.switchLocale(LocaleId.ar);
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  margin: EdgeInsets.only(
                                    right: languages.indexOf(item) == 0 ? 5 : 0,
                                    left: languages.indexOf(item) != 0 ? 5 : 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        _selectedLanguage ==
                                            languages.indexOf(item)
                                        ? DefaultColors.blue60
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: const Border.fromBorderSide(
                                      BorderSide(color: DefaultColors.green2B),
                                    ),
                                  ),
                                  child: Center(
                                    child: UiTextNew.b1Semibold(
                                      ref.getLocaleString(
                                        item['name'],
                                        defaultValue: item['name'],
                                      ),
                                      color:
                                          _selectedLanguage ==
                                              languages.indexOf(item)
                                          ? DefaultColors.white
                                          : Colors.black,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const UiSpace.vertical(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: UiTextNew.h4Regular(
                        ref.getLocaleString(
                          "Select_Country",
                          defaultValue: "Select Country",
                        ),
                      ),
                    ),
                    const UiSpace.vertical(15),
                    UiCard(
                      cardColor: Colors.transparent,
                      borderColor: Colors.transparent,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        // clipBehavior: Clip.hardEdge,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: countries.length + 1,
                        itemBuilder: (context, index) {
                          if (index < countries.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: ListTile(
                                minVerticalPadding: 0,
                                minTileHeight: 50,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 0,
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedCountry = index;
                                  });
                                },
                                tileColor: _selectedCountry == index
                                    ? DefaultColors.blue60
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: _selectedCountry == index
                                      ? const BorderSide(
                                          color: DefaultColors.green2B,
                                        )
                                      : const BorderSide(color: Colors.white),
                                ),
                                leading: Image.asset(
                                  countries[index]['flag'],
                                  width: 30,
                                  height: 30,
                                ),
                                title: UiTextNew.b1Semibold(
                                  countries[index]['name'],
                                  color: _selectedCountry == index
                                      ? DefaultColors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: UIButton.rounded(
                onPressed: _handleNavigation,
                height: 50,
                maxWidth: context.screenWidth,
              ),
            ),
            UiTextNew.b2Regular(
              "Version $version Copyright ©  2025 Dukhan Bank",
              textAlign: TextAlign.center,
            ),
            const UiSpace.vertical(30),
          ],
        ),
      ),
    );
  }
}
