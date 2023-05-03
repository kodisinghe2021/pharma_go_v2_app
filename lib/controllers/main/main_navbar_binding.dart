import 'package:get/get.dart';
import 'package:pharma_go_v2_app/controllers/main/main_nav_bar_controller.dart';

class MainNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainNavBarController>( MainNavBarController());
  }
}
