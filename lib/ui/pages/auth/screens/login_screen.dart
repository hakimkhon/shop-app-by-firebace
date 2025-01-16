import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/cubit/auth/auth_cubit.dart';
import 'package:shop/data/enums/forms_status.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              Text(
                "Sign in to Notes",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.verticalSpace,
              TextFormField(
                decoration: const InputDecoration(hintText: "Inter email"),
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              20.verticalSpace,
              TextFormField(
                decoration: const InputDecoration(hintText: "Inter password"),
                controller: _controllerPassword,
                keyboardType: TextInputType.visiblePassword,
              ),
              10.verticalSpace,
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "New to Notes? ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                    children: [
                      const TextSpan(text: " "),
                      TextSpan(
                        text: "Create an account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            NavigationService.instance.navigateMyScreen(
                              routeName: AppRoutesNames.regist,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              30.verticalSpace,
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    backgroundColor: Colors.blue),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<AuthCubit>().loginUserByEmail(
                        email: _controllerEmail.text,
                        password: _controllerPassword.text,
                      );
                  debugPrint("\nLogin on Pressed:*******************************\n");
                },
                child: context.watch<AuthCubit>().state.formsStatus ==
                        FormsStatus.loading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
