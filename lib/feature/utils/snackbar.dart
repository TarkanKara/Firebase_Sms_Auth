import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String mesage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mesage),
    ),
  );
}
