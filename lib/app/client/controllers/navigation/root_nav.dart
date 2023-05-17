// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:pharma_go_v2_app/routes/app_pages.dart';

// class RootNav {
//   final GetStorage _storage = GetStorage();
// //* navigate from Splash screen to login or home
//   Future<void> navFromSplash() async {
//     try {
//       String uID = await _storage.read('uID');
//       if (uID != null) {
//         Get.offAllNamed(Routes.MAINNAVBAR);
//       } else {
//         Get.offAllNamed(Routes.LOGIN);
//       }
//     } catch (e) {
//       Get.snackbar('Somthing went wrong.!', e.toString());
//     }
//   }
  // Future<void> navFromLogin() async {
  //   String uID = await _storage.read('uID');
  //   if (uID != null) {
  //     Get.offAllNamed(Routes.HOME);
  //   } else {
  //     Get.offAllNamed(Routes.LOGIN);
  //   }
  // }
  // Future<void> navFromRegistration() async {
  //   String uID = await _storage.read('uID');
  //   if (uID != null) {
  //     Get.offAllNamed(Routes.HOME);
  //   } else {
  //     Get.offAllNamed(Routes.LOGIN);
  //   }
  // }
// }
