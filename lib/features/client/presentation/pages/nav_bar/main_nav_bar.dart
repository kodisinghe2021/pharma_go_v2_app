import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/features/client/constant/colurs.dart';
import 'package:pharma_go_v2_app/features/client/controllers/main/main_nav_bar_controller.dart';


class ClientMainNavBar extends GetView<MainNavBarController> {
  const ClientMainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          title: const Text("HOME"),
          centerTitle: true,
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
