import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:to_do_sensor_tracking/presentation/add_task/widgets/task_action_row.dart';
import '/constants/app_colors.dart';

class AddTaskModal extends StatelessWidget {
  final TextEditingController taskController;
  final ValueNotifier<bool> isTextEntered;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? note;
  final ValueChanged<String> onNoteChanged;
  final ValueChanged<DateTime?> onDateChanged;
  final ValueChanged<TimeOfDay?> onTimeChanged;
  final VoidCallback onSaveTask;

  const AddTaskModal({
    super.key,
    required this.taskController,
    required this.isTextEntered,
    required this.selectedDate,
    required this.selectedTime,
    required this.note,
    required this.onNoteChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onSaveTask,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                value: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                side: const BorderSide(color: AppColors.hintColor, width: 1.5),
                onChanged: (bool? value) {
                  // Handle checkbox state change
                },
              ),
              Expanded(
                child: TextFormField(
                  controller: taskController,
                  autofocus: true,
                  style:
                      const TextStyle(color: AppColors.textColor, fontSize: 18),
                  decoration: const InputDecoration(
                    hintText: 'Add a task',
                    hintStyle: TextStyle(
                      color: AppColors.hintColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isTextEntered,
                builder: (context, isTextEntered, child) {
                  return GestureDetector(
                    onTap: isTextEntered ? onSaveTask : null,
                    child: Icon(
                      Icons.check_circle,
                      color: isTextEntered
                          ? AppColors.primaryColor
                          : AppColors.hintColor,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          TaskActionRow(
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            note: note,
            onNoteChanged: onNoteChanged,
            onDateChanged: onDateChanged,
            onTimeChanged: onTimeChanged,
          ),
          Row(
            children: [
              if (note != null) ...[
                IconButton(
                  onPressed: () => _showAddNoteDialog(context),
                  icon: const Icon(
                    Icons.note_outlined,
                    size: 22,
                    color: AppColors.primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    note!,
                    style: const TextStyle(
                        color: AppColors.primaryColor, fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    TextEditingController noteController = TextEditingController(text: note);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add Note'),
          titleTextStyle: const TextStyle(
            color: AppColors.textColor,
            fontSize: 20,
          ),
          content: TextField(
            controller: noteController,
            decoration: const InputDecoration(
              hintText: 'Enter your note here',
              hintStyle: TextStyle(color: AppColors.hintColor),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onNoteChanged(noteController.text);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
