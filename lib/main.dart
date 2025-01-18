import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/cubit/auth/auth_cubit.dart';
import 'package:shop/cubit/user/user_cubit.dart';
import 'package:shop/data/local/storage_repository.dart';
import 'package:shop/data/repositories/auth_repository.dart';
import 'package:shop/data/repositories/user_repository.dart';
import 'package:shop/data/routes/app_routes.dart';
import 'package:shop/data/routes/navigation_service.dart';
import 'package:shop/data/service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  StorageRepository.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(create: (_) => AuthRepository()),
              RepositoryProvider(create: (_) => UserRepository()),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AuthCubit(
                    context.read<AuthRepository>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => UserCubit(
                    context.read<UserRepository>(),
                  ),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Shop App',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.transparent,
                  ),
                ),
                navigatorKey: NavigationService.instance.navigatorKey,
                onGenerateRoute: AppRoutes.generateRoute,
                initialRoute: AppRoutesNames.splash,
              ),
            ),
          );
        });
  }
}
