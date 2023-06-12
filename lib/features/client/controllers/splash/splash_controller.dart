import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class SplashController extends GetxController {
  final _localStorage = GetStorage();

  @override
  void onReady() {
    // TODO: implement onReady
    if (_localStorage.read('uID') != null) {
      if (_localStorage.read('userIS') == 'client') {
        Future.delayed(
          const Duration(milliseconds: 1000),
          () => Get.offAllNamed(Routes.CLIENTMAINNAVBAR),
        );
      }
      if (_localStorage.read('userIS') == 'pharma') {
        Future.delayed(
          const Duration(milliseconds: 1000),
          () => Get.offAllNamed(Routes.PHARMANAVBAR),
        );
      }
    } else {
      Future.delayed(
        const Duration(milliseconds: 1000),
        () => Get.offAllNamed(Routes.CLIENTLOGIN),
      );
    }
    super.onReady();
  }
}
