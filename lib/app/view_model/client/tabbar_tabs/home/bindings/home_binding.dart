import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/client/tabbar_tabs/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}