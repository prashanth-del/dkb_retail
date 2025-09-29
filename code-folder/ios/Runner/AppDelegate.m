#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  FlutterMethodChannel* channel =
      [FlutterMethodChannel methodChannelWithName:@"app_config"
                                  binaryMessenger:controller.binaryMessenger];

  [channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    if ([@"getConfig" isEqualToString:call.method]) {
      NSString* base = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"API_BASE_URL"] ?: @"";
      NSString* flv  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"FLAVOR_NAME"] ?: @"dev";
      result(@{ @"flavor": flv, @"apiBaseUrl": base, @"flavorName": flv });
    } else {
      result(FlutterMethodNotImplemented);
    }
  }];

  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
