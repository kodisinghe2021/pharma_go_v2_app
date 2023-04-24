import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/controllers/auth/login_binding.dart';
import 'package:pharma_go_v2_app/controllers/home/home_binding.dart';
import 'package:pharma_go_v2_app/controllers/splash/splash_binding.dart';
import 'package:pharma_go_v2_app/presentation/pages/auth/login_page.dart';
import 'package:pharma_go_v2_app/presentation/pages/home/home_page.dart';
import 'package:pharma_go_v2_app/presentation/pages/splash/splash_screen.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      transition: Transition.fade,
      curve: Curves.bounceIn,
      name: Paths.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      curve: Curves.bounceIn,
      name: Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      transition: Transition.fade,
      curve: Curves.bounceIn,
      name: Paths.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
