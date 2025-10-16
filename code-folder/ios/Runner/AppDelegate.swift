import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    var secureField: UITextField?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Google Maps API key
        GMSServices.provideAPIKey("AIzaSyB0JlG-YETPLfs6nvqQNkSgFy6XtknasPY")

        // Setup MethodChannel for flavors
        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(
                name: "app_config",
                binaryMessenger: controller.binaryMessenger
            )

            channel.setMethodCallHandler { call, result in
                if call.method == "getConfig" {
                    // Values pulled from Info.plist per flavor
                    let base = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
                    let flv  = Bundle.main.object(forInfoDictionaryKey: "FLAVOR_NAME") as? String ?? "dev"

                    result([
                        "flavor": flv,
                        "apiBaseUrl": base,
                        "flavorName": flv
                    ])
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }

        // Detect screen recording
        NotificationCenter.default.addObserver(
            forName: UIScreen.capturedDidChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            //self.handleScreenCapture()
        }

        // Detect screenshots
        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: .main
        ) { _ in
            //self.showBlurOverlayTemporarily()
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: - Screen recording handling
    private func handleScreenCapture() {
        guard let appWindow = window else { return }

        if UIScreen.main.isCaptured {
            // Recording started → add secure field
            if secureField == nil {
                let field = UITextField(frame: appWindow.bounds)
                field.isSecureTextEntry = true   // this forces black output in recordings
                field.backgroundColor = .black   // black overlay (for recorder only)
                field.isUserInteractionEnabled = false
                field.tag = 12345
                appWindow.addSubview(field)
                secureField = field
            }
        } else {
            // Recording stopped → remove secure field
            appWindow.viewWithTag(12345)?.removeFromSuperview()
            secureField = nil
        }
    }

    // MARK: - Screenshot handling
    private func handleScreenshot() {
            guard let appWindow = window else { return }

            // Temporarily overlay secure field so screenshot comes black
            let field = UITextField(frame: appWindow.bounds)
            field.isSecureTextEntry = true
            field.backgroundColor = .black
            field.isUserInteractionEnabled = false
            field.tag = 54321
            appWindow.addSubview(field)

            // Remove overlay right after screenshot is taken
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                appWindow.viewWithTag(54321)?.removeFromSuperview()
            }
        }
}
