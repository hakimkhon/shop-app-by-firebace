import 'package:flutter/material.dart';

class MyTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function? onChanged;

  const MyTextFormFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      keyboardType: keyboardType,
      onChanged: (value) {
        onChanged!();
      },
    );
  }
}
