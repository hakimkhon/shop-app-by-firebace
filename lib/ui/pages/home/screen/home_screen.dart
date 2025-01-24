import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/cubit/home/home_cubit.dart';
import 'package:shop/cubit/home/home_state.dart';
import 'package:shop/cubit/user/user_cubit.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';
import 'package:shop/ui/pages/category/widget/category_item.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';
import 'package:shop/ui/pages/product/widget/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndexCategoryId = 0;

  @override
  void initState() {
    Future.microtask(
      () {
        // ignore: use_build_context_synchronously
        context.read<UserCubit>().fetchUser();
        // ignore: use_build_context_synchronously
        context.read<HomeCubit>().getCategories();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Shop App by Streem",
        actions: [
          IconButton(
            onPressed: () {
              NavigationService.instance.navigateMyScreen(
                routeName: AppRoutesNames.categoryAdd,
              );
            },
            icon: Icon(Icons.category_outlined),
          ),
          IconButton(
            onPressed: () {
              NavigationService.instance.navigateMyScreen(
                routeName: AppRoutesNames.productAdd,
              );
            },
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, state) {
          if (state.formsStatus == FormsStatus.loading) {
            Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      state.categories.length + 1,
                      (index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                activeIndexCategoryId = index;
                              });
                              context.read<HomeCubit>().getCategories();
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.orange.withValues(
                                  alpha: activeIndexCategoryId == 0 ? 1 : 0.3,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(13.w),
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    color: activeIndexCategoryId == 0
                                        ? Colors.black
                                        : Colors.grey,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return CategoryItem(
                          onTap: () {
                            setState(() {
                              activeIndexCategoryId = index;
                            });
                            context.read<HomeCubit>().listenProducts(
                                  state.categories[index - 1].categoryId,
                                );
                          },
                          onLongPress: () {},
                          categoryModel: state.categories[index - 1],
                          isActiva: activeIndexCategoryId == index,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                sliver: SliverGrid.builder(
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(
                      onTap: () {
                        NavigationService.instance.navigateMyScreen(
                          routeName: AppRoutesNames.productDetail,
                          arguments: state.products[index],
                        );
                      },
                      onLongPress: () {
                        NavigationService.instance.navigateMyScreen(
                          routeName: AppRoutesNames.productEdit,
                          arguments: state.products[index],
                        );
                      },
                      productModel: state.products[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
