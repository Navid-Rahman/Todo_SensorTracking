import 'package:flutter/material.dart';
import '/constants/app_colors.dart';

class TaskListItem extends StatelessWidget {
  final bool isCompleted;
  final bool isStarred;
  final ValueChanged<bool> onCompletedChanged;
  final ValueChanged<bool> onStarredChanged;

  const TaskListItem({
    super.key,
    required this.isCompleted,
    required this.isStarred,
    required this.onCompletedChanged,
    required this.onStarredChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Task 1',
                style: TextStyle(
                  color:
                      isCompleted ? AppColors.hintColor : AppColors.textColor,
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: Color(0xffB9B9BE),
                    size: 16,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Mon, 12 Jul',
                    style: TextStyle(
                      color: Color(0xffB9B9BE),
                      fontSize: 12,
                    ),
                  ),
                ],
              )
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
    );
  }
}
