import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
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

    // End
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
