import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/client/controllers/auth/login_binding.dart';
import 'package:pharma_go_v2_app/app/client/controllers/auth/registration_binding.dart';
import 'package:pharma_go_v2_app/app/client/controllers/main/main_navbar_binding.dart';
import 'package:pharma_go_v2_app/app/client/controllers/splash/splash_binding.dart';
import 'package:pharma_go_v2_app/app/client/presentation/pages/auth/login_page.dart';
import 'package:pharma_go_v2_app/app/client/presentation/pages/auth/registration_page.dart';
import 'package:pharma_go_v2_app/app/client/presentation/pages/nav_bar/main_nav_bar.dart';
import 'package:pharma_go_v2_app/app/client/presentation/pages/splash/splash_screen.dart';

// import 'package:pharma_go_v2_app/app/pharmacy/controllers/auth/login/login_bin.dart';
// import 'package:pharma_go_v2_app/app/pharmacy/controllers/orders/orders_binding.dart';
// import 'package:pharma_go_v2_app/app/pharmacy/controllers/pharma-nav-controller/pharama_nav_binding.dart';
// import 'package:pharma_go_v2_app/app/pharmacy/pages/auth/login.dart';
// import 'package:pharma_go_v2_app/app/pharmacy/pages/auth/registration.dart';
// import 'package:pharma_go_v2_app/app/pharmacy/pages/nav_bar/pharama_nav_bar.dart';
// import 'package:pharma_go_v2_app/app/pharmacy/pages/fragments/orders/orderd_medicine_list.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    // splash screen get page
    GetPage(
      transition: Transition.fade,
      curve: Curves.bounceIn,
      name: Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // client side getpages
    GetPage(
      transition: Transition.fade,
      curve: Curves.bounceIn,
      name: Paths.CLIENTLOGIN,
      page: () => ClientLoginPage(),
      binding: ClientLoginBinding(),
    ),

    //client side registration getpage
    GetPage(
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
      name: Paths.CLIENTREGISTRATION,
      page: () => ClientRegistrationPage(),
      binding: ClientRegistraionBinding(),
    ),

    //client side main navbar
    GetPage(
      name: Paths.CLIENTMAINNAVBAR,
      page: () => const ClientMainNavBar(),
      binding: ClientMainNavBarBinding(),
    ),

    // GetPage(
    //   name: Paths.CLIENTMAINNAVBAR,
    //   page: () => const MainNavBar(),
    //   binding: MainNavBarBinding(),
    // ),
    // GetPage(
    //   name: Paths.CLIENTMAINNAVBAR,
    //   page: () => const MainNavBar(),
    //   binding: MainNavBarBinding(),
    // ),
    // GetPage(
    //   name: Paths.REGISTRATIONPHARAMA,
    //   page: () => RegistrationPagePharma(),
    //   binding: RegistraionBinding(),
    // ),
    // GetPage(
    //   name: Paths.CLIENTMAINNAVBAR,
    //   page: () => const MainNavBar(),
    //   binding: MainNavBarBinding(),
    // ),
    // GetPage(
    //   name: Paths.LOGINPHARMA,
    //   page: () => LoginPharama(),
    //   binding: LoginPharamaBind(),
    // ),
    // GetPage(
    //   name: Paths.PHARMANAVBAR,
    //   page: () => PharamaNavBar(),
    //   binding: PharmaNavBarBinding(),
    // ),
    // GetPage(
    //   name: Paths.ORDERDATAILS,
    //   page: () => OrderdMedicineList(),
    //   binding: OrderBinding(),
    // ),
  ];
}

