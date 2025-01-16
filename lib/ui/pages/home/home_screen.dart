import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/cubit/user/user_cubit.dart';
import 'package:shop/cubit/user/user_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';

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
        body: BlocConsumer<UserCubit, UserState>(
          builder: (BuildContext context, UserState state) {
            if (state.formsStatus == FormsStatus.loading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return Center(
              child: Text(
                state.userModel.phoneNumber,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            );
          }, listener: (BuildContext context,  state) { 

           },
        ));
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
