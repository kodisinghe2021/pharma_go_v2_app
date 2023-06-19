import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/model/client/extracted_char/extracted_char.dart';
import 'package:pharma_go_v2_app/app/view_model/client/tabbar_tabs/home/controller/backenda_data_retriever.dart';
import 'package:pharma_go_v2_app/supports/providers/client/characters_object/char_obj_list.dart';
import 'package:pharma_go_v2_app/supports/providers/client/ocr_provider/ocr_provider.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

class HomeController extends GetxController {
//*----------------------instanse
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();

  // get local stoarage.
  final _localStorage = GetStorage();

  // image reader
  final OCRProvider _ocrProvider = OCRProvider();

  // data Retriver
  final RetrieveHelper _retrieveHelper = RetrieveHelper();

  // object list provider
  // final CharObjListProvider _charObjListProvider = CharObjListProvider();

//*-----------------------controllcers

//*----------------------observable values
  //image searching
  var searchCompleted = false.obs;

  // set file path
  var imageFilePath = ''.obs;

  //image container and selecting button visibility
  var visibilityO = false.obs;

  //reading text in OCR
  var isReading = false.obs;

  //text extracted
  var isTextExtracted = false.obs;
  // find pharmacy button is clicked
  var isPharmacyOpen = false.obs;

  var readingText = false.obs;

//*--------------------------------- late objects

  late DateTime currentDateTime;
//*---------------------------- refference variables
  File imageFile = File('');
  // List<ExtractedCharModel> extractedCharObjectList =
  //     CharObjListProvider().getObjectList;

  FlipCardController flipCardController = FlipCardController();
  //create text recognisor

//* others ------------------------------//
  CardSide currentCardSide = CardSide.FRONT;
//&----------------------functions---------------------------------
//###
  // List<ExtractedCharModel> extractedCharObjectList() =>
  //     _charObjListProvider.getObjectList;
//& 1---------------------------------
  //---------- pick image from gallery or camera.
  Future<void> setImageFilePath(ImageSource imageSource) async {
    List<String> scannedText = [];

    try {
      // await for picking image...............
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: imageSource);

      //check image file is empty or not.
      if (pickedImage != null) {
        //initilize File object
        imageFile = File(pickedImage.path);
        imageFilePath.value = imageFile.path;
        visibilityO.value = true;

        Logger().i("path is -- ${imageFilePath.value}");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

//& 2---------------------------------
//extract text from OCR
  Future<void> extractTextFromImage() async {
    //read and get text list.
    List<String> textList = await _ocrProvider.getRecognizedText(imageFile);
    Logger().i('length of text list------------  ${textList.length}');

    List<ExtractedCharModel> charModelList =
        await _ocrProvider.mapNoteData(textList);

    setObjectList(charModelList);

    //if converting succes then visibility on
    if (charModelList.isNotEmpty) {
      isTextExtracted.value = true;
    }
  }

  List<ExtractedCharModel> extractedCharObjectList() => getObjectList;
}
