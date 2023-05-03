import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/presentation/widgets/alert_boxes/get_alert.dart';

class HomeController extends GetxController {
  var textScanning = false.obs;
  var filePath = ''.obs;
  File imageFile = File('');
  FlipCardController flipCardController = FlipCardController();
  CardSide currentCardSide = CardSide.FRONT;

  var scannedText = ''.obs;
  var text = 'text'.obs;
//* create instance for Input image
  late InputImage inputImage;
  late RecognizedText recognizedText;
//* create text recognisor
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

//* text recognism function
  Future<void> getRecognisedText() async {
    Logger().i("Inside getRecognisedText");
    if (imageFile.path.isNotEmpty) {
      try {
        inputImage = InputImage.fromFile(imageFile);

        Logger().i("inside try catch");
        recognizedText = await textRecognizer.processImage(inputImage);
        //String text = recognizedText.text;
        Logger().i(
            "image readed -length of blocks - ${recognizedText.blocks.length}");
        for (TextBlock block in recognizedText.blocks) {
          // final Rect rect = block.boundingBox;
          // final List<Point<int>> cornerPoints = block.cornerPoints;
          // final String text = block.text;
          // final List<String> languages = block.recognizedLanguages;

          for (TextLine line in block.lines) {
            // Same getters as TextBlock
            for (TextElement element in line.elements) {
              scannedText.value = "${scannedText.value} ${element.text}";
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
        //  getRecognisedText(pickedImage);
      }
    } catch (e) {
      Logger().e(e);
      textScanning.value = false;
      // pickedImageXFile = null;
      scannedText.value = "error text";
    }
  }

  Future<void> flip() async {
    flipCardController.toggleCard();
  }
}
