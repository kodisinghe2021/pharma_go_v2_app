import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/alert_boxes/get_alert.dart';

class OCRProvider {
  late InputImage inputImage;
  late RecognizedText recognizedText;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

//* text recognising function
  Future<List<String>> getRecognizedText(File imageFile) async {
    List<String> scannedText = [];

    Logger().i("Inside getRecognisedText");
    //check image file is Not empty?
    if (imageFile.path.isNotEmpty) {
      Logger().i(imageFile.path);

      try {
        // make InputImage type variable
        inputImage = InputImage.fromFile(imageFile);

        Logger().i(inputImage.filePath);

        //extract text from image
        recognizedText = await textRecognizer.processImage(inputImage);

        // devide text object into words
        for (TextBlock block in recognizedText.blocks) {

          for (TextLine line in block.lines) {
        

            for (TextElement element in line.elements) {
              scannedText.add(element.text);
              // Logger().i(element.text);
            }
          }
        }
        textRecognizer.close();
        return scannedText;
      } catch (e) {
        textRecognizer.close();
        Logger().e("Error reading \n$e");
      }
      return scannedText;
    } else {
      showDialogBox("Error", "please select the image first");
      return scannedText;
    }
  }
  
// divide array into three sub arrays
  List<List<String>> _dividingAlgo(List<String> textList) {
    List<List<String>> subArrays = [];
    for (int i = 0; i < textList.length; i += 3) {
      subArrays.add(textList.sublist(i, i + 3));
    }
    return subArrays;
  }

// map arrays
  Future<List<Map<String, String>>> mapNoteData(List<String> textList) async {
    List<List<String>> subArrays = _dividingAlgo(textList);
    List<Map<String, String>> mapList = [];
    for (var i = 0; i < subArrays.length; i++) {
      Map<String, String> map = {};
      map['name'] = subArrays[i][0];
      map['dosage'] = subArrays[i][1];
      map['days'] = subArrays[i][2];
      mapList.insert(0, map);
    }
    return mapList;
  }
}
