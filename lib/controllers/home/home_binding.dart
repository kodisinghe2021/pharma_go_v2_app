import 'package:get/get.dart';
import 'package:pharma_go_v2_app/controllers/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}