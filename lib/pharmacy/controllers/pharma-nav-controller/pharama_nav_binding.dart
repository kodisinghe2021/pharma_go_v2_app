import 'package:get/get.dart';
import 'package:pharma_go_v2_app/pharmacy/controllers/pharma-nav-controller/pharma_nav_controller.dart';

class PharmaNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmaNavBarController>(PharmaNavBarController());
  }
}
