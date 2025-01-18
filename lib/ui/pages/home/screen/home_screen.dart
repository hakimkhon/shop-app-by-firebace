import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/cubit/user/user_cubit.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';
import 'package:shop/ui/pages/category/widget/category_item.dart';
import 'package:shop/ui/pages/widgets/my_app_bar_widget.dart';
import 'package:shop/ui/pages/category/widget/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(
      () {
        // ignore: use_build_context_synchronously
        context.read<UserCubit>().fetchUser();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("Shop App"),

      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         await logout();
      //       },
      //       icon: Icon(
      //         Icons.logout,
      //         color: Colors.red,
      //       ),
      //     ),
      //   ],
      // ),
      appBar: MyAppBar(
        title: "Shop App",
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
          IconButton(
            onPressed: () async {
              await logout();
            },
            icon: Icon(
              Icons.logout_sharp,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  5,
                  (index) {
                    return CategoryItem(
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            sliver: SliverGrid.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return ProductItem(
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    // SharedPreferences ma'lumotlarini olish
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Foydalanuvchi ma'lumotlarini tozalash
    await prefs.clear();

    // Navigatsiya: kirish ekraniga o'tkazish va barcha eski sahifalarni olib tashlash
    NavigationService.instance.navigateMyScreenAndRemoveUntil(
      routeName: AppRoutesNames.regist,
    );
  }
}
