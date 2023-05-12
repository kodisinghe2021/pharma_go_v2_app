import 'package:get/get.dart';
import 'package:pharma_go_v2_app/pharmacy/controllers/home/home_pharma_con.dart';

class HomePharmaBin extends Bindings {
  @override
  void dependencies() {
    Get.put<HomePharmaCon>(HomePharmaCon());
    // TODO: implement dependencies
  }
}
