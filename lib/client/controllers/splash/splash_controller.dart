import 'package:get/get.dart';
import 'package:pharma_go_v2_app/client/routes/app_pages.dart';
import 'package:pharma_go_v2_app/client/routes/navigator/navigator.dart';

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
