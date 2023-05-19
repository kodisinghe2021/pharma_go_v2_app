import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/data/object_keeper.dart';
import 'package:pharma_go_v2_app/dependencies/firebase_instance.dart';
import 'package:pharma_go_v2_app/models/pharmacy/phama_model.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class PharmaLoginController extends GetxController {
//*----------------------instanse
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();

  // get local stoarage.
  final _localStorage = GetStorage();

//*-----------------------controllcers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

//*----------------------observable values
  var isSuccessed = false.obs;
  var isLoading = false.obs;
  var isObsecure = true.obs;

//&----------------------functions---------------------------------
  //--- fields validation
  bool fieldValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //--- sing in function
  Future<void> login() async {
    //make shuwer the inputs are valid or not
    if (!fieldValidation()) {
      showDialogBox('Field are empty', 'All fields must be filled');
      return;
    }
    //--- signin user
    try {
      // Logger().i("inside try");
      // sign in and store value in credintial.
      UserCredential credential =
          await _backEndSupport.auth().signInWithEmailAndPassword(
                email: email.text.trim(),
                password: password.text.trim(),
              );
      // if the credintial is empty then return
      if (credential.user!.uid.isEmpty) {
        showDialogBox('Login error', 'Somthing went wrong');
        return;
      }

      //--- insert local data
      await _localStorage.write('uID', credential.user!.uid);
      // await _localStorage.write('email', credential.user!.email.toString());
      await _localStorage.write('userIS', 'pharma');

      //--- set current user
      await getCurrentPharmacyDetails(credential.user!.uid);

      //--- navigate to Main
      Get.offAllNamed(Routes.PHARMANAVBAR);

      //--- on error
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;

      //--- show error dialog
      showDialogBox("Error", e.code);
    }
  }

  //--- get user data and create current user model
  Future<void> getCurrentPharmacyDetails(String userID) async {
    // set path to document.
    DocumentReference docRef = _backEndSupport
        .noSQLStorage()
        .collection('pharmacy-collection')
        .doc(userID);

    //--- get the current document.
    DocumentSnapshot snapshot = await docRef.get();

    //-- set map.
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

    //--- initialize user model.
    PharmaModel model = PharmaModel.fromJson(map);

    //--- set current user object.
    setCurrentPharmaModel(model);
  }
}
