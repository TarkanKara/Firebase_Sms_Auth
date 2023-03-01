//ElevatedButton
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Size? minimumSize;
  final Color? backgroundColor, foregroundColor;
  final Function()? onPressed;
  final String data;
  const CustomElevatedButton({
    super.key,
    required this.minimumSize,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: minimumSize,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor),
      onPressed: onPressed,
      child: Text(data),
    );
  }
}