import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/auth/login_page.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/auth/registration_page.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/cart/controller/cart_binding.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/cart/page/cart.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/nav_bar/main_nav_bar.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/orders/page/orders.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/payment/controller/pay_controller.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/payment/page/pay_page.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/pharmacy_list/pharmacy_list.dart';
import 'package:pharma_go_v2_app/app/view/common/splash/splash_screen.dart';
import 'package:pharma_go_v2_app/app/view/pharmacy/auth/pharma_login.dart';
import 'package:pharma_go_v2_app/app/view/pharmacy/auth/pharma_registration.dart';
import 'package:pharma_go_v2_app/app/view/pharmacy/nav_bar/pharama_nav_bar.dart';
import 'package:pharma_go_v2_app/app/view_model/client/auth/login_binding.dart';
import 'package:pharma_go_v2_app/app/view_model/client/auth/registration_binding.dart';
import 'package:pharma_go_v2_app/app/view_model/client/main_nav/main_navbar_binding.dart';
import 'package:pharma_go_v2_app/app/view_model/client/pharmacy_list/pharmacy_list_binder.dart';
import 'package:pharma_go_v2_app/app/view_model/common/splash/splash_binding.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/auth/login/pharma_login_binding.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/auth/registration/pharma_registration_binding.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/orders/orders_binding.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/pharma-nav-controller/pharama_nav_binding.dart';

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
      page: () => ClientMainNavBar(),
      binding: ClientMainNavBarBinding(),
    ),

    //pharmacy side Login page
    GetPage(
      name: Paths.PHARMALOGIN,
      page: () => PharmaLoginPage(),
      binding: PharmaLoginBinding(),
    ),

    //pharmacy side registration page
    GetPage(
      name: Paths.PHARMAREGISTRATION,
      page: () => const PharmaRegistrationPage(),
      binding: PharmaRegistrationBinding(),
    ),

    //pharma side main nav bar
    GetPage(
      name: Paths.PHARMANAVBAR,
      page: () => PharamaNavBar(),
      binding: PharamaNavBarBinding(),
    ),

    //pharmacy list
    GetPage(
      name: Paths.PHARMACYLIST,
      page: () => PharmacyListPage(),
      binding: PharmacyListBingder(),
    ),

    GetPage(
      name: Paths.ORDERSPAGE,
      page: () => const OrdersPage(),
      binding: OrderBinding(),
    ),

    GetPage(
      name: Paths.CARTPAGE,
      page: () => CartPage(),
      binding: CartBinding(),
    ),

    GetPage(
      name: Paths.PAYPAGE,
      page: () => const PayPage(),
      binding: PayBinding(),
    ),
  ];
}
