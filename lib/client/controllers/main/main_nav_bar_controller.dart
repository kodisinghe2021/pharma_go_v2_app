import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/chat/chat.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/history/history.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/home/pages/home_page.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/medicine_list/medicine.dart';
import 'package:pharma_go_v2_app/client/routes/navigator/navigator.dart';

class MainNavBarController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage _storage = GetStorage();
  
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
     HistoryPage(),
     ChatPage(),
     MedicinePage(),
  ];

  Future<void> logout() async {
    await _auth.signOut();
    await _storage.erase();
    navigatorLogging();
  }
}
