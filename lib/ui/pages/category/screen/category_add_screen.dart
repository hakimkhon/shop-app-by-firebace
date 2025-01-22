import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/cubit/category/category_cubit.dart';
import 'package:shop/cubit/category/category_state.dart';
import 'package:shop/cubit/home/home_cubit.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';
import 'package:shop/data/service/notifi_server.dart';
import 'package:shop/data/utils/app/app_siza.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';
import 'package:shop/ui/core/constant/id_generation.dart';
import 'package:shop/ui/pages/widgets/custom_button.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({super.key});

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  String imageUrl = "";
  String categoryName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Add Category",
        loadingIcon: true,
        centerTitle: true,
      ),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
            child: Column(
              children: [
                if (imageUrl.isNotEmpty)
                  SizedBox(
                    width: width,
                    height: 200.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
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
                      imageUrl = value;
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
                20.getH(),
                CustomButton(
                  isLoader: state.formsStatus == FormsStatus.loading,
                  onTap: () {
                    context.read<CategoryCubit>().addCategory(
                          categoryModel: CategoryModel(
                            imageUrl: imageUrl,
                            title: categoryName,
                            categoryId: "",
                          ),
                        );

                    NotificationService.showNotification(
                      id: IdGeneration.id(),
                      title: "Add Category",
                      body: "$categoryName adding !",
                      // payload: "buni nima ekanligini bilmadim",
                    );
                  },
                  isActive: checkInput(),
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, state) {
          if (state.statusMessage == FixedNames.pop) {
            context.read<HomeCubit>().getCategories();
            NavigationService.instance.navigateMyScreenAndRemoveUntil(
              routeName: AppRoutesNames.home,
            );
          }
        },
      ),
    );
  }

  bool checkInput() {
    return imageUrl.isNotEmpty && categoryName.isNotEmpty;
  }
}
