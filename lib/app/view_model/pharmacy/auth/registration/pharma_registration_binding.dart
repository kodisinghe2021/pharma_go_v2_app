import 'package:get/get.dart';

import 'pharma_registration_controller.dart';

class PharmaRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmaRegistrationController>(PharmaRegistrationController());
    // TODO: implement dependencies
  }
}
