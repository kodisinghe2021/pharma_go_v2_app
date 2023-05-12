import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/client/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';
import 'package:pharma_go_v2_app/routes/navigator/navigator.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final UserCredential _userCredential;
  final GetStorage getStorage = GetStorage();

  Location location = Location();
  var serviceEnabled = false.obs;
  var locationSetted = false.obs;
  late final PermissionStatus permissionGranted;
  late final LocationData currentPossision;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isSuccessed = false.obs;
  var isLoading = false.obs;
  var isObsecure = true.obs;
  var isLocationLoading = false.obs;
  var isLocationSetted = false.obs;
  var isButtonVisible = false.obs;

  //* textediting controllers
  TextEditingController pharmacyName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController registrationNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //* map of location data
  Map<String, String> locationData = {};

  Future<void> signInWithFirebase() async {
    isSuccessed.value = false;
    isLoading.value = true;
    Logger().i("Email-${email.text} Passward-${password.text}");
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Logger().i("User Signin success");
      isLoading.value = false;
      isSuccessed.value = true;
      await getStorage.write('uID', _userCredential.user!.uid);
      await getStorage.write('email', _userCredential.user!.email);
      await getStorage.write('userIS', 'client');
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
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
//~`````````````````````````````Location genarator```````````````````````````````````````

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

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//* Sign in user
  Future<bool> createUser() async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await getStorage.write('uID', _userCredential.user!.uid);
      await getStorage.write('email', _userCredential.user!.email);
      Logger().i("user created successfully");
      return true;
    } on FirebaseAuthException catch (e) {
      showDialogBox("Error", e.code);
      Logger().e(e.code);
      return false;
    }
  }

//* add user to fire Store
  Future<void> addUser() async {
    bool isSigninSuccess = false;
    if (pharmacyName.text.isNotEmpty &&
        contact.text.isNotEmpty &&
        locationData.isNotEmpty &&
        registrationNumber.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty) {
      isSigninSuccess = await createUser();

      if (isSigninSuccess) {
        try {
          await _firestore
              .collection('pharmacy-collection')
              .doc(_userCredential.user!.uid)
              .set({
            'id': _userCredential.user!.uid,
            'pharmacy-name': pharmacyName.text,
            'contact': contact.text,
            'registration-number': registrationNumber.text,
            'availability-map': {},
            'location': locationData,
            'email': email.text,
            'password': password.text,
          });
          Logger().i("user added successfully");

          Get.offAllNamed(Routes.LOGIN);
        } on FirebaseException catch (e) {
          showDialogBox("Somthing wrong", e.code);
          Logger().e(e.code);
        }
      }
    } else {
      showDialogBox("Empty fields", 'Fields cannot be empty.');
    }
  }
}
