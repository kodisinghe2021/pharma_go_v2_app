import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/controllers/auth/login_binding.dart';
import 'package:pharma_go_v2_app/controllers/auth/registration_binding.dart';
import 'package:pharma_go_v2_app/controllers/home/home_binding.dart';
import 'package:pharma_go_v2_app/controllers/main/main_navbar_binding.dart';
import 'package:pharma_go_v2_app/controllers/splash/splash_binding.dart';
import 'package:pharma_go_v2_app/presentation/pages/auth/login_page.dart';
import 'package:pharma_go_v2_app/presentation/pages/auth/registration_page.dart';
import 'package:pharma_go_v2_app/presentation/pages/home/pages/home_page.dart';
import 'package:pharma_go_v2_app/presentation/pages/nav_bar/main_nav_bar.dart';
import 'package:pharma_go_v2_app/presentation/pages/splash/splash_screen.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.MAINNAVBAR;
  static final routes = [
    // GetPage(
    //   transition: Transition.fade,
    //   curve: Curves.bounceIn,
    //   name: Paths.HOME,
    //   page: () => const HomePage(),
    //   binding: HomeBinding(),
    // ),
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
