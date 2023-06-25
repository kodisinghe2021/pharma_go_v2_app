import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/medicine_list/controllers/medicine_controller.dart';



class MedicineBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MedicineController());
    // TODO: implement dependencies
  }
}
