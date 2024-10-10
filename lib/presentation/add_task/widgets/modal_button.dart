import 'package:flutter/material.dart';

class ModalButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ModalButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.onPressed,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
