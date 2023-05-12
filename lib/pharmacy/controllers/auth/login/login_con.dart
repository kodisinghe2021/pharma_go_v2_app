import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/client/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class LoginPharmaCon extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final UserCredential _userCredential;
  final GetStorage getStorage = GetStorage();
  var isSuccessed = false.obs;
  var isLoading = false.obs;
  var isObsecure = true.obs;

  //* textediting controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signInWithFirebase() async {
    isSuccessed.value = false;
    isLoading.value = true;
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      isLoading.value = false;
      isSuccessed.value = true;
      await getStorage.write('uID', _userCredential.user!.uid);
      await getStorage.write('email', _userCredential.user!.email);
      await getStorage.write('user', 'pharmacy');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      await getStorage.write('error', e.code);
      showDialogBox("Error", e.code);
    }
  }

  Future<void> login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      await signInWithFirebase();
      await navigatePharama();
      Logger().i("in the login func");
      Logger().i(email.text.isEmpty);
    } else {
      getStorage.write('error', 'empty-fields');
      Logger().d("In the empty error");
      showDialogBox("Empty field", "Fields Cannot be empty");
      isSuccessed.value = false;
    }
  }

  Future<void> navigatePharama() async {
    if (getStorage.read('uID') != null) {
      Future.delayed(
        const Duration(milliseconds: 3000),
        () => Get.offAllNamed(Routes.PHARMANAVBAR),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 3000),
        () => Get.offAllNamed(Routes.LOGINPHARMA),
      );
    }
  }
}
