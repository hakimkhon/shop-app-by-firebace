import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/ui/pages/auth/widget/my_text_form_field_widget.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  String imgURL = "";
  String categoryName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Add Product",
        loadingIcon: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: Column(
          children: [
            if(imgURL.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 170.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(imgURL),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            MyTextFormFieldWidget(
              hintText: "Enter product name",
              onChanged: (v) {
                setState(() {
                  imgURL = v;
                });
              },
            ),
            20.verticalSpace,
            MyTextFormFieldWidget(
              hintText: "Enter product prise",
              onChanged: (v) {
                setState(() {
                  categoryName = v;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
