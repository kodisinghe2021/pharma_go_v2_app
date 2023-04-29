import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_go_v2_app/routes/navigator/navigator.dart';

class HomeController extends GetxController {
  var textScanning = false.obs;

  XFile? imageFile;

  var scannedText = ''.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  GetStorage _storage = GetStorage();

  Future<void> getImage(ImageSource imageSource) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: imageSource);
      if (pickedImage != null) {
        textScanning.value = true;
        imageFile = pickedImage;
        //  getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning.value = false;
      imageFile = null;
      scannedText.value = "error text";
    }
  }

  Future<void> getRecognisedText(XFile? imageFile) async {
    try {
      //^ get image from the file using file path
    //  final inputImage = InputImage.fromFilePath(imageFile!.path);

      //^ make RecognizedText object
    //  final textDetector = GoogleMlKit.vision.textRecognizer();
      //^ get text block as RecognizedText
      // RecognizedText recognizedText =
      //     await textDetector.processImage(inputImage);

      //^ close detector and clear scannedText variable
   //   await textDetector.close();
      scannedText.value = "";

      //^read lines from blocks
      // for (TextBlock block in recognizedText.blocks) {
      //   for (TextLine line in block.lines) {
      //     scannedText.value = "$scannedText${line.text}\n";
      //   }
      // }

      textScanning.value = false;
    } catch (e) {
      scannedText.value = "Not Readable";
      textScanning.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _storage.erase();
    navigatorLogging();
  }
}
