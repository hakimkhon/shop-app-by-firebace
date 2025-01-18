import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 3.w),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.amber[800],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Text(
              "My category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
