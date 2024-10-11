import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/utils/base_page.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  static const String routeName = 'task_details';

  @override
  Widget build(BuildContext context) {
    final taskDetails =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final String taskId = taskDetails['taskId'];
    final String taskTitle = taskDetails['taskTitle'] ?? 'No Title';
    final String? taskNote = taskDetails['taskNote'];
    final DateTime? taskDueDate = taskDetails['taskDueDate'];
    final TimeOfDay? taskDueTime = taskDetails['taskDueTime'];
    final bool isCompleted = taskDetails['isCompleted'] ?? false;
    final bool isStarred = taskDetails['isStarred'] ?? false;

    print('Task Date: $taskDueDate');

    return Stack(
      children: [
        BasePage(
          showAppBar: true,
          showBackButton: true,
          appBarTitle: taskTitle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: Column(
              children: [
                buildTaskDetailRow(
                  icon: Icons.notifications_none_rounded,
                  color: getDueDateColor(taskDueDate, taskDueTime),
                  text: taskDueTime != null
                      ? taskDueTime.format(context)
                      : 'Remind Me',
                ),
                const SizedBox(height: 20),
                buildTaskDetailRow(
                  icon: Icons.calendar_today_rounded,
                  color: getDueDateColor(taskDueDate, taskDueTime),
                  text: taskDueDate != null
                      ? 'Due ${DateFormat('EEE, dd MMM').format(taskDueDate)}'
                      : 'Due Date',
                ),
                const SizedBox(height: 20),
                buildTaskDetailRow(
                  icon: Icons.note_outlined,
                  color: taskNote != null
                      ? const Color(0xff33CCCC)
                      : const Color(0xffA7A7A7),
                  text: taskNote ?? 'Add Note',
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

  Widget buildTaskDetailRow({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }

  Color getDueDateColor(DateTime? dueDate, TimeOfDay? dueTime) {
    return dueDate != null || dueTime != null
        ? const Color(0xff33CCCC)
        : const Color(0xffA7A7A7);
  }
}
