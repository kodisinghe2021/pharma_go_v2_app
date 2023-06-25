import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/history/page/history.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/home/pages/home_page.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/medicine_list/pages/medicine.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/orders/page/orders.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

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

//------------------------------------- obs
  var tabIndex = 0.obs;

  List<Tab> mainTabs = [
    const Tab(text: "Home"),
    const Tab(text: "History"),
    const Tab(text: "Orders"),
    const Tab(text: "Medicine"),
  ];

  List<Widget> tabPages = [
    HomePage(),
    HistoryPage(),
    OrdersPage(),
    MedicinePage(),
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

// class CustomTab extends StatelessWidget {
//   const CustomTab({
//     required this.text,
//     super.key,
//   });
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 30,
//       decoration: BoxDecoration(
//         // color: Colors.amber,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: GoogleFonts.roboto(color: Colors.black, fontSize: 14),
//         ),
//       ),
//     );
//   }
// }
