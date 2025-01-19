import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/utils/app/app_siza.dart';

class CategoryItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final CategoryModel categoryModel;
  final bool isActiva;

  const CategoryItem({
    super.key,
    required this.onTap,
    required this.categoryModel,
    required this.onLongPress,
    required this.isActiva,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 2.w),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: isActiva ? 1 : 0.3),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 6.w,
                  bottom: 6.w,
                  left: 10.w,
                  right: 6.w,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(categoryModel.imageUrl),
                ),
              ),
              Text(
                categoryModel.title,
                style: TextStyle(
                  color: isActiva ? Colors.black: Colors.grey,
                  fontSize: 16.sp,
                ),
              ),
              10.getW(),
            ],
          ),
        ),
      ),
    );
  }
}
