import 'package:flutter/material.dart';
import 'package:shop/ui/pages/auth/screens/registration_screen.dart';
import 'package:shop/ui/pages/category/screen/category_add_screen.dart';
import 'package:shop/ui/pages/category/screen/product_add_screen.dart';
import 'package:shop/ui/pages/home/screen/home_screen.dart';
import 'package:shop/ui/pages/splash/splash_screen.dart';

class AppRoutesNames {
  static const String home = '/home';
  static const String regist = '/regist';
  static const String splash = '/splash';
  static const String categoryAdd = '/categoryAdd';
  static const String productAdd = '/productAdd';
}

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;
  AppRoutes._init();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.productAdd:
        return MaterialPageRoute(
            builder: (context) => const ProductAddScreen());
      case AppRoutesNames.categoryAdd:
        return MaterialPageRoute(
            builder: (context) => const CategoryAddScreen());
      case AppRoutesNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutesNames.regist:
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreen());
      case AppRoutesNames.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
