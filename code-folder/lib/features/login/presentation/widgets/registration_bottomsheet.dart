import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:dkb_retail/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationBottomsheet extends ConsumerStatefulWidget {
  const RegistrationBottomsheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationBottomsheetState();
}

class _RegistrationBottomsheetState
    extends ConsumerState<RegistrationBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 10),
      decoration: BoxDecoration(
        color: DefaultColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 6,
              width: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: DefaultColors.gray0F,
              ),
            ),
          ),
          UiSpace.vertical(20),
          UiTextNew.custom(
            "Register now",
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: DefaultColors.bluebase,
          ),
          UiSpace.vertical(30),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xffdce4e9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      AssetPath.image.reg1,
                      width: 92,
                      height: 92,
                      fit: BoxFit.cover,
                    ),
                  ),
                  UiSpace.horizontal(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UiTextNew.custom(
                          'Create bank account',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        UiSpace.vertical(4),
                        UiTextNew.custom(
                          'If you don’t have banking account\nwith us.',
                          fontSize: 12,
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          UiSpace.vertical(24),
          GestureDetector(
            onTap: () {
              context.router.maybePop();
              context.router.push(RegistrationStartRoute());
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xffdce4e9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      AssetPath.image.reg2,
                      width: 92,
                      height: 92,
                      fit: BoxFit.cover,
                    ),
                  ),
                  UiSpace.horizontal(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UiTextNew.custom(
                          'Register using card',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        UiSpace.vertical(4),
                        UiTextNew.custom(
                          'If you already have an Dukhan\nBank card',
                          fontSize: 12,
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // UiImageTile(
          //   title: 'Create bank account',
          //   subtitle: 'If you don’t have banking account with us.',
          //   imageName: AssetPath.image.reg1,
          // ),
          // UiSpace.vertical(24),
          // UiImageTile(
          //   ontap: () {
          //     context.router.push(RegistrationStartRoute());
          //   },
          //   title: 'Register using card',
          //   subtitle: 'If you already have an Dukhan Bank card',
          //   imageName: AssetPath.image.reg2,
          // ),
          // UiSpace.vertical(24),
        ],
      ),
    );
  }
}
