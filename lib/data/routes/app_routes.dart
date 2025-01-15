import 'package:flutter/material.dart';
import 'package:shop/ui/screens/auth/login_screen.dart';
import 'package:shop/ui/screens/auth/registration_screen.dart';
import 'package:shop/ui/screens/home/home_screen.dart';

class AppRoutesNames {
  static const String home = '/home';
  static const String regist = '/regist';
  static const String login = '/login';
}

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;
  AppRoutes._init();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
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
