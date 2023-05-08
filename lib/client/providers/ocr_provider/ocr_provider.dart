import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/client/data/medicine_note_mockup.dart';
import 'package:pharma_go_v2_app/client/presentation/widgets/alert_boxes/get_alert.dart';

class OCRProvider {
  late InputImage inputImage;
  late RecognizedText recognizedText;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

//* text recognising function
  Future<List<String>> getRecognizedText(File imageFile) async {
    List<String> scannedText = [];

    Logger().i("Inside getRecognisedText");
    if (imageFile.path.isNotEmpty) {
      Logger().i(imageFile.path);
      try {
        inputImage = InputImage.fromFile(imageFile);
        Logger().i(inputImage.filePath);

        //   Logger().i("inside try catch");
        recognizedText = await textRecognizer.processImage(inputImage);
        // Logger().i(
        //     "image readed -length of blocks - ${recognizedText.blocks.length}");
        for (TextBlock block in recognizedText.blocks) {
          // Logger().i(block.text);
          for (TextLine line in block.lines) {
            // Logger().i(line.text);

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

//! this data import by mockup data until OCR replace
  Future<List<Map<String, String>>> getMeidcineList(List<String> text) async {
    // String text = await getRecognizedText(imageFile);
    if (text.isEmpty) {
      showDialogBox('Reader Error', 'the medicine note cannot read');
      return [];
    }
    //! this note will be text ...... ^
    List<String> note = MedicineNoteMockupData().note_03;
    List<Map<String, String>> noteList = [];
    for (var element in note) {
      Map<String, String> map = {};
      map.putIfAbsent('name', () => element.split(' ')[0]);
      map.putIfAbsent('dosage', () => element.split(' ')[1]);
      map.putIfAbsent('days', () => element.split(' ')[2]);
      noteList.insert(0, map);
    }
    // Logger().i(noteList[0]['name']);
    // Logger().i(noteList[1]['name']);6
    // Logger().i(noteList[2]['name']);
    return noteList;
  }

// divide array into three sub arrays
  List<List<String>> dividingAlgo(List<String> textList) {
    List<List<String>> subArrays = [];
    for (int i = 0; i < textList.length; i += 3) {
      subArrays.add(textList.sublist(i, i + 3));
    }
    return subArrays;
  }

// map arrays
  Future<List<Map<String, String>>> mapNoteData(List<String> textList) async {
    List<List<String>> subArrays = dividingAlgo(textList);
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
