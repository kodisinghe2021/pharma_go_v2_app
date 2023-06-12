import 'package:get/get.dart';
import 'package:pharma_go_v2_app/features/client/controllers/main/main_nav_bar_controller.dart';

class ClientMainNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainNavBarController>(MainNavBarController());
  }
}
