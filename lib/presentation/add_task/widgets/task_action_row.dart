import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';

import '/constants/assets.dart';
import '/constants/app_colors.dart';
import 'calendar_modal_content.dart';

class TaskActionRow extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? note;
  final ValueChanged<String> onNoteChanged;
  final ValueChanged<DateTime?> onDateChanged;
  final ValueChanged<TimeOfDay?> onTimeChanged;

  const TaskActionRow({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.note,
    required this.onNoteChanged,
    required this.onDateChanged,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              barrierColor: Colors.black.withOpacity(0.5),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    dialogBackgroundColor: Colors.white,
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primaryColor,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedTime != null) {
              onTimeChanged(pickedTime);
            }
          },
          icon: SvgPicture.asset(
            Assets.reminderIcon,
            colorFilter: selectedTime == null
                ? const ColorFilter.mode(Color(0xffA7A7A7), BlendMode.srcIn)
                : ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            height: 22,
            width: 22,
          ),
        ),
        if (selectedTime != null)
          Text(
            selectedTime!.format(context),
            style: const TextStyle(color: AppColors.primaryColor, fontSize: 16),
          ),
        if (note == null)
          IconButton(
            onPressed: () => _showAddNoteDialog(context),
            icon: SvgPicture.asset(
              Assets.noteIcon,
              colorFilter: const ColorFilter.mode(
                Color(0xffA7A7A7),
                BlendMode.srcIn,
              ),
              height: 22,
              width: 22,
            ),
          ),
        IconButton(
          icon: SvgPicture.asset(
            Assets.calendarIcon,
            colorFilter: selectedDate == null
                ? const ColorFilter.mode(Color(0xffA7A7A7), BlendMode.srcIn)
                : ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            height: 22,
            width: 22,
          ),
          onPressed: () => _showCalendarModal(context),
        ),
        if (selectedDate != null)
          Text(
            DateFormat('EEE, dd MMM').format(selectedDate!),
            style: const TextStyle(color: AppColors.primaryColor, fontSize: 16),
          ),
      ],
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    TextEditingController noteController = TextEditingController();
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

  void _showCalendarModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CalendarModalContent(
            onSelectionChanged: (args) {
              onDateChanged(args.value);
            },
          ),
        );
      },
    );
  }
}
