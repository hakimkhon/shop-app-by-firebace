import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/cubit/home/home_cubit.dart';
import 'package:shop/cubit/product/product_cubit.dart';
import 'package:shop/data/models/category_model.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/data/utils/app/app_siza.dart';
import 'package:shop/ui/pages/widgets/custom_button.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';

class ProductUpdateScreen extends StatefulWidget {
  final ProductModel productModel;
  // final String productId;

  const ProductUpdateScreen({
    super.key,
    required this.productModel,
    // required this.productId,
  });

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  final TextEditingController _controllerImageUrl = TextEditingController();
  final TextEditingController _controllerProductName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();

  CategoryModel? categoryModel;

  @override
  void initState() {
    _controllerProductName.text = widget.productModel.title;
    _controllerImageUrl.text = widget.productModel.imageUrl;
    _controllerDescription.text = widget.productModel.description;
    _controllerPrice.text = widget.productModel.price;
    super.initState();
  }

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
        child: Column(
          children: [
            if (_controllerImageUrl.text.isNotEmpty)
              SizedBox(
                width: width,
                height: 200.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(_controllerImageUrl.text),
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
                  _controllerImageUrl.text = value;
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
                  _controllerProductName.text = value;
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
                  _controllerDescription.text = value;
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
                  _controllerPrice.text = value;
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
                      backgroundImage: NetworkImage(categories[index].imageUrl),
                    ),
                    title: Text(categories[index].title),
                  );
                },
              ),
            ),
            20.getH(),
            CustomButton(
              // isLoader: state.formsStatus == FormsStatus.loading,
              onTap: () {
                ProductModel productModel = ProductModel(
                  imageUrl: _controllerImageUrl.text,
                  title: _controllerProductName.text,
                  productId: "",
                  price: _controllerPrice.text,
                  description: _controllerDescription.text,
                );
                context
                    .read<ProductCubit>()
                    .updateProduct(productModel: productModel);
              },
              isActive: checkInput(),
            ),
          ],
        ),

        // listener: (BuildContext context, state) {
        //   if (state.statusMessage == FixedNames.pop) {
        //     context.read<HomeCubit>().getCategories();
        //     NavigationService.instance.navigateMyScreenAndRemoveUntil(
        //       routeName: AppRoutesNames.home,
        //     );
        //   }
        // },
      ),
    );
  }

  bool checkInput() {
    return _controllerImageUrl.text.isNotEmpty &&
        _controllerProductName.text.isNotEmpty &&
        _controllerDescription.text.isNotEmpty &&
        _controllerPrice.text.isNotEmpty &&
        categoryModel != null;
  }
}
