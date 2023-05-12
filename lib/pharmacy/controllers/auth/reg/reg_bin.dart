import 'package:get/get.dart';
import 'package:pharma_go_v2_app/pharmacy/controllers/auth/reg/reg_con.dart';

class RegistrationPharamaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RegistrationPharmaCon>(RegistrationPharmaCon());
    // TODO: implement dependencies
  }
}
