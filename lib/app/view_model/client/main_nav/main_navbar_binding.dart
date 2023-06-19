import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/client/main_nav/main_nav_bar_controller.dart';

class ClientMainNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainNavBarController>(MainNavBarController());
  }
}
