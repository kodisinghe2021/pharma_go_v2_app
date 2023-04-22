import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/controllers/home/home_binding.dart';
import 'package:pharma_go_v2_app/home_page.dart';

part 'routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      transition: Transition.fade,
      curve: Curves.bounceIn,
      name: Paths.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}


