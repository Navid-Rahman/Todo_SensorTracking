import 'package:flutter/material.dart';
import 'todo_list_home_screen.dart';
import '/utils/base_page.dart';

import '/constants/assets.dart';

class TodoSplashScreen extends StatefulWidget {
  const TodoSplashScreen({super.key});

  static const String routeName = 'todo_splash';

  @override
  State<TodoSplashScreen> createState() => _TodoSplashScreenState();
}

class _TodoSplashScreenState extends State<TodoSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, TodoListHomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.logo),
            const SizedBox(height: 10),
            Image.asset(Assets.titleLogo),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Color(0xff33CCCC),
            ),
          ],
        ),
      ),
    );
  }
}
