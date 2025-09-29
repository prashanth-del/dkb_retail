import 'package:auto_route/annotations.dart';
import 'package:db_uicomponents/components.dart';
import 'package:dkb_retail/core/utils/ui_components/auto_leading_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage(name: "SocialWebViewPageRoute")
class SocialWebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const SocialWebViewPage({super.key, required this.url, required this.title});

  @override
  State<SocialWebViewPage> createState() => _SocialWebViewPageState();
}

class _SocialWebViewPageState extends State<SocialWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // ✅ Hybrid composition handled automatically in webview_flutter >= 4.0

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // Allow all URLs to open in WebView (including YouTube)
          onNavigationRequest: (request) => NavigationDecision.navigate,
          onPageFinished: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar.secondary(
        title: "",
        autoLeadingWidget: LeadingWidget(title: widget.title),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
