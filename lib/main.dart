import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'data/task_data_store.dart';
import 'data/task_list_data_store.dart';
import 'models/task.dart';
import 'models/task_list.dart';
import 'models/time_of_day_adaptar.dart';
import 'presentation/home_page.dart';
import 'routes.dart';
import 'utils/local_notification_service.dart';

final LocalNotification localNotification = LocalNotification();

Future<void> main() async {
  // Ensure that the WidgetsBinding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone data
  tz.initializeTimeZones();

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

    if (Platform.isAndroid) {
      var status = await Permission.scheduleExactAlarm.status;
      if (!status.isGranted) {
        await Permission.scheduleExactAlarm.request();
      }

      var postNotificationStatus = await Permission.notification.status;

      if (!postNotificationStatus.isGranted) {
        await Permission.notification.request();
      }
    } else if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    if (Platform.isIOS) {
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    } else if (Platform.isAndroid) {
      var status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  }
}
