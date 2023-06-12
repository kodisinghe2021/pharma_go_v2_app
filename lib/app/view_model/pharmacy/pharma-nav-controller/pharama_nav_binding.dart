import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/pharma-nav-controller/pharma_nav_controller.dart';

class PharamaNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmaNavBarController>(PharmaNavBarController());
  }
}
