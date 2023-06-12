import 'package:get/get.dart';
import 'package:pharma_go_v2_app/features/pharmacy/controllers/pharma-nav-controller/pharma_nav_controller.dart';

class PharamaNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmaNavBarController>(PharmaNavBarController());
  }
}
