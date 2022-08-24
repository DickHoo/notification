import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:notification/notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool notificationStatus = false;

  @override
  void initState() {
    super.initState();
    initNotificationState();
  }

  initNotificationState() async {
    try {
      var data = await NotificationChannel.getNotificationStatus ?? false;
      notificationStatus = data;
    } on PlatformException {}

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  initNotificationState();
                },
                child: const Text("刷新状态"),
              ),
              TextButton(
                onPressed: () {
                  NotificationChannel.oppenNotificationSettings;
                },
                child: const Text("打开通知"),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Text("通知开关状态: ${notificationStatus ? '开' : '关'}"),
          ],
        ),
      ),
    );
  }
}
