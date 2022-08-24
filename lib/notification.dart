
import 'dart:async';

import 'package:flutter/services.dart';

class NotificationChannel {
  static String TAG = "NotificationChannel";
  static const MethodChannel _channel = MethodChannel('notification');
  static const MethodNotificationStatus = "NotificationsStatus";
  static const MethodNotificationSettings = "NotificationsSettings";

  static Future<bool?> get getNotificationStatus async {
     var status = await _channel.invokeMethod(MethodNotificationStatus);
     if(status is String){
       status = (status == "1")?true:false;
     }
    print("$TAG :status:$status");
    return status;
  }

  static get openNotificationSettings async {
     _channel.invokeMethod(MethodNotificationSettings);
  }
}
