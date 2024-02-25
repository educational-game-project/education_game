import 'dart:async';
import 'dart:developer';

import 'package:education_game/cubit/auth/auth_cubit.dart';
import 'package:education_game/route/app_route.dart';
import 'package:education_game/views/pages/additional_pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      await ScreenUtil.ensureScreenSize();
      runApp(const App());
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class Providers extends StatelessWidget {
  const Providers({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: child,
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return Providers(
          child: GetMaterialApp(
            initialRoute: '/',
            title: 'Game Education',
            getPages: AppRoute.pageRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
