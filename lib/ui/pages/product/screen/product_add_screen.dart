import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/cubit/home/home_cubit.dart';
import 'package:shop/cubit/product/product_cubit.dart';
import 'package:shop/cubit/product/product_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/local/storage_repository.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';
import 'package:shop/data/utils/app/app_siza.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';
import 'package:shop/ui/pages/widgets/custom_button.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  String imageURL = "";
  String productName = "";
  String description = "";
  String price = "";
  CategoryModel? categoryModel;

  final ExpansionTileController _expansionTileController =
      ExpansionTileController();
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = context.read<HomeCubit>().state.categories;
    return Scaffold(
      appBar: MyAppBar(
        title: "Add Product",
        loadingIcon: true,
        centerTitle: true,
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
            child: Column(
              children: [
                if (imageURL.isNotEmpty)
                  SizedBox(
                    width: width,
                    height: 200.h,
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
                    hintText: "Enter product name",
                  ),
                  onChanged: (value) {
                    setState(() {
                      productName = value;
                    });
                  },
                ),
                20.getH(),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter description",
                  ),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
                20.getH(),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Enter product price",
                  ),
                  onChanged: (value) {
                    setState(() {
                      price = value;
                    });
                  },
                ),
                // 20.getH(),
                ExpansionTile(
                  controller: _expansionTileController,
                  title: Text(categoryModel?.title ?? "Select Category"),
                  children: List.generate(
                    categories.length,
                    (index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            categoryModel = categories[index];
                          });
                          _expansionTileController.collapse();
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(categories[index].imageUrl),
                        ),
                        title: Text(categories[index].title),
                      );
                    },
                  ),
                ),
                20.getH(),
                CustomButton(
                  isLoader: state.formsStatus == FormsStatus.loading,
                  onTap: () {
                     String adminId =
                        StorageRepository.getString(key: FixedNames.adminId);
                    ProductModel productModel = ProductModel(
                      productId: '',
                      imageUrl: imageURL,
                      title: productName,
                      categoryId: categoryModel?.categoryId ?? "",
                      price: price,
                      description: description, 
                      adminId: adminId,
                    );
                    context
                        .read<ProductCubit>()
                        .addProduct(productModel: productModel);
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
    return imageURL.isNotEmpty &&
        productName.isNotEmpty &&
        price.isNotEmpty &&
        description.isNotEmpty &&
        categoryModel != null;
  }
}
