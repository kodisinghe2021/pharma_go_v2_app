import 'package:get/get.dart';
import 'package:pharma_go_v2_app/features/pharmacy/controllers/auth/registration/pharma_registration_controller.dart';

class PharmaRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmaRegistrationController>(PharmaRegistrationController());
    // TODO: implement dependencies
  }
}
