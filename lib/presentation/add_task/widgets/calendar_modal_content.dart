import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '/constants/app_colors.dart';
import 'calendar_modal_buttons.dart';

class CalendarModalContent extends StatelessWidget {
  final ValueChanged<DateRangePickerSelectionChangedArgs> onSelectionChanged;

  const CalendarModalContent({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SfDateRangePicker(
            onSelectionChanged: onSelectionChanged,
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
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const CalendarModalButtons(),
        ],
      ),
    );
  }
}
