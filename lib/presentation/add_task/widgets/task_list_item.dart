import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/assets.dart';
import '/constants/app_colors.dart';

class TaskListItem extends StatelessWidget {
  final String title;
  final DateTime? dueDate;
  final TimeOfDay? dueTime;

  final bool isCompleted;
  final bool isStarred;
  final ValueChanged<bool> onCompletedChanged;
  final ValueChanged<bool> onStarredChanged;

  final VoidCallback onTap;

  const TaskListItem({
    super.key,
    required this.title,
    this.dueDate,
    this.dueTime,
    required this.isCompleted,
    required this.isStarred,
    required this.onCompletedChanged,
    required this.onStarredChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
                      color: isCompleted
                          ? AppColors.hintColor
                          : AppColors.textColor,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (dueDate != null || dueTime != null)
                    Row(
                      children: [
                        if (dueDate != null) ...[
                          SvgPicture.asset(
                            Assets.calendarIcon,
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              const Color(0xffB9B9BE),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
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
                          SvgPicture.asset(
                            Assets.reminderIcon,
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              const Color(0xffB9B9BE),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
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
                icon: SvgPicture.asset(
                  Assets.starIcon,
                  colorFilter: ColorFilter.mode(
                    isStarred
                        ? AppColors.starredColor
                        : const Color(0xffA7A7A7),
                    BlendMode.srcIn,
                  ),
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  onStarredChanged(!isStarred);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
