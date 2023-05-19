import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/dependencies/firebase_instance.dart';
import 'package:pharma_go_v2_app/models/pharmacy/phama_model.dart';
import 'package:pharma_go_v2_app/models/pharmacy/pharma_model_to_map.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class PharmaRegistrationController extends GetxController {
//*----------------------instanse
  //--- backend supports
  final BackEndSupport _backEndSupport = BackEndSupport();

  //--- local Storage
  final _localStorage = GetStorage();

  // //--- user credintial access
  // final UserCredintailProvider _userCredintailProvider =
  //     UserCredintailProvider();

  //--- location
  Location location = Location();

//*-----------------------controllcers
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController registrationID = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

//*----------------------observable values
  var serviceEnabled = false.obs;
  var locationSetted = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isSuccessed = false.obs;
  var isLoading = false.obs;
  var isObsecure = true.obs;
  var isLocationLoading = false.obs;
  var isLocationSetted = false.obs;
  var isButtonVisible = false.obs;

//*----------------- late inizilising objects
  late final PermissionStatus permissionGranted;
  late final LocationData currentPossision;

//*------------------------ globle variables
  Map<String, String> locationData = {};

//&----------------------functions-------------------------------------------
//--- validation
  bool fieldValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

//--- location genarater
  Future<void> getLocation() async {
    serviceEnabled.value = await location.serviceEnabled();
    if (!serviceEnabled.value) {
      serviceEnabled.value = await location.requestService();
      if (!serviceEnabled.value) {
        return;
      }
    }
    Logger().i("service Enabled");
    permissionGranted = await location.hasPermission();
    Logger().i(
        "permission granted ${permissionGranted == PermissionStatus.granted}");
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    Logger().i("Location access granted");
    currentPossision = await location.getLocation();
    latitude.value = currentPossision.latitude!.toDouble();
    longitude.value = currentPossision.longitude!.toDouble();
    isLocationSetted.value = true;
    //* set data to map
    locationData = {
      'latitude': latitude.value.toString(),
      'longitude': longitude.value.toString(),
    };
    Logger().i("Latitiude - ${currentPossision.latitude!.toDouble()}");
  }

//--- create user and get creadintial
  Future<bool> createPharma() async {
    try {
      // create user and initialize values
      UserCredential userCredential =
          await _backEndSupport.auth().createUserWithEmailAndPassword(
                email: email.text,
                password: password.text,
              );

      await _localStorage.write('uID', userCredential.user!.uid);
      // await _localStorage.write('email', userCredential.user!.email.toString());
      await _localStorage.write('userIS', 'pharma');

      Logger()
          .i("user created successfully ID -- ${_localStorage.read('uID')}");
      return true;
    } on FirebaseAuthException catch (e) {
      showDialogBox("Error", e.code);
      Logger().e(e.code);
      return false;
    }
  }

//--- field validator
  bool isFieldsValid() {
    if (name.text.isNotEmpty &&
        contact.text.isNotEmpty &&
        locationData.isNotEmpty &&
        registrationID.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //--- add user data
  Future<void> addUser() async {
    // check field is valid.
    if (!isFieldsValid()) {
      showDialogBox("Empty fields", 'Fields cannot be empty.');
      return;
    }

    //--- create user and get creadintail.
    bool isSuccess = await createPharma();

    //--- get user ID
    String pharmacyID = _localStorage.read('uID');

    //-- if user creating is unsuccessful then return
    if (!isSuccess || pharmacyID.isEmpty) {
      showDialogBox('Plaease try again', 'Somthing went wrong');
      return;
    }

    // if all valid then add user data
    try {
      //create refference to the database
      CollectionReference ref =
          _backEndSupport.noSQLStorage().collection('pharmacy-collection');

      // add document id to the refference *id is same as credintial id
      DocumentReference docRef = ref.doc(pharmacyID);

      // create user model
      PharmaModel model = PharmaModel(
        pharmaID: pharmacyID,
        name: name.text,
        locationMap: locationData,
        contact: contact.text,
        registrationID: registrationID.text,
        email: email.text,
      );

      Map<String, dynamic> map = ToUPharmacyMap().toJson(model);

      // set data to the path
      await docRef.set(map);

      Logger().i("user added successfully");
      showDialogBox(
          "Successfull", "Congratulations you are added to our client base. ");

      Get.offAllNamed(Routes.PHARMALOGIN);
    } on FirebaseException catch (e) {
      showDialogBox("Somthing wrong", e.code);
      Logger().e(e.code);
    }
  }
}
