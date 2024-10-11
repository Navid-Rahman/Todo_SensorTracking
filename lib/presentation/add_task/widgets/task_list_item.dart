import 'package:flutter/material.dart';
import '/constants/app_colors.dart';

class TaskListItem extends StatelessWidget {
  final String title;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;

  final bool isCompleted;
  final bool isStarred;
  final ValueChanged<bool> onCompletedChanged;
  final ValueChanged<bool> onStarredChanged;

  const TaskListItem({
    super.key,
    required this.title,
    this.dueDate,
    this.dueTime,
    required this.isCompleted,
    required this.isStarred,
    required this.onCompletedChanged,
    required this.onStarredChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isCompleted,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              side: const BorderSide(color: AppColors.hintColor, width: 1.5),
              checkColor: Colors.white,
              activeColor: AppColors.hintColor,
              onChanged: (bool? value) {
                onCompletedChanged(value ?? false);
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color:
                        isCompleted ? AppColors.hintColor : AppColors.textColor,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                if (dueDate != null || dueTime != null)
                  Row(
                    children: [
                      if (dueDate != null) ...[
                        const Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xffB9B9BE),
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}',
                          style: const TextStyle(
                            color: Color(0xffB9B9BE),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (dueTime != null) ...[
                        const Icon(
                          Icons.notifications,
                          color: Color(0xffB9B9BE),
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          dueTime != null
                              ? '${dueTime!.hour}:${dueTime!.minute}'
                              : 'No time set',
                          style: const TextStyle(
                            color: Color(0xffB9B9BE),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                isStarred ? Icons.star : Icons.star_border_outlined,
                color: isStarred ? AppColors.starredColor : AppColors.hintColor,
              ),
              onPressed: () {
                onStarredChanged(!isStarred);
              },
            ),
          ],
        ),
      ),
    );
  }
}
