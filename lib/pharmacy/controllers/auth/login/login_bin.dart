import 'package:get/get.dart';
import 'package:pharma_go_v2_app/pharmacy/controllers/auth/login/login_con.dart';

class LoginPharamaBind extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginPharmaCon>(LoginPharmaCon());
    // TODO: implement dependencies
  }
}
