import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ProductModel productModel;

  const ProductItem({
    super.key,
    required this.onTap,
    required this.productModel,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            5.verticalSpace,
            SizedBox(
              width: 150.w,
              height: 140.w,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productModel.imageUrl,),
                ),
              )),
            ),
            Text(
              productModel.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
