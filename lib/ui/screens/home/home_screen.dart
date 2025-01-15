import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () async {
                await logout();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ))
        ],
      ),
      body: Center(
        child: Text("Hello"),
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
