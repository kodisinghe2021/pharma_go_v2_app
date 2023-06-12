import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/orders/orders_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<OrdersController>(OrdersController());
  }
}
