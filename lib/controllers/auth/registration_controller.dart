import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/routes/navigator/navigator.dart';
import 'package:geocoding/geocoding.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final UserCredential _userCredential;
  final GetStorage getStorage = GetStorage();

  // Location location = Location();
  // var serviceEnabled = false.obs;
  // late final PermissionStatus permissionGranted;
  // late final LocationData currentPossision;
  late LocationSettings locationSettings;
  late Position positionData;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isSuccessed = false.obs;
  var isLoading = false.obs;
  var isObsecure = true.obs;
  var isAddressContainerVisible = true.obs;
  var isLocationLoading = false.obs;

  //* textediting controllers
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController nic = TextEditingController();
  TextEditingController adNumber = TextEditingController();
  TextEditingController adStreet = TextEditingController();
  TextEditingController adCity = TextEditingController();
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
//~`````````````````````````````Location genarator```````````````````````````````````````

  // Future<void> getLocation() async {
  //   serviceEnabled.value = await location.serviceEnabled();
  //   if (!serviceEnabled.value) {
  //     serviceEnabled.value = await location.requestService();
  //     if (!serviceEnabled.value) {
  //       return;
  //     }
  //   }
  //   Logger().i("service Enabled");
  //   permissionGranted = await location.hasPermission();
  //   Logger().i(
  //       "permission granted ${permissionGranted == PermissionStatus.granted}");
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   Logger().i("Location access granted");
  //   currentPossision = await location.getLocation();
  //   latitude.value = currentPossision.latitude!.toDouble();
  //   longitude.value = currentPossision.longitude!.toDouble();
  //   Logger().i("Latitiude - ${currentPossision.latitude!.toDouble()}");
  // }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  ///

//& get location details using geolocator
  Future<void> getLocationdetails() async {
    positionData = await _determinePosition();
    latitude.value = positionData.latitude;
    longitude.value = positionData.longitude;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  // Future<void> geoLocationAll() async {
  //   if (defaultTargetPlatform == TargetPlatform.android) {
  //     locationSettings = AndroidSettings(
  //         accuracy: LocationAccuracy.high,
  //         distanceFilter: 100,
  //         forceLocationManager: true,
  //         intervalDuration: const Duration(seconds: 10),
  //         //(Optional) Set foreground notification config to keep the app alive
  //         //when going to the background
  //         foregroundNotificationConfig: const ForegroundNotificationConfig(
  //           notificationText:
  //               "Example app will continue to receive your location even when you aren't using it",
  //           notificationTitle: "Running in Background",
  //           enableWakeLock: true,
  //         ));
  //   } else if (defaultTargetPlatform == TargetPlatform.android ||
  //       defaultTargetPlatform == TargetPlatform.windows) {
  //     locationSettings = AppleSettings(
  //       accuracy: LocationAccuracy.high,
  //       activityType: ActivityType.fitness,
  //       distanceFilter: 100,
  //       pauseLocationUpdatesAutomatically: true,
  //       // Only set to true if our app will be started up in the background.
  //       showBackgroundLocationIndicator: false,
  //     );
  //   } else {
  //     locationSettings = const LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 100,
  //     );
  //   }

  //   StreamSubscription<Position> positionStream =
  //       Geolocator.getPositionStream(locationSettings: locationSettings)
  //           .listen((Position? position) {
  //     Logger().i(
  //       position == null
  //           ? 'Unknown'
  //           : '${position.latitude.toString()}, ${position.longitude.toString()}',
  //     );
  //   });
  // }

  Future<void> getAddress() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude.value, longitude.value);
    Logger().i(placemarks);
  }

  Future<void> getCoordinate(String address) async {
    List<Location> locations = await locationFromAddress(address);
  }
}
