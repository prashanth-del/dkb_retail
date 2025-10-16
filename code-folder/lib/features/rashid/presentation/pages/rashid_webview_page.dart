import 'package:auto_route/auto_route.dart';
import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/i18n/controller/i18n_notifiers.dart';
import 'package:dkb_retail/features/rashid/presentation/controller/rashid_providers.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RashidWebviewPage extends ConsumerStatefulWidget {
  const RashidWebviewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RashidWebviewPageState();
}

class _RashidWebviewPageState extends ConsumerState<RashidWebviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late InAppWebViewController _controller;
  final bool _isLoading = true;
  final bool _chatInitialized = false;

  final String rashidENUrl =
      "https://www.dukhanbank.com/personal/digital-banking/rashid";

  final String rashidArUrl =
      "https://www.dukhanbank.com/ar/personal/digital-banking/rashid";

  String rashidUrl = '';

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(rashidloadingProvider);

    final isRtl = ref.watch(localePodProvider).languageCode == 'ar';
    rashidUrl = isRtl ? rashidArUrl : rashidENUrl;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: UiTextNew.b1Semibold("Rashid", color: DefaultColors.blue9D),
        actions: [
          IconButton(
            onPressed: () {
              context.router.maybePop();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(rashidUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              supportMultipleWindows: true,
              useShouldOverrideUrlLoading: true,
              mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
              javaScriptCanOpenWindowsAutomatically: true,
              useOnLoadResource: true,
              clearCache: false,
              allowsInlineMediaPlayback: true,
            ),
            // initialUserScripts: UnmodifiableListView<UserScript>([
            //   UserScript(
            //     source: """
            //   try {
            //     // Patch document.currentScript.nonce to always return a safe value
            //     Object.defineProperty(Document.prototype, 'currentScript', {
            //       get: function() {
            //         return { nonce: "flutter-fake-nonce" };
            //       }
            //     });
            //     console.log("✅ Patched document.currentScript.nonce");
            //   } catch(e) {
            //     console.log("❌ Failed to patch nonce: " + e);
            //   }
            // """,
            //     injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
            //   ),
            // ]),
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onLoadStart: (controller, url) {
              ref.read(rashidloadingProvider.notifier).state = true;
            },
            onLoadStop: (controller, url) async {
              ref.read(rashidloadingProvider.notifier).state = false;

              // await Future.delayed(const Duration(seconds: 2));
              // try {
              //   await _controller.evaluateJavascript(
              //     source: """
              //     if (typeof WeaverWebChatInit === 'function') {
              //       console.log('Chatbot init not ready, retrying...');
              //                 WeaverWebChatInit({
              //                                 id: "1",
              //                                 serviceUrl: "https://chatbot.dukhanbank.com/jurikd652hjspwmvn56/webchatprod/index.js",  // Replace with real one
              //                                 initContexts: "",
              //                                 elementId: "WebChatDiv1",
              //                                 useVoice: false,
              //                                 useFile: false,
              //                                 skipIntro: false,
              //                                 hideMenu: false,
              //                                 hideMinimize: false,
              //                                 languages: [
              //                                   { name: "Sr", value: "sr-Latn-Cs", default: true },
              //                                   { name: "En", value: "en-US", default: false }
              //                                 ],
              //                                 onMessage: null,
              //                                 onMinimize: null,
              //                                 useLocalMap: true,
              //                                 readMoreLimit: 300,
              //                                 translateResources: [
              //                                   {
              //                                     language: "en-US",
              //                                     resources: {
              //                                       webchatTitle: "Webchat",
              //                                       welcomeMessage: "Welcome to Webchat!",
              //                                       typingText: "Typing...",
              //                                       allowedFileSize: "File is too large!"
              //                                     }
              //                                   }
              //                                 ]
              //                               });
              //     } else {
              //       // If function is not defined, fallback to external browser
              //       console.log('Chatbot not ready');
              //       window.flutter_inappwebview.callHandler('openExternal');
              //     }
              //   """,
              //   );
              // } catch (_) {
              //   // Fallback
              // }
              // await Future.delayed(const Duration(seconds: 2));
              // try {
              //   await controller.evaluateJavascript(
              //     source: """
              //   const chatButton = document.getElementById('chatTogglesm2025');
              //   if(chatButton) {
              //     chatButton.click();
              //   }
              // """,
              //   );
              // } catch (e) {
              //   debugPrint("Failed to auto-click chat button: $e");
              // }
            },
            onConsoleMessage: (controller, consoleMessage) {
              debugPrint("Console: xxxxx ${consoleMessage.message}");
            },
            onCreateWindow: (controller, createWindowRequest) async {
              controller.loadUrl(
                urlRequest: URLRequest(url: createWindowRequest.request.url),
              );
              return true;
            },
            onReceivedError: (controller, request, error) {
              UiToast().showToast(error.description);
              ref.read(rashidloadingProvider.notifier).state = false;
            },
            onReceivedHttpError: (controller, request, errorResponse) {
              UiToast().showToast(errorResponse.reasonPhrase);
              ref.read(rashidloadingProvider.notifier).state = false;
            },
            onLoadResource: (controller, resource) {},
            onJsAlert: (controller, jsAlertRequest) async {
              return JsAlertResponse(
                handledByClient: true,
                action: JsAlertResponseAction.CONFIRM,
              );
            },
            onJsConfirm: (controller, jsConfirmRequest) async {
              return JsConfirmResponse(
                handledByClient: true,
                action: JsConfirmResponseAction.CONFIRM,
              );
            },
            onJsPrompt: (controller, jsPromptRequest) async {
              return JsPromptResponse(
                handledByClient: true,
                action: JsPromptResponseAction.CONFIRM,
              );
            },
          ),

          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
