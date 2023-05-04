import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:pharma_go_v2_app/data/medicine_note_mockup.dart';
import 'package:pharma_go_v2_app/models/medicine_model.dart';
import 'package:pharma_go_v2_app/presentation/widgets/alert_boxes/get_alert.dart';

class HomeController extends GetxController {
//? propeties ----------------------------------------------------//
//* firebase instance
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _getStorage = GetStorage();
//* observable values --------------------//
  var textScanning = false.obs;
  var filePath = ''.obs;
  var scannedText = ''.obs;
  var text = 'text'.obs;
  var imageDonloadURL = ''.obs;
  var isFinding = false.obs;
  List<String> medicineIDList = <String>[];
  Map<String, String> medicineListMap = {};
  Map<String, dynamic> medicineNote = {};

//* late objects -------------------------//
  late InputImage inputImage;
  late RecognizedText recognizedText;

//* refference variables -----------------//
  File imageFile = File('');
  FlipCardController flipCardController = FlipCardController();
  //create text recognisor
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

//* others ------------------------------//
  CardSide currentCardSide = CardSide.FRONT;

//? functions ----------------------------------------------------//
//* text recognising function
  Future<void> getRecognizedText() async {
    Logger().i("Inside getRecognisedText");
    if (imageFile.path.isNotEmpty) {
      try {
        inputImage = InputImage.fromFile(imageFile);

        Logger().i("inside try catch");
        recognizedText = await textRecognizer.processImage(inputImage);
        Logger().i(
            "image readed -length of blocks - ${recognizedText.blocks.length}");
        for (TextBlock block in recognizedText.blocks) {
          Logger().i(block.text);
          for (TextLine line in block.lines) {
            Logger().i(line.text);
            // Same getters as TextBlock
            for (TextElement element in line.elements) {
              scannedText.value = "${scannedText.value} ${element.text}\n ";
              Logger().i(element.text);
              // Same getters as TextBlock
            }
          }
        }
        textRecognizer.close();
      } catch (e) {
        textRecognizer.close();
        Logger().e("Error reading \n$e");
      }
    } else {
      showDialogBox("Error", "please select the image first");
    }
  }

//* get image from files or camera
  Future<void> getImage(ImageSource imageSource) async {
    scannedText.value = '';
    Logger().i("inside getImage");
    try {
      Logger().i("inside try");
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: imageSource);
      if (pickedImage != null) {
        // pickedImageXFile = pickedImage;
        filePath.value = pickedImage.path;
        imageFile = File(pickedImage.path);
        Logger().i("image picked - ${pickedImage.path}");
        update();
      }
    } catch (e) {
      Logger().e(e);
      textScanning.value = false;
      scannedText.value = "error text";
    }
  }

//* flipping image
  Future<void> flip() async {
    flipCardController.toggleCard();
  }

//* upload image to firebase
  Future<String> uploadImage() async {
    if (filePath.isNotEmpty) {
      try {
        // Points to the root reference
        final storageRef = storage.ref();

//extract the file name from the path
        String fileName = basename(filePath.value);

// Points to "images"
        Reference? imagesRef = storageRef.child("medicine-note/$fileName");

        UploadTask? task = imagesRef.putFile(imageFile);

        final snapshot = await task.whenComplete(
          () => Logger().i('Image uploaded'),
        );
        imageDonloadURL.value = await snapshot.ref.getDownloadURL();
        Logger().i("successfully upload image ${imageDonloadURL.value}");
        return imageDonloadURL.value;
      } catch (e) {
        Logger().e(e);
        return '';
      }
    } else {
      Logger().e("file empty");
      return '';
    }
  }

//* create the object of the medicine
//! this data import by mockup data until OCR replace
  void createMedicineModels(String id) {
    List<String> note = MedicineNoteMockupData().note_01;

    MedicineModel model = MedicineModel(
      id: id,
      medicineName: '',
      dosage: 'dosage',
    );
  }

//* save medicine data in firebase firestore
  Future<void> saveMedicineData() async {
    await uploadImage();

    if (imageDonloadURL.isNotEmpty) {
      try {
        CollectionReference reference = _firestore.collection('medisine_notes');
        String docID = reference.doc().id;
        reference.doc(docID).set({});
      } catch (e) {}
    } else {}
  }

//* get current date and time
  List<String> getCurrentDate() {
    List<String> currentTime = [];
    final DateTime now = DateTime.now();

    final String formattedDate = '${now.month}/${now.day}/${now.year}';

    final String formattedTime = '${now.hour}:${now.minute}';

    currentTime.insert(0, formattedDate);
    currentTime.insert(1, formattedTime);

    return currentTime;
  }

