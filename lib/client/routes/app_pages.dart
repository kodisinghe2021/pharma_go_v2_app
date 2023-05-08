import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/client/controllers/auth/login_binding.dart';
import 'package:pharma_go_v2_app/client/controllers/auth/registration_binding.dart';
import 'package:pharma_go_v2_app/client/controllers/main/main_navbar_binding.dart';
import 'package:pharma_go_v2_app/client/controllers/splash/splash_binding.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/auth/login_page.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/auth/registration_page.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/nav_bar/main_nav_bar.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/splash/splash_screen.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  static final routes = [
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
      page: () =>  LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
      name: Paths.REGISTRATION,
      page: () => RegistrationPage(),
      binding: RegistraionBinding(),
    ),
    GetPage(
      name: Paths.MAINNAVBAR,
      page: () => const MainNavBar(),
      binding: MainNavBarBinding(),
    ),
  ];
}
