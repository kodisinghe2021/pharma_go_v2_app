import 'package:get/get.dart';

class OrderController extends GetxController {}

class OrderBingder extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderController>(OrderController());
  }
}
