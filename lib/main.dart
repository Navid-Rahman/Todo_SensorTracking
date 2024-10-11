import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_sensor_tracking/data/task_data_store.dart';
import 'package:to_do_sensor_tracking/data/task_list_data_store.dart';
import 'package:to_do_sensor_tracking/models/time_of_day_adaptar.dart';

import 'package:to_do_sensor_tracking/presentation/home_page.dart';
import 'package:to_do_sensor_tracking/routes.dart';
import 'package:to_do_sensor_tracking/utils/local_notification_service.dart';

import 'models/task.dart';
import 'models/task_list.dart';

final LocalNotification localNotification = LocalNotification();

Future<void> main() async {
  // Ensure that the WidgetsBinding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive data before running the app
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(TimeOfDayAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskListAdapter());

  // Open Hive boxes
  await Hive.openBox<TaskList>(TaskListDataStore.boxName);
  await Hive.openBox<Task>(TaskDataStore.boxName);

  // Initialize local notifications
  await localNotification.setupFlutterNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _requestPermissions();

    return MaterialApp(
      title: 'Todo & Sensor Tracking App',
      initialRoute: HomePage.routeName,
      routes: routes,
    );
  }

  Future<void> _requestPermissions() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      debugPrint(
          'Notifications permission granted: $grantedNotificationPermission');
    }
  }
}
