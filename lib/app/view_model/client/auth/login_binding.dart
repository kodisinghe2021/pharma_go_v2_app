import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/client/auth/login_controller.dart';


class ClientLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ClientLoginController>(ClientLoginController());
  }
}
