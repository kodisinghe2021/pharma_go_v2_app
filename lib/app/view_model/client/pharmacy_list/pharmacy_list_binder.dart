import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/client/pharmacy_list/pharmacy_list_controller.dart';

class PharmacyListBingder extends Bindings {
  @override
  void dependencies() {
    Get.put<PharmacyListController>(PharmacyListController());
  }
}
