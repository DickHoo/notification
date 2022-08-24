#import "NotificationPlugin.h"
#import <UserNotifications/UserNotifications.h>

static NSString *MethodNotificationStatus = @"NotificationsStatus";
static NSString *MethodNotificationSettings = @"NotificationsSettings";

@interface NotificationPlugin ()

@end

@implementation NotificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"notification"
            binaryMessenger:[registrar messenger]];
  NotificationPlugin* instance = [[NotificationPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([MethodNotificationStatus isEqualToString:call.method]) {
      NSLog(@"MethodNotificationStatus");
      [self checkNotificationStatus:result];
  } else if ([MethodNotificationSettings isEqualToString:call.method]) {
      [self jumpAppSettings];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)checkNotificationStatus:(FlutterResult)result {
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied || settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                result(@"0");
            } else {
                result(@"1");
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)jumpAppSettings {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    } else {
        NSLog(@"无法打开");
    }
}

@end
