import 'package:get/get.dart';

class PayController extends GetxController {

}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~binding
class PayBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PayController>(PayController());
  }
}
