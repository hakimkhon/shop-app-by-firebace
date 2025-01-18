import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;

  const CustomButton({
    super.key,
    required this.onTap,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor:
              isActive ? Colors.blue : Colors.grey.withValues(alpha: 0.8),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w)),
      onPressed: isActive ? onTap : null,
      child: Text(
        "Submit",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
