import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
      'thesmartstream_local_channel', // id
      'The Smart Stream User Notifications', // title
      description:
          'This channel is used for The Smart Stream local notifications.',
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
      iOS: DarwinNotificationDetails(),
    );

    if (defaultTargetPlatform == TargetPlatform.android) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    isFlutterLocalNotificationsInitialized = true;
  }

  void showNotification(
      {required int id, required String title, required String body}) async {
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
      print('Error showing notification: $e');
    }
  }
}
