import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/presentation/add_list_title.dart';
import 'package:to_do_sensor_tracking/presentation/add_task/task_details_view.dart';
import 'presentation/add_task/add_task_screen.dart';
import 'presentation/home_page.dart';
import 'presentation/todo_list/todo_list_home_screen.dart';
import 'presentation/todo_list/todo_splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.routeName: (context) => const HomePage(),
  TodoSplashScreen.routeName: (context) => const TodoSplashScreen(),
  TodoListHomeScreen.routeName: (context) => const TodoListHomeScreen(),
  AddTaskScreen.routeName: (context) => const AddTaskScreen(),
  AddListTitle.routeName: (context) => const AddListTitle(),
  TaskDetailsView.routeName: (context) => const TaskDetailsView(),
};
