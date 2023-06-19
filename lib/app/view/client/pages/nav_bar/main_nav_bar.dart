import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/view_model/client/main_nav/main_nav_bar_controller.dart';

class ClientMainNavBar extends GetView<MainNavBarController> {
  ClientMainNavBar({super.key});

  final MainNavBarController _controller =
      Get.put<MainNavBarController>(MainNavBarController());

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        //* app bar
        appBar: AppBar(
          backgroundColor: Colors.black,
          flexibleSpace: Container(
              // decoration: BoxDecoration(
              //   gradient: vimo(),
              // ),
              ),
          leading: IconButton(
            onPressed: () {
              Logger().i("width - ${s.width}");
              Logger().i("heigth - ${s.height}");
              _controller.logout();
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
        ),

        //* body
        body: Stack(
          children: [
            TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: _controller.tabController,
              children: _controller.tabPages,
            ),
            Align(
              alignment: Alignment.topCenter,
              // child: Theme(
              //   data:
              //       Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: TabBar(
                physics: const BouncingScrollPhysics(),
                onTap: (value) => Logger().i(
                    "index is --$value  -------- ${_controller.tabController.index}"),
                // indicator: const BoxDecoration(
                //     color: Colors.blue, shape: BoxShape.circle),
                indicatorSize: TabBarIndicatorSize.label,
                controller: _controller.tabController,
                tabs: _controller.mainTabs,
              ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
