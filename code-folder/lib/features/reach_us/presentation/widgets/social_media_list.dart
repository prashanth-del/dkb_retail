// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../core/constants/asset_path/asset_path.dart';
// import '../../../../core/router/app_router.dart';
//
// class SocialMediaList extends StatelessWidget {
//   SocialMediaList({super.key});
//
//   final List<Map<String, String>> socialMedia = [
//     {
//       "icon": AssetPath.image.facebookIcon,
//       "url": "https://www.facebook.com/share/1GgPm7FS9K/",
//       "title": "Facebook",
//     },
//     {
//       "icon": AssetPath.image.twitterIcon,
//       "url": "https://twitter.com/yourpage",
//       "title": "Twitter",
//     },
//     {
//       "icon": AssetPath.image.instagramIcon,
//       "url": "https://www.instagram.com/dukhanbank?igsh=Z3dkdm1mMDIzNGVp",
//       "title": "Instagram",
//     },
//     {
//       "icon": AssetPath.image.youtubeIcon,
//       "url": "https://youtube.com/@barwabank?si=bYBR2QiXgLMoRsSi",
//       "title": "YouTube",
//     },
//     {
//       "icon": AssetPath.image.snapIcon,
//       "url": "https://www.snapchat.com/add/yourpage",
//       "title": "Snapchat",
//     },
//     {
//       "icon": AssetPath.image.dukhanIcon,
//       "url": "https://www.dukhanbank.com/",
//       "title": "Dukhan Bank",
//     },
//   ];
//
//   void _openSocialMedia(BuildContext context, int index) {
//     final item = socialMedia[index];
//     context.router.push(
//       SocialWebViewPageRoute(url: item["url"]!, title: item["title"]!),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(socialMedia.length, (index) {
//         final item = socialMedia[index];
//         return Padding(
//           padding: EdgeInsets.only(
//             right: index == socialMedia.length - 1 ? 0 : 16,
//           ),
//           child: GestureDetector(
//             onTap: () => _openSocialMedia(context, index),
//             child: Image.asset(item["icon"]!, height: 40, width: 40),
//           ),
//         );
//       }),
//     );
//   }
// }
////////////////////////////////////////////////////////////////////////
import 'package:auto_route/auto_route.dart';
import 'package:dkb_retail/core/constants/app_strings/default_string.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/asset_path/asset_path.dart';
import '../../../../core/router/app_router.dart';

class SocialMediaList extends StatelessWidget {
  SocialMediaList({super.key});

  final List<Map<String, String>> socialMedia = [
    {
      "icon": AssetPath.image.facebookIcon,
      "url": "https://www.facebook.com/share/1GgPm7FS9K/",
      "native":
          "fb://facewebmodal/f?href=https://www.facebook.com/share/1GgPm7FS9K/",
      "title": DefaultString.instance.facebookTitle,
    },
    {
      "icon": AssetPath.image.twitterIcon,
      "url": "https://twitter.com/yourpage",
      "native": "twitter://user?screen_name=yourpage",
      "title": DefaultString.instance.twitterTittle,
    },
    {
      "icon": AssetPath.image.instagramIcon,
      "url": "https://www.instagram.com/dukhanbank?igsh=Z3dkdm1mMDIzNGVp",
      "native": "instagram://user?username=dukhanbank",
      "title": DefaultString.instance.instagramTittle,
    },
    {
      "icon": AssetPath.image.youtubeIcon,
      "url": "https://youtube.com/@barwabank?si=bYBR2QiXgLMoRsSi",
      "native": "",
      "title": DefaultString.instance.youtubeTittle,
    },
    {
      "icon": AssetPath.image.snapIcon,
      "url": "https://www.snapchat.com/add/yourpage",
      "native": "snapchat://add/yourpage",
      "title": DefaultString.instance.snapChatTittle,
    },
    {
      "icon": AssetPath.image.dukhanIcon,
      "url": "https://www.dukhanbank.com/",
      "native": "", // No native scheme
      "title": DefaultString.instance.dukhanBankTittle,
    },
  ]; // todo this

  Future<void> _openSocialMedia(BuildContext context, int index) async {
    final item = socialMedia[index];
    final url = item["url"]!;
    final title = item["title"]!;
    final nativeUrl = item["native"];

    try {
      if (nativeUrl != null && nativeUrl.isNotEmpty) {
        final Uri nativeUri = Uri.parse(nativeUrl);
        if (await canLaunchUrl(nativeUri)) {
          await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
          return;
        }
        final Uri webUri = Uri.parse(url);
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri);
        } else {
          // fallback to in-app WebView
          context.router.push(SocialWebViewPageRoute(url: url, title: title));
        }
      } else {
        context.router.push(SocialWebViewPageRoute(url: url, title: title));
      }
      //  if (nativeUrl != null && nativeUrl.isNotEmpty) {
      //         final Uri nativeUri = Uri.parse(nativeUrl);
      //         if (await canLaunchUrl(nativeUri)) {
      //           await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
      //           return;
      //         }
      //       }

      // fallback to web if native fails or not available
      // 2️⃣ Always fallback to in-app WebView (keeps AppBar)
    } catch (e) {
      // 3️⃣ Fallback to WebView on error
      context.router.push(SocialWebViewPageRoute(url: url, title: title));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(socialMedia.length, (index) {
        final item = socialMedia[index];
        return Padding(
          padding: EdgeInsets.only(
            right: index == socialMedia.length - 1 ? 0 : 16,
          ),
          child: GestureDetector(
            onTap: () => _openSocialMedia(context, index),
            child: Image.asset(item["icon"]!, height: 40, width: 40),
          ),
        );
      }),
    );
  }
}
