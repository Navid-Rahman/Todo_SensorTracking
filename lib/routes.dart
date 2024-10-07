import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/presentation/home_page.dart';
import 'package:to_do_sensor_tracking/presentation/todo_list/todo_list_home_screen.dart';
import 'package:to_do_sensor_tracking/presentation/todo_list/todo_splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.routeName: (context) => const HomePage(),
  TodoSplashScreen.routeName: (context) => const TodoSplashScreen(),
  TodoListHomeScreen.routeName: (context) => const TodoListHomeScreen(),
};
