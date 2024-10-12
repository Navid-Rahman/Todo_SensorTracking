import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:to_do_sensor_tracking/constants/assets.dart';

import '/constants/app_colors.dart';
import '/data/task_data_store.dart';
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
    final TaskDataStore taskDataStore = TaskDataStore();

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
                  icon: Assets.reminderIcon,
                  color: getDueDateColor(taskDueDate, taskDueTime),
                  text: taskDueTime != null
                      ? taskDueTime.format(context)
                      : 'Remind Me',
                ),
                const SizedBox(height: 20),
                buildTaskDetailRow(
                  icon: Assets.calendarIcon,
                  color: getDueDateColor(taskDueDate, taskDueTime),
                  text: taskDueDate != null
                      ? 'Due ${DateFormat('EEE, dd MMM').format(taskDueDate)}'
                      : 'Due Date',
                ),
                const SizedBox(height: 20),
                buildTaskDetailRow(
                  icon: Assets.noteIcon,
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
            onPressed: () {
              /// Show delete confirmation dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Delete Task',
                        style: TextStyle(color: AppColors.textColor)),
                    content: const Text(
                        'Are you sure you want to delete this task?',
                        style: TextStyle(color: AppColors.textColor)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel',
                            style: TextStyle(
                              color: AppColors.textColor,
                            )),
                      ),
                      TextButton(
                        onPressed: () async {
                          await taskDataStore.deleteTask(id: taskId);
                          Navigator.pop(context);
                          Navigator.pop(context);

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Task Deleted',
                                    style:
                                        TextStyle(color: AppColors.textColor)),
                                content: const Text(
                                    'The task has been successfully deleted.',
                                    style:
                                        TextStyle(color: AppColors.textColor)),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Delete',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                // Icon(
                //   Icons.delete_outline,
                //   color: Colors.red,
                // ),
                SvgPicture.asset(
                  Assets.deleteIcon,
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcIn,
                  ),
                  width: 22,
                  height: 22,
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
    required String icon,
    required Color color,
    required String text,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            height: 22,
            width: 22,
          ),
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
