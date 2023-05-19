import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/client/constant/colurs.dart';
import 'package:pharma_go_v2_app/app/pharmacy/controllers/pharma-nav-controller/pharma_nav_controller.dart';

class PharamaNavBar extends GetView<PharmaNavBarController> {
  PharamaNavBar({super.key});
  @override
  PharmaNavBarController controller =
      Get.put<PharmaNavBarController>(PharmaNavBarController());
  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        //* app bar
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: vimo(),
            ),
          ),
          // elevation: 0.0,
          // backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(
              BoxIcons.bx_log_out_circle,
              size: 40,
            ),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Bootstrap.menu_app),
                ),
              ],
            ),
          ],

          bottom: TabBar(
            controller: controller.tabController,
            tabs: controller.mainTabs,
          ),
        ),

        //* body
        body: TabBarView(
          controller: controller.tabController,
          children: controller.tabPages,
        ),
      ),
    );
  }
}
