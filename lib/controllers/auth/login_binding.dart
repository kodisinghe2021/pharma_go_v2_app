import 'package:get/get.dart';
import 'package:pharma_go_v2_app/controllers/auth/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}
