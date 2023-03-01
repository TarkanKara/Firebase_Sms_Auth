//CustomDropDownFormField
import 'package:flutter/material.dart';

class CustomDropDownFormField extends StatelessWidget {
  final List<DropdownMenuItem<String>>? items;
  final String? value;
  final void Function(String?)? onChanged;

  const CustomDropDownFormField({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(20)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15)),
        filled: true,
      ),
      items: items,
      value: value,
      onChanged: onChanged,
    );
  }
}
