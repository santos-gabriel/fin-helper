import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final String label;
  final bool? isObscure;
  final bool? isEnableSuggestions;
  final bool? isEnableAutocorrect;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;
  final TextStyle style;
  final TextStyle labelStyle;
  final TextInputType? keyboardType;
  final Widget? sufixIconWidget;

  const CustomInputText({
    Key? key,
    required this.label,
    this.initialValue,
    this.validator,
    this.controller,
    this.keyboardType,
    this.isObscure,
    this.isEnableAutocorrect,
    this.isEnableSuggestions,
    this.sufixIconWidget,
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
            obscureText: isObscure ?? false,
            enableSuggestions: isEnableSuggestions ?? true,
            autocorrect: isEnableAutocorrect ?? true,
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
              suffixIcon: sufixIconWidget,
            ),
          ),
        ],
      ),
    );
  }
}
