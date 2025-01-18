import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/data/utils/app/app_siza.dart';
import 'package:shop/ui/pages/category/widget/custom_button.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({super.key});

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  String imageURL = "";
  String categoryName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Add Category",
        loadingIcon: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: Column(
          children: [
            if (imageURL.isNotEmpty)
              SizedBox(
                width: width,
                height: 200.h,
                // child: Image.network(
                //   imgURL,
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, error, stackTrace) {
                //     return const Center(child: Text('Invalid Image URL'));
                //   },
                // ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(imageURL),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter image url",
              ),
              onChanged: (value) {
                setState(() {
                  imageURL = value;
                });
              },
            ),
            20.getH(),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter category name",
              ),
              onChanged: (value) {
                setState(() {
                  categoryName = value;
                });
              },
            ),
            // MyTextFormFieldWidget(
            //   hintText: "Enter category name...",
            //   onChanged: (value) {
            //     setState(() {
            //       categoryName = value;
            //     });
            //   },
            // ),
            20.getH(),
            CustomButton(
              onTap: () {},
              isActive: checkInput(),
            ),
          ],
        ),
      ),
    );
  }

  bool checkInput() {
    return imageURL.isNotEmpty && categoryName.isNotEmpty;
  }
}