//* update history data list inside the user
  Future<void> updateUserHistory() async {
    CollectionReference collectionReference = _firestore
        .collection('user-collection')
        .doc(_getStorage.read('uID'))
        .collection('medicine-history');
    collectionReference.doc(_getStorage.read('uID'));
  }

  //* add medicine
//! this data import by mockup data until OCR replace
  Future<String> addMedicine({
    required String name,
    required String dosage,
  }) async {
    Logger().i("inside add medicine");
    try {
      CollectionReference reference =
          _firestore.collection('medicine-collection');
      String medicineID = reference.doc().id;
      Logger().i(medicineID);
      await reference.doc(medicineID).set({
        'id': medicineID,
        'name': name,
        'brand': 'unknown',
        'dosage': dosage,
      });
      return medicineID;
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return '';
    }
  }

//* add medicine note data to history collection
  Future<void> addHistoryData() async {
    String date = getCurrentDate()[0];
    String time = getCurrentDate()[1];
    Logger().i("Data Time fixed: $date - $time");
    try {
      CollectionReference historyCollection =
          _firestore.collection('history-collection');

      historyCollection.where({'name'}, isEqualTo: "domperidon").get();

      final String docID = historyCollection.doc().id;
      await historyCollection.doc(docID).set({
        'id': docID,
        'date': date,
        'time': time,
        'pharmacyID': "0012132324",
        'total-price': 244.2,
      });
    } on FirebaseException catch (e) {
      Logger().e(e.code);
    }
  }

//*find medicine
  Future<String> findMedicine({
    required String name,
    required String dosage,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('medicine-collection')
          .where('name', isEqualTo: name)
          .get();
      Logger().i(snapshot.docs.length);
      if (snapshot.size != 0) {
        Logger().i(snapshot.docs.asMap()[0]!['id']);
        return snapshot.docs.asMap()[0]!['id'];
      } else {
        return addMedicine(name: name, dosage: dosage);
      }
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return '';
    }
  }

//* find all of data in the note and store medicine id's
  Future<Map<String, dynamic>> findAllMedicineId(
    List<Map<String, String>> medicineList,
  ) async {
    medicineIDList = [];
    medicineListMap = {};
    int index = 0;

    try {
      for (var medicinemap in medicineList) {
        String name = medicinemap['name'].toString();
        String dosage = medicinemap['dosage'].toString();
        String days = medicinemap['days'].toString();
        Logger().i("name: $name - dosage: $dosage");
        if (name.isEmpty || dosage.isEmpty) {
          continue;
        }
        String mID = await findMedicine(
          name: name,
          dosage: dosage,
        );
        Logger().i('mID is catched $mID');
        //& insert list
        medicineIDList.insert(
          index,
          mID,
        );
        //& create map with days
        medicineListMap.putIfAbsent(mID, () => days);
        index += 1;
      }
      Logger().i("List length: ${medicineIDList.length}");
      Logger().i("List length: ${medicineListMap.length}");
      return medicineListMap;
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return {};
    }
  }

  List<Widget> medList() {
    List<Widget> textList = [];
    for (var element in medicineIDList) {
      textList.add(Text(element));
    }
    return textList;
  }

  //* create medicine note
  Future<void> createMedicineNote(
    List<Map<String, String>> medicineList,
  ) async {
    CollectionReference collection =
        _firestore.collection('history-collection');
    try {
      Logger().i("inside try - createMedicineNote()");
      String imgUrl = await uploadImage();
      Logger().i("after uploading image --> createMedicineNote()");

      Map<String, dynamic> medMap = await findAllMedicineId(medicineList);
      Logger().i('medicine list found. map length - ${medMap.length}');

      List<String> currentTime = getCurrentDate();
      if (imageDonloadURL.isNotEmpty && medMap.isNotEmpty) {
        Logger().i(
            "inside condition --> ${imageDonloadURL.isNotEmpty} ${medMap.isNotEmpty}");
        String docID = collection.doc().id;
        await collection.doc(docID).set({
          'id': docID,
          'date': currentTime[0],
          'time': currentTime[1],
          'medicine-map': medMap,
        });
        Logger().i("uploaded");
        showDialogBox('Success', 'Added history successfully');
      } else {
        return;
      }
    } catch (e) {
      showDialogBox("Error", e.toString());
    }
  }
}
