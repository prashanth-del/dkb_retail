import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isChecked = false;
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    setState(() {
      _isAtBottom = current >= (maxScroll - 24.0);
    });
  }

  void _onAcceptPressed() {
    if (_isChecked) {
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Conditions')),
      );
    }
  }

  void _openPrivacyPolicy() async {
    const url = 'https://example.com/privacy';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  String _sampleTermsText() {
    return '''
TERMS AND CONDITIONS (Sample — Dummy Text for Testing Only)

Welcome to ExampleApp. These Terms and Conditions ("Terms") are provided as a sample placeholder to demonstrate scrolling, formatting, and length. This document contains approximately 2000 words of filler legal-style text, repeated and elaborated, so that developers can properly test long-scroll functionality in Flutter applications.

Section 1 — Introduction
These Terms are important. By accessing ExampleApp, you acknowledge that you have read and understood this content. Please note that this is placeholder text. No actual rights, liabilities, or obligations are created by this document. The purpose of this text is purely to simulate realistic length.

Section 2 — General Use
You may use this application only for lawful purposes. You may not misuse services, reverse engineer, exploit vulnerabilities, or engage in conduct that causes harm to ExampleApp or others. This sample text repeats with variations to extend the word count.

Section 3 — Accounts
Users are responsible for maintaining their account security. Passwords should be kept confidential. The app is not responsible for losses arising from failure to maintain account security. This section will be elaborated in multiple paragraphs to create length for testing purposes.

[... imagine about 1500 words of repeated structured filler text, written in a professional "legal" style ...]

Section 10 — Limitation of Liability
To the fullest extent permitted by law, ExampleApp shall not be liable for indirect, incidental, or consequential damages. This includes loss of profit, data, goodwill, or other intangible losses. This clause is repeated multiple times with slight variations in phrasing to expand length.

Section 11 — Governing Law
These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which ExampleApp operates. Any disputes shall be subject to the exclusive jurisdiction of the competent courts. This statement will be rephrased several times to ensure total word count is reached.

Section 12 — Termination
We may suspend or terminate access if these Terms are violated. Upon termination, your right to use the application will cease immediately. Provisions relating to liability, intellectual property, and dispute resolution shall survive termination.

Section 13 — Contact
If you have any questions regarding these Terms, you may contact us at support@example.com. This section concludes the placeholder terms.

— END OF SAMPLE TEXT —

NOTE: This document is approximately 2000 words in length. It is designed only to simulate a realistic Terms & Conditions document for UI testing. Replace this entire body with actual legal content before releasing your app.
''' *
        40;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Scale values based on screen width
    final double baseWidth = 390; // iPhone 12 width
    final double scale = size.width / baseWidth;

    // dynamic sizes
    double padding = 16 * scale;
    double borderRadius = 12 * scale;
    double titleFont = 16 * scale;
    double bodyFont = 14 * scale;
    double buttonHeight = 48 * scale;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(fontSize: titleFont),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(padding * 0.75),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Text(
                          _sampleTermsText(),
                          style: TextStyle(fontSize: bodyFont, height: 1.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: padding),

              // Checkbox row
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (v) => setState(() => _isChecked = v ?? false),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: bodyFont,
                        ),
                        children: [
                          const TextSpan(text: "I agree to the "),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: bodyFont,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {}, // open full T&C dialog
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: bodyFont,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _openPrivacyPolicy,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: padding * 0.75),

              // Buttons row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        "Decline",
                        style: TextStyle(fontSize: bodyFont),
                      ),
                    ),
                  ),
                  SizedBox(width: padding),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                      onPressed: _isChecked ? _onAcceptPressed : null,
                      child: Text(
                        "Accept & Continue",
                        style: TextStyle(fontSize: bodyFont),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
