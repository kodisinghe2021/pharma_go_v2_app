import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:pharma_go_v2_app/data/medicine_note_mockup.dart';
import 'package:pharma_go_v2_app/models/medicine_note.dart';
import 'package:pharma_go_v2_app/presentation/widgets/alert_boxes/get_alert.dart';

class HomeController extends GetxController {
//? propeties ----------------------------------------------------//
//* firebase instance
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//* observable values --------------------//
  var textScanning = false.obs;
  var filePath = ''.obs;
  var scannedText = ''.obs;
  var text = 'text'.obs;
  var imageDonloadURL = ''.obs;

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
  Future<void> uploadImage() async {
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
      } catch (e) {
        Logger().e(e);
      }
    } else {
      Logger().e("file empty");
    }
  }

//* create the object of the medicine
//! this data import by mockup data until OCR replace
  void createMedicineModel(String id) {
    List<String> note = MedicineNoteMockupData().note_01;
  
   MedicineModel model = MedicineModel(
        id: id,
        medicineName: '',
        dosage: 'dosage',
        usingDays: 'usingDays',
        imageURL: 'imageURL',);
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


  
}
