import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/pharmacy/controllers/auth/login/pharma_login_controller.dart';

class PharmaLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmaLoginController>(PharmaLoginController());
    // TODO: implement dependencies
  }
}
