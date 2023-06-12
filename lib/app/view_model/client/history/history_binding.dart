import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/client/history/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HistoryController());
  }
}
