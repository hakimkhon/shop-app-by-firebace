import 'package:flutter/material.dart';
import 'package:shop/data/models/product_model.dart';
import 'package:shop/ui/pages/category/screen/category_add_screen.dart';
import 'package:shop/ui/pages/product/screen/product_add_screen.dart';
import 'package:shop/ui/pages/home/screen/home_screen.dart';
import 'package:shop/ui/pages/product/screen/product_detail_screen.dart';
import 'package:shop/ui/pages/product/screen/product_update_screen.dart';
import 'package:shop/ui/pages/splash/splash_screen.dart';

class AppRoutesNames {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String categoryAdd = '/categoryAdd';
  static const String productAdd = '/productAdd';
  static const String productEdit = '/productEdit';
  static const String productDetail = '/productDetail';
}

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;
  AppRoutes._init();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.productDetail:
        return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
                productModel: settings.arguments as ProductModel));
      case AppRoutesNames.productEdit:
        return MaterialPageRoute(
            builder: (context) => ProductUpdateScreen(
                productModel: settings.arguments as ProductModel));
      case AppRoutesNames.productAdd:
        return MaterialPageRoute(
            builder: (context) => const ProductAddScreen());
      case AppRoutesNames.categoryAdd:
        return MaterialPageRoute(
            builder: (context) => const CategoryAddScreen());
      case AppRoutesNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutesNames.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
