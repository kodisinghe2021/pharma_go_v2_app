import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/client/controllers/auth/login_controller.dart';

class ClientLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ClientLoginController>(ClientLoginController());
  }
}
