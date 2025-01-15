import 'package:flutter/material.dart';

class MyTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const MyTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      // keyboardType: TextInputType.emailAddress,
    );
  }
}
