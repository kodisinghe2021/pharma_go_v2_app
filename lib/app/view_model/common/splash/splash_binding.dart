import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/common/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}
