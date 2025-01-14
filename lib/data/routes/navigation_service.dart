import 'package:flutter/material.dart';
class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigationService._();
  static NavigationService instance = NavigationService._();

  // navigate pushNamed

  Future<dynamic> navigateMyScreen({required String routeName, var arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  // navigate pushReplacementNamed

  Future<dynamic> navigateMyScreenReplacement(
      {required String routeName, var arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  // navigate pushNamedAndRemoveUntil

  Future<dynamic> navigateMyScreenAndRemoveUntil(
      {required String routeName, var arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}