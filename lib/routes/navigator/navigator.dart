import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

Future<void> navigatorLogging() async {
  GetStorage storage = GetStorage();
  if (storage.read('uID') != null) {
    Get.offAllNamed(Routes.HOME);
  } else {
    Get.offAllNamed(Routes.LOGIN);
  }
}
