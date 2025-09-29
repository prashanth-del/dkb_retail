import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  // Method to launch the default email app
  static Future<void> sendEmail({
    required String toEmail, // recipient's email
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
    );

    if (!await launchUrl(emailUri)) {
      throw 'Could not launch $emailUri';
    }
  }
}
