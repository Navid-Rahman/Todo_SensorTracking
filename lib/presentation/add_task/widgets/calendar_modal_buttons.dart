import 'package:flutter/material.dart';

import '/constants/app_colors.dart';
import 'modal_button.dart';

class CalendarModalButtons extends StatelessWidget {
  const CalendarModalButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ModalButton(
          text: 'Cancel',
          textColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ModalButton(
          text: 'Done',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
