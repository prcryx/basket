import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  NotificationService._();
  static late NotificationService _notificationService;
  static late FlutterLocalNotificationsPlugin notificationsPlugin;

  factory NotificationService() {
    return _notificationService;
  }

  static void init() async {
    _notificationService = NotificationService._();
    notificationsPlugin = FlutterLocalNotificationsPlugin();

    PermissionStatus status = await Permission.notification.status;
    if (status.isDenied) {
      notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    const InitializationSettings initializationSettingsAndroid =
        InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_launcher"),
    );
    notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );
  }

  static Future<void> display(String title, String payload) async {
    // To display the notification in device
    print("HI");
    try {
      print("HI 22");
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails("Channel Id", "Main Channel",
            groupKey: "notificationx",
            importance: Importance.max,
            playSound: true,
            priority: Priority.high),
      );
      await notificationsPlugin.show(
        id,
        title,
        payload,
        notificationDetails,
      );
      print("HI33");
    } catch (e) {
      debugPrint("🚫" + e.toString());
    }
  }
}
