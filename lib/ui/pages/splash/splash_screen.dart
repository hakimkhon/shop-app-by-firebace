import 'package:flutter/material.dart';
import 'package:shop/data/local/storage_repository.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';
import 'package:shop/data/utils/app/app_siza.dart';
import 'package:shop/ui/core/constant/fixed_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      String adminId = StorageRepository.getString(key: FixedNames.adminId);

      if (adminId.isEmpty) {
        NavigationService.instance.navigateMyScreenReplacement(
          routeName: AppRoutesNames.regist,
        );
      } else {
        NavigationService.instance.navigateMyScreenReplacement(
          routeName: AppRoutesNames.home,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Text(
          "Loading ...",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
