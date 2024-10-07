import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/utils/base_page.dart';

class TodoListHomeScreen extends StatelessWidget {
  const TodoListHomeScreen({super.key});

  static const String routeName = 'todo_list_home';

  @override
  Widget build(BuildContext context) {
    return BasePage(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff33CCCC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: null,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: const Text('Todo List Home Screen'),
    );
  }
}
