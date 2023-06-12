import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/home/home_pharma_con.dart';

class HomePharmaBin extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmaHomeController>(PharmaHomeController());
    // TODO: implement dependencies
  }
}
