import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/pharmacy/pages/home/home.dart';
import 'package:pharma_go_v2_app/pharmacy/pages/medicine_list/medicine_list.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class PharmaNavBarController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage getStorage = GetStorage();

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  List<Tab> mainTabs = [
    const Tab(
      text: "Home",
      icon: Icon(Bootstrap.house),
    ),
    const Tab(
      text: "List",
      icon: Icon(Bootstrap.list),
    ),
  ];

  List<Widget> tabPages = [
    HomePharama(),
    MedicineList(),
  ];

  Future<void> logout() async {
    await _auth.signOut();
    await getStorage.erase();
    navigatePharama();
  }

  Future<void> navigatePharama() async {
    if (getStorage.read('uID') != null) {
      Future.delayed(
        const Duration(milliseconds: 3000),
        () => Get.offAllNamed(Routes.PHARMANAVBAR),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 3000),
        () => Get.offAllNamed(Routes.LOGINPHARMA),
      );
    }
  }
}
