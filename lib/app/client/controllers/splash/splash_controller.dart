import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class SplashController extends GetxController {
  final _localStorage = GetStorage();

  @override
  void onReady() {
    // TODO: implement onReady
    if (_localStorage.read('uID') != null) {
      Future.delayed(
        const Duration(milliseconds: 1000),
        () => Get.offAllNamed(Routes.CLIENTMAINNAVBAR),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 1000),
        () => Get.offAllNamed(Routes.CLIENTLOGIN),
      );
    }
    super.onReady();
  }
}
