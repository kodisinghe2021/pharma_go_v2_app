import 'package:get/get.dart';
import 'package:pharma_go_v2_app/routes/navigator/navigator.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () => navigatorLogging(),
    );
    super.onInit();
  }
}
