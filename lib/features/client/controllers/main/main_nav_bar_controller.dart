import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/features/client/presentation/pages/chat/chat.dart';
import 'package:pharma_go_v2_app/features/client/presentation/pages/history/history.dart';
import 'package:pharma_go_v2_app/features/client/presentation/pages/home/pages/home_page.dart';
import 'package:pharma_go_v2_app/features/client/presentation/pages/medicine_list/medicine.dart';
import 'package:pharma_go_v2_app/services/firebase_instance.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class MainNavBarController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final BackEndSupport _backEndSupport = BackEndSupport();
  final GetStorage _localStorage = GetStorage();

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  List<Tab> mainTabs = [
    const Tab(text: "Home"),
    const Tab(text: "History"),
    const Tab(text: "Chat"),
    const Tab(text: "Medicine"),
  ];

  List<Widget> tabPages = [
    HomePage(),
    const HistoryPage(),
    ChatPage(),
    const MedicinePage(),
  ];

  Future<void> logout() async {
    //--- sign out from back end.
    _backEndSupport.auth().signOut();
    Logger().i("sign out from firebase");
    //-- erase all local data.
    _localStorage.erase();

    Logger().i("erase all data");

    //--- naviagator
    Get.offAllNamed(Routes.SPLASH);
  }
}
