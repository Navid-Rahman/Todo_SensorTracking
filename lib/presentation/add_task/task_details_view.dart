import 'package:flutter/material.dart';
import 'package:to_do_sensor_tracking/utils/base_page.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  static const String routeName = 'task_details';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BasePage(
          showAppBar: true,
          showBackButton: true,
          appBarTitle: 'Task 1',
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      color: Color(0xffA7A7A7),
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Remind me',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffA7A7A7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: Color(0xffA7A7A7),
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Due date',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffA7A7A7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.note_outlined,
                      size: 24,
                      color: Color(0xffA7A7A7),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Priority',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffA7A7A7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 12,
          child: MaterialButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Color(0xffA7A7A7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
