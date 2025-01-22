// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ConfirmationDialog {
  final Function onConfirmed;

  ConfirmationDialog({required this.onConfirmed});

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tasdiqlash'),
      content: Text('Siz haqiqatan ham o\'chirmoqchimisiz?'),
      actions: [
        TextButton(
          child: Text('Yo\'q'),
          onPressed: () {
            Navigator.of(context).pop(); // Dialogni yopish
          },
        ),
        TextButton(
          child: Text('Ha'),
          onPressed: () {
            onConfirmed();
            Navigator.of(context).pop(); // Dialogni yopish
          },
        ),
      ],
    );
  }
}
