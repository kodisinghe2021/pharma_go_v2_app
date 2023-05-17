import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/client/controllers/auth/registration_controller.dart';

class ClientRegistraionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ClientRegistrationController>(ClientRegistrationController());
  }
}
