import 'package:flutter/material.dart';
import 'package:shop/ui/pages/auth/screens/login_screen.dart';
import 'package:shop/ui/pages/auth/screens/registration_screen.dart';
import 'package:shop/ui/pages/home/home_screen.dart';
import 'package:shop/ui/pages/splash/splash_screen.dart';

class AppRoutesNames {
  static const String home = '/home';
  static const String regist = '/regist';
  static const String login = '/login';
  static const String splash = '/splash';
}

class AppRoutes {
  static final AppRoutes _instance = AppRoutes._init();
  static AppRoutes get instance => _instance;
  AppRoutes._init();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
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
