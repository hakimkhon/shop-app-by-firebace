import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/utils/app/app_siza.dart';
import 'package:shop/ui/pages/widgets/custom_button.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailScreen({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Detail Product",
        loadingIcon: true,
        centerTitle: true,
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              productModel.title,
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.getH(),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image(
                width: 350.w,
                height: 250.h,
                image: NetworkImage(productModel.imageUrl),
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
              child: Text(
                textAlign: TextAlign.center,
                productModel.description,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              "${productModel.price} so'm",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            40.getH(),
            CustomButton(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
