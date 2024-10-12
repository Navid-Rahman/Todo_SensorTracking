import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  late AndroidNotificationChannel channel;
  bool isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NotificationDetails notificationDetails;

  AndroidNotificationDetails get androidNotificationDetails {
    return AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      icon: 'app_icon',
    );
  }

  AndroidNotificationChannel get androidNotificationChannel {
    return const AndroidNotificationChannel(
      'todo_sensor_tracking',
      'Todo & Sensor Tracking Notifications',
      description:
          'Notifications for tasks and sensor tracking in the Todo & Sensor Tracking app',
      importance: Importance.high,
      playSound: true,
    );
  }

  InitializationSettings get initializationSettings {
    return const InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    channel = androidNotificationChannel;

    notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(),
    );

    if (defaultTargetPlatform == TargetPlatform.android) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    isFlutterLocalNotificationsInitialized = true;
  }

  void showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    if (kIsWeb) {
      return;
    }

    if (!isFlutterLocalNotificationsInitialized) {
      await setupFlutterNotifications();
    }

    try {
      flutterLocalNotificationsPlugin.show(
          id, title, body, notificationDetails);
    } catch (e) {
      if (kDebugMode) {
        print('Error showing notification: $e');
      }
    }
  }

  void scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (kIsWeb) {
      return;
    }

    if (!isFlutterLocalNotificationsInitialized) {
      await setupFlutterNotifications();
    }

    final tz.TZDateTime scheduledNotificationDate =
        tz.TZDateTime.from(scheduledDate, tz.local);

    if (scheduledNotificationDate.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledNotificationDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
