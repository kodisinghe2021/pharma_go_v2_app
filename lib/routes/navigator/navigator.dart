import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

Future<void> navigatorLogging() async {
  //--- local storage intance
  GetStorage localStorage = GetStorage();
  Logger().i("reading id");

  String userID = await localStorage.read('uID');

  String userIS = await localStorage.read('userIS');

  Logger().i("id gotted - $userID -- $userIS");
  //--- check whether the use is client or pharmacy
  if (userIS == 'client') {
    //--- check whether the userID is empty or not
    if (userID.isNotEmpty) {
      Get.offAllNamed(Routes.CLIENTMAINNAVBAR);
    } else {
      Get.offAllNamed(Routes.CLIENTLOGIN);
    }
  } else if (userIS == 'pharmacy') {
    if (userID.isNotEmpty) {
      Get.offAllNamed(Routes.CLIENTMAINNAVBAR);
    } else {
      Get.offAllNamed(Routes.CLIENTLOGIN);
    }
  } else {
    Get.offAllNamed(Routes.CLIENTLOGIN);
  }
}
