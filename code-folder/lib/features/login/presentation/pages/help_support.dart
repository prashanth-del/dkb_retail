import 'package:flutter/material.dart';

import '../../../../common/colors.dart';
import '../../../../common/constant.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              color: cardBackGroundColor, // Adds shadow for a modern look
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: _gridSection([
                  GridItem(Constants.branch, 'assets/icons/ic_branch.png',),
                  GridItem(Constants.atm, 'assets/icons/ic_atm.png'),
                  GridItem(Constants.whatsAppConnect, 'assets/icons/ic_whatsapp.png'),
                  GridItem(Constants.contactUs, 'assets/icons/ic_contact_us.png'),
                  GridItem(Constants.faq, 'assets/icons/ic_faq.png'),
                  GridItem(Constants.howToVideos, 'assets/icons/ic_videos.png'),
                  GridItem(Constants.tc, 'assets/icons/ic_terms_condition.png'),
                  GridItem(Constants.socioConnect, 'assets/icons/ic_socio_connect.png'),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
                child: Text(
              Constants.dohaVersion,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: greyText,fontFamily: "Rubik"),
            ))
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Grid Section
  Widget _gridSection(List<GridItem> items) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item.icon,
                  height: 35,
                  width: 35,
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GridItem {
  final String title;
  final String icon;

  GridItem(this.title, this.icon);
}
