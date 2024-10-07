import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/presentation/home_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.routeName: (context) => const HomePage(),
};
