import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_sensor_tracking/data/task_data_store.dart';
import 'package:to_do_sensor_tracking/data/task_list_data_store.dart';
import 'package:to_do_sensor_tracking/models/time_of_day_adaptar.dart';

import 'package:to_do_sensor_tracking/presentation/home_page.dart';
import 'package:to_do_sensor_tracking/routes.dart';

import 'models/task.dart';
import 'models/task_list.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo & Sensor Tracking App',
      initialRoute: HomePage.routeName,
      routes: routes,
    );
  }
}
