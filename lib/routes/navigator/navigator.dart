import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

Future<void> navigatorLogging() async {
  GetStorage storage = GetStorage();
  if (storage.read('uID') != null) {
    if (storage.read('userIS') == 'client') {
      Get.offAllNamed(Routes.MAINNAVBAR);
    } else {
      Get.offAllNamed(Routes.PHARMANAVBAR);
    }
  } else {
    if (storage.read('userIS') == 'client') {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.LOGINPHARMA);
    }
  }
}
