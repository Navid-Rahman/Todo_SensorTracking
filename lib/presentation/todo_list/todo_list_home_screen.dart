import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/utils/base_page.dart';

class TodoListHomeScreen extends StatelessWidget {
  const TodoListHomeScreen({super.key});

  static const String routeName = 'todo_list_home';

  @override
  Widget build(BuildContext context) {
    return const BasePage(child: Text('Todo List Home Screen'));
  }
}
