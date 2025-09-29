import 'package:flutter/material.dart';

import '../../db_uicomponents.dart';

class UIDrawer extends StatelessWidget {
  final Function() onClose;
  final Function()? onNotified;
  final Function()? onExit;
  final String avtar;
  final String name;
  final TextStyle? fontFamilyStyle;
  final List<FeatureModel> singleTitles;
  final List<FeatureModel> eStatement;
  final List<FeatureModel> pos;
  final List<FeatureModel> kyc;
  final List<FeatureModel> services;
  const UIDrawer(
      {super.key,
      required this.onClose,
      required this.avtar,
      required this.name,
      this.fontFamilyStyle,
      this.onNotified,
      this.onExit,
        required this.singleTitles,
        required this.eStatement,
        required this.pos,
        required this.kyc,
        required this.services,
      });

  @override
  Widget build(BuildContext context) {
    Widget outlineCard(
            {required String img,
            required String title,
            Function()? onTap}) =>
        UiCard(
          borderColor: DefaultColors.blue9D.withOpacity(0.2),
          curve: 10,
          child: ListTile(
            leading: UIIconContainer(
              imgAsset: img,
              color: DefaultColors.whiteF3,
            ),
            title: Text(
              title,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)
                  .merge(fontFamilyStyle),
            ),
            trailing: const UIIconButton(
              icon: Icons.arrow_forward_ios,
              iconSize: 16,
              iconColor: DefaultColors.blue9D,
            ),
              onTap: onTap
          ),
        );

    Widget columTitle({required String img, required String name}) => SizedBox(
      // height: context.screenHeight / 12,

      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIIconContainer(
              imgAsset: img,
              color: DefaultColors.whiteF3,
            ),
            const UiSpace.vertical(10),
            const Spacer(),
            Text(
              name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400)
                  .merge(fontFamilyStyle),
            )
          ],
        ),
      ),
    );

    Widget rowWidgetCard(
        {required List<FeatureModel> features}) =>
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: features.map((feature) => InkWell(onTap: feature.onTap,child: columTitle(img: feature.icon,name: feature.name),)).toList(),
      ),
    );

    return Drawer(
      width: context.screenWidth,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          const UiSpace.vertical(50),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UIIconButton(
                  icon: Icons.arrow_back,
                  onTap: onClose,
                ),
                const UiSpace.horizontal(20),
                UIIconContainer(
                  /// TODO - Replace it with imgNetwork on api integration
                  imgAsset: avtar,
                  iconSize: 35,
                )
              ],
            ),
            minVerticalPadding: 0,
            dense: true,
            title: Text(
              name,
              style: context.textTheme.titleMedium
                  ?.copyWith(fontSize: 16)
                  .merge(fontFamilyStyle),
            ),
            subtitle: Text(
              'VIEW PROFILE',
              style: context.textTheme.titleMedium
                  ?.copyWith(
                      fontSize: 11,
                      letterSpacing: 0,
                      color: DefaultColors.blue9D)
                  .merge(fontFamilyStyle),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UIIconButton(
                  icon: Icons.notifications_none_rounded,
                  onTap: onNotified,
                ),
                const UiSpace.horizontal(10),
                UIIconButton(
                  icon: Icons.logout,
                  onTap: onExit,
                ),
              ],
            ),
          ),
          if(singleTitles.isNotEmpty)
            ...singleTitles.map((feature) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: outlineCard(img: feature.icon, title: feature.name, onTap: feature.onTap),
              );
            }),

          if(eStatement.isNotEmpty)
            const UiSpace.vertical(5),
            if(eStatement.isNotEmpty)
          UiCard(
            curve: 10,
            borderColor: DefaultColors.blue9D.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('e-Statement Settings', style: context.textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)
                  .merge(fontFamilyStyle),),
                  const UiSpace.vertical(20),
                  rowWidgetCard(features: eStatement)
                ],
              ),
            ),
          ),

          if(pos.isNotEmpty)
            const UiSpace.vertical(10),
          if(pos.isNotEmpty)
            UiCard(
              curve: 10,
              borderColor: DefaultColors.blue9D.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('POS', style: context.textTheme.bodyMedium
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)
                        .merge(fontFamilyStyle),),
                    const UiSpace.vertical(20),
                    rowWidgetCard(features: pos)
                  ],
                ),
              ),
            ),

          if(kyc.isNotEmpty)
            const UiSpace.vertical(10),
          if(kyc.isNotEmpty)
            UiCard(
              curve: 10,
              borderColor: DefaultColors.blue9D.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('KYC', style: context.textTheme.bodyMedium
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)
                        .merge(fontFamilyStyle),),
                    const UiSpace.vertical(20),
                    rowWidgetCard(features: kyc)
                  ],
                ),
              ),
            ),

          if(services.isNotEmpty)
            const UiSpace.vertical(10),
          if(services.isNotEmpty)
            UiCard(
              curve: 10,
              borderColor: DefaultColors.blue9D.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Services', style: context.textTheme.bodyMedium
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600)
                        .merge(fontFamilyStyle),),
                    const UiSpace.vertical(20),
                    rowWidgetCard(features: services)
                  ],
                ),
              ),
            ),
          const UiSpace.vertical(20),
        ],
      ),
    );
  }
}

class FeatureModel{

  final String icon;
  final String name;
  final Function()? onTap;

  FeatureModel({
    required this.icon,
    required this.name,
    this.onTap,
  });
}
