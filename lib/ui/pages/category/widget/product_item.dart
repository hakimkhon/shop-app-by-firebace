import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final VoidCallback onTap;
  
  const ProductItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            "My product",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
