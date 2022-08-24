
import 'dart:async';

import 'package:flutter/services.dart';

class NotificationChannel {
  static const MethodChannel _channel = MethodChannel('notification');
  static const MethodNotificationStatus = "NotificationsStatus";
  static const MethodNotificationSettings = "NotificationsSettings";


  static Future<bool?> get getNotificationStatus async {
    final bool? status = await _channel.invokeMethod(MethodNotificationStatus);
    return status;
  }

  static Future<bool?> get oppenNotificationSettings async {
    final bool? status = await _channel.invokeMethod(MethodNotificationSettings);
    return status;
  }
}
