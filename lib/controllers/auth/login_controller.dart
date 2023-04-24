import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/routes/navigator/navigator.dart';

class LoginController extends GetxController {
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
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      await getStorage.write('error', e.code);
    }
  }

  Future<void> login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      await signInWithFirebase();
      navigatorLogging();
      Logger().i("in the login func");
      Logger().i(email.text.isEmpty);
    } else {
      getStorage.write('error', 'empty-fields');
      Logger().d("In the empty error");
      showDialogBox("Empty field", "Fields Cannot be empty");
      isSuccessed.value = false;
    }
  }
}
