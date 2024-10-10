import 'package:flutter/material.dart';
import 'task_details_view.dart';
import 'widgets/add_task_modal.dart';
import 'widgets/task_list_item.dart';
import '/constants/app_colors.dart';
import '/utils/base_page.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const String routeName = 'add_task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _note;

  bool _isStarred = false;
  bool _isCompleted = false;
  final TextEditingController _taskController = TextEditingController();
  final ValueNotifier<bool> _isTextEntered = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _taskController.addListener(() {
      _isTextEntered.value = _taskController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    _isTextEntered.dispose();
    super.dispose();
  }

  void _showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskModal(
                taskController: _taskController,
                isTextEntered: _isTextEntered,
                selectedDate: _selectedDate,
                selectedTime: _selectedTime,
                note: _note,
                onNoteChanged: (note) {
                  setModalState(() {
                    _note = note;
                  });
                },
                onDateChanged: (date) {
                  setModalState(() {
                    _selectedDate = date;
                  });
                },
                onTimeChanged: (time) {
                  setModalState(() {
                    _selectedTime = time;
                  });
                },
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      _taskController.clear();
      _isTextEntered.value = false;
      _selectedDate = null;
      _selectedTime = null;
      _note = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BasePage(
          showAppBar: true,
          appBarTitle: 'Lists',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'List Task (0)',
                  style: TextStyle(fontSize: 20, color: AppColors.textColor),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, TaskDetailsView.routeName);
                  },
                  child: TaskListItem(
                    isCompleted: _isCompleted,
                    isStarred: _isStarred,
                    onCompletedChanged: (value) {
                      setState(() {
                        _isCompleted = value;
                      });
                    },
                    onStarredChanged: (value) {
                      setState(() {
                        _isStarred = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 12,
          right: 12,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onPressed: () => _showAddTaskModal(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 14,
                    child: Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                  SizedBox(width: 10),
                  Text('Add a Task',
                      style: TextStyle(color: AppColors.textColor)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
