import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/presentation/home_page.dart';
import 'package:to_do_sensor_tracking/routes.dart';

void main() {
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
