import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:to_do_sensor_tracking/presentation/add_task/task_details_view.dart';
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

  // Function to handle date selection from date picker
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDate = args.value;
    });
  }

  // Function to show the task adding modal
  void _showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: _buildAddTaskModalContent(),
        );
      },
    );
  }

  // Function to show the calendar modal for date selection
  void _showCalendarModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: _buildCalendarModalContent(),
        );
      },
    );
  }

  // Widget for the Add Task Modal Content
  Widget _buildAddTaskModalContent() {
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
              const Expanded(
                child: TextField(
                  autofocus: true,
                  style: TextStyle(color: AppColors.textColor, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Add a task',
                    hintStyle:
                        TextStyle(color: AppColors.hintColor, fontSize: 18),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Icon(Icons.check_circle, color: AppColors.primaryColor),
            ],
          ),
          const SizedBox(height: 20),
          _buildTaskActionRow(),
        ],
      ),
    );
  }

  // Widget for task action row
  Widget _buildTaskActionRow() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded,
              size: 22, color: Color(0xffA7A7A7)),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.note_outlined,
              size: 22, color: Color(0xffA7A7A7)),
        ),
        IconButton(
          icon: Icon(
            Icons.calendar_month_rounded,
            size: 22,
            color: _selectedDate == null
                ? const Color(0xffA7A7A7)
                : AppColors.primaryColor,
          ),
          onPressed: () => _showCalendarModal(context),
        ),
        if (_selectedDate != null)
          Text(
            DateFormat('EEE, dd MMM').format(_selectedDate!),
            style: const TextStyle(color: AppColors.primaryColor, fontSize: 16),
          ),
      ],
    );
  }

  // Widget for calendar modal content
  Widget _buildCalendarModalContent() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            todayHighlightColor: AppColors.primaryColor,
            selectionColor: AppColors.primaryColor,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.single,
            backgroundColor: Colors.white,
            headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: Colors.white,
              textAlign: TextAlign.center,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            showNavigationArrow: true,
            monthViewSettings: const DateRangePickerMonthViewSettings(
              viewHeaderHeight: 70,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle:
                    TextStyle(fontSize: 16, color: AppColors.primaryColor),
              ),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              todayTextStyle:
                  const TextStyle(fontSize: 16, color: AppColors.primaryColor),
              textStyle:
                  const TextStyle(fontSize: 16, color: AppColors.textColor),
              cellDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(0)),
            ),
          ),
          const SizedBox(height: 20),
          _buildCalendarModalButtons(),
        ],
      ),
    );
  }

  // Widget for calendar modal buttons
  Widget _buildCalendarModalButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildModalButton('Cancel', Colors.black, () {
          Navigator.pop(context);
        }),
        _buildModalButton('Done', Colors.white, () {
          Navigator.pop(context);
        }, backgroundColor: AppColors.primaryColor),
      ],
    );
  }

  // Helper method to create a modal button
  Widget _buildModalButton(String text, Color textColor, VoidCallback onPressed,
      {Color backgroundColor = Colors.transparent}) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: 40,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(8)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }

  // Main widget build method
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          side: const BorderSide(
                              color: AppColors.hintColor, width: 1.5),
                          onChanged: (bool? value) {},
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task 1',
                              style: TextStyle(color: AppColors.textColor),
                            ),
                            Row(
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
                                      color: Color(0xffB9B9BE), fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star_border_outlined,
                          color: AppColors.textColor,
                        ),
                      ],
                    ),
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
