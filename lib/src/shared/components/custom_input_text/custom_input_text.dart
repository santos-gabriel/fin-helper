import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final String label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;
  final TextStyle style;
  final TextStyle labelStyle;
  final TextInputType? keyboardType;

  const CustomInputText({
    Key? key,
    required this.label,
    this.initialValue,
    this.validator,
    this.controller,
    this.keyboardType,
    required this.onChanged,
    required this.style,
    required this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            validator: validator,
            controller: controller,
            onChanged: onChanged,
            initialValue: initialValue,
            style: style,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: label,
              labelStyle: labelStyle,
            ),
          ),
        ],
      ),
    );
  }
}
