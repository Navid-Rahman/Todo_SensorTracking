import 'package:flutter/material.dart';

import '/utils/base_page.dart';
import 'sensor/sensor_tracker.dart';
import 'todo_list/todo_splash_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildButton(
              'To-Do List',
              const Color(0xff36E0E0),
              Colors.black,
              () {
                Navigator.pushNamed(context, TodoSplashScreen.routeName);
              },
            ),
            const SizedBox(height: 20),
            buildButton(
              'Sensor Tracking',
              const Color(0xff3F69FF),
              Colors.white,
              () {
                Navigator.pushNamed(context, SensorTracker.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, Color backgroundColor, Color textColor,
      VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 60),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: textColor),
      ),
    );
  }
}
