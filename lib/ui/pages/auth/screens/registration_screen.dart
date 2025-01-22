import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/cubit/auth/auth_cubit.dart';
import 'package:shop/cubit/auth/auth_state.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';
import 'package:shop/data/service/notifi_server.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    NotificationService.initNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          builder: (BuildContext context, AuthState state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Sign in by Phone number ",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  20.verticalSpace,
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Inter phone number"),
                    controller: _controllerPhoneNumber,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  20.verticalSpace,
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Inter password"),
                    controller: _controllerPassword,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  30.verticalSpace,
                  TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        backgroundColor: Colors.blue),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<AuthCubit>().loginAdminByPhoneNumber(
                            phoneNumber: _controllerPhoneNumber.text,
                            password: _controllerPassword.text,
                          );
                      debugPrint(
                          "Create account on Pressed:*******************************");
                    },
                    child: context.watch<AuthCubit>().state.formsStatus ==
                            FormsStatus.loading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                  ),
                ],
              ),
            );
          },
          listener: (BuildContext context, AuthState state) {
            if (state.formsStatus == FormsStatus.authenticated) {
              NavigationService.instance.navigateMyScreenAndRemoveUntil(
                routeName: AppRoutesNames.home,
              );
            } else if (state.formsStatus == FormsStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.errorText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerPhoneNumber.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
