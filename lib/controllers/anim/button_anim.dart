import 'package:get/get.dart';

class ButtonAnimController extends GetxController {
  var blurRadius = 10.5.obs;
  var spreadRadius = 1.5.obs;

  void clickedAnim() {
    blurRadius.value = 20;
    spreadRadius.value = 10;
  }
}
