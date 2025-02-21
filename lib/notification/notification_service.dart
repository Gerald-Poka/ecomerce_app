import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleDailyNotifications() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_notification_channel',
      'Daily Notifications',
      channelDescription: 'Notifications to remind users to visit the app',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule notifications for 20:00, 21:00, 22:00, and 23:00
    final times = [20, 21, 22, 23];
    for (final hour in times) {
      final time = Time(hour, 0, 0); // 20:00, 21:00, etc.
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        100 + hour, // Unique ID for each notification
        'Hey! 👋',
        'Have you checked out the best clothes on the app?',
        time,
        platformChannelSpecifics,
        payload: 'open_clothes_page', // Payload to handle notification click
      );
    }
  }
}

class Time {
  Time(int hour, int i, int j);
}

extension on FlutterLocalNotificationsPlugin {
  showDailyAtTime(int i, String s, String t, time, NotificationDetails platformChannelSpecifics, {required String payload}) {}
}