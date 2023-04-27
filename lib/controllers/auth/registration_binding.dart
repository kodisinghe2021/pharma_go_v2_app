import 'package:get/get.dart';
import 'package:pharma_go_v2_app/controllers/auth/registration_controller.dart';

class RegistraionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegistrationController>(RegistrationController());
  }
}
