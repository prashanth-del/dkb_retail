import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/router/app_router.dart';
import '../../../../extensions/display_image_base64.dart';
import '../../domain/entities/bank_info_follow_u.dart';
import '../controller/reach_us_providers.dart';

class SocialMediaList extends ConsumerStatefulWidget {
  const SocialMediaList({super.key});
  @override
  ConsumerState<SocialMediaList> createState() => _SocialMediaListState();
}

class _SocialMediaListState extends ConsumerState<SocialMediaList> {
  /// Map from social name to static asset

  String? _getNativeUrl(String name, String? webUrl) {
    if (webUrl == null || webUrl.isEmpty) return null;
    final lower = name.toLowerCase();

    try {
      final uri = Uri.parse(webUrl);
      final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
      final username = segments.isNotEmpty ? segments.last : '';

      if (lower.contains('facebook')) {
        print(
          "faccccccccccccccccccccccccccbook",
        ); //"fb://facewebmodal/f?href=https://www.facebook.com/share/1GgPm7FS9K/",
        print(webUrl);

        // Facebook can use fb://page/<id> or fb://facewebmodal/f?href=<url>
        return "fb://facewebmodal/f?href=$webUrl";
      } else if (lower.contains('twitter') || lower.contains('x')) {
        return username.isNotEmpty
            ? 'twitter://user?screen_name=$username'
            : webUrl;
      } else if (lower.contains('instagram')) {
        print("innnnnnnnnnnnnnnnnnnnsta");
        print(username);
        return username.isNotEmpty
            ? 'instagram://user?username=$username' //"https://www.instagram.com/dukhanbank/",instagram://user?username=dukhanbank
            : webUrl;
      } else if (lower.contains('snap')) {
        return username.isNotEmpty ? 'snapchat://add/$username' : webUrl;
      } else if (lower.contains('linkedin')) {
        return 'linkedin://company/$username';
      }
    } catch (e) {
      debugPrint('Error parsing native URL: $e');
    }

    return null;
  }

  /// Get correct English URL from the API

  /// Open social media (native → in-app WebView)
  Future<void> _openSocialMedia(
    BuildContext context,
    BankInfoFollowU item,
  ) async {
    final webUrl = item.url;
    final title = item.name;
    final nativeUrl = _getNativeUrl(title, webUrl);

    if (webUrl == null || webUrl.isEmpty) return;

    try {
      if (nativeUrl != null && nativeUrl.isNotEmpty) {
        final Uri nativeUri = Uri.parse(nativeUrl);
        if (await canLaunchUrl(nativeUri)) {
          await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
          return;
        }
        final Uri webUri = Uri.parse(webUrl);
        if (await canLaunchUrl(webUri)) {
          await launchUrl(webUri);
        } else {
          // fallback to in-app WebView
          context.router.push(
            SocialWebViewPageRoute(url: webUrl, title: title),
          );
        }
      } else {
        context.router.push(SocialWebViewPageRoute(url: webUrl, title: title));
      }
    } catch (e) {
      // 3️⃣ Fallback to WebView on error
      context.router.push(SocialWebViewPageRoute(url: webUrl, title: title));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bankDetails = ref.read(reachUsNotifierProvider).bankDetails;
    final followUsList = List<BankInfoFollowU>.from(bankDetails!.followUs!)
      ..sort((a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));

    print("foollllllllllllllllllllllllowList");
    print(followUsList);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...followUsList.map((item) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () => _openSocialMedia(context, item),
                child: DisplayBase64Image(
                  key: ValueKey(item.name),
                  base64String: item.displayImage!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                //Image.asset(iconAsset, height: 40, width: 40),
              ),
            );
          }).toList(),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16),
          //   child: GestureDetector(
          //     onTap: () async {
          //       String dukhanUrl = bankDetails.data.urlEn!;
          //       final uri = Uri.parse(dukhanUrl);
          //       if (await canLaunchUrl(uri)) {
          //         context.router.push(
          //           SocialWebViewPageRoute(
          //             url: dukhanUrl,
          //             title: bankDetails.data.nameEn!,
          //           ),
          //         );
          //       } else {
          //         context.router.push(
          //           SocialWebViewPageRoute(
          //             url: dukhanUrl,
          //             title: bankDetails.data.nameEn!,
          //           ),
          //         );
          //       }
          //     },
          //     child: Image.asset(
          //       AssetPath.image.dukhanIcon,
          //       height: 40,
          //       width: 40,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
