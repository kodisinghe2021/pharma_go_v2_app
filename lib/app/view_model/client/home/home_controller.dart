import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view_model/client/home/data/backenda_data_retriever.dart';
import 'package:pharma_go_v2_app/supports/providers/client/ocr_provider/ocr_provider.dart';
import 'package:pharma_go_v2_app/supports/services/firebase_instance.dart';

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
  List<Map<String, String>> textMapList = [];

  FlipCardController flipCardController = FlipCardController();
  //create text recognisor

//* others ------------------------------//
  CardSide currentCardSide = CardSide.FRONT;
//&----------------------functions---------------------------------

//   Future<void> readNote() async {
//     scannedText = await OCRProvider().getRecognizedText(imageFile);
//   }
//& 1---------------------------------
  //---------- pick image from gallery or camera.
  Future<void> setImageFilePath(ImageSource imageSource) async {
    Logger().i('setImageFilePath(ImageSource imageSource)');
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
    //convert to map
    textMapList = await _ocrProvider.mapNoteData(textList);

    //if converting succes then visibility on
    if (textMapList.isNotEmpty) {
      isTextExtracted.value = true;
    }
  }

//& 3---------------------------------
  Future<List<Map<String, dynamic>>> setData() async {
    // this id is the id of the medicine. according to the medicine id.
    // if the medicine note is not readed then exit with null list.
    if (textMapList.isEmpty) {
      showDialogBox('Text not identified', 'message');
      return [];
    }
    //create mepty list for store medicine id's.
    List<Map<String, dynamic>> medicineAllData = [];

    // make medicine id list
    for (var element in textMapList) {
      //   Logger().i("element list ${element['name']}");

      // if medicine name is null then return.
      if (element['name'] == null) {
        return [];
      }

      // get the medicine name and find it is available or not

      Map<String, dynamic> medicineIdWithDosage =
          await getMedicine(element['name'] ?? '');

      // String medid = medicineIdWithDosage['medId'];
      // String dosageFromMeidcine = medicineIdWithDosage['dosage_in_medicine'];

      if (medicineIdWithDosage['medId'].isNotEmpty) {
        medicineAllData.insert(0, {
          'name': element['name'],
          'frequency': element['frequency'],
          'days': element['days'],
          'dosage_in_note': element['dosage_in_note'],
          'id': medicineIdWithDosage['medId'],
          'dosage_in_medicine': medicineIdWithDosage['dosage_in_medicine'],
        });
      }
    }

    // Logger().i("medicine list setted - $medicineIDList");

    List<Map<String, dynamic>> dataList =
        await _retrieveHelper.getPriceListWithMedicineID(
      medicineAllData: medicineAllData,
    );

    return dataList;
  }

//& 4---------------------------------
// make meidcine id list
  Future<Map<String, dynamic>> getMedicine(String medicineName) async {
    //make empty list for store data.
    Map<String, dynamic> medicineIdName = {};

    //make refference
    CollectionReference ref =
        _backEndSupport.noSQLStorage().collection('medicine-collection');

    try {
      // get snapshot
      QuerySnapshot snapshot =
          await ref.where('name', isEqualTo: medicineName).get();

      // maek as doc list.
      List<QueryDocumentSnapshot> docList = snapshot.docs;

      // get medicine dosage
      Map<String, dynamic> medicineDat =
          docList.first.data() as Map<String, dynamic>;
      String dosage = medicineDat['dossage'];
      // doc list have only one value.
      String medicineID = docList.first.id;
      // Logger().i("medicine id is catched $medicineID");
      medicineIdName.putIfAbsent('medId', () => medicineID);
      medicineIdName.putIfAbsent('dosage_in_medicine', () => dosage);

      return medicineIdName;
    } catch (e) {
      return medicineIdName;
    }
  }

//& 3---------------------------------
//get current date
  Map<String, dynamic> getDateTime() {
    Map<String, dynamic> dateTimeMap = {};
    currentDateTime = DateTime.now();
    dateTimeMap = {
      'y': currentDateTime.year,
      'm': currentDateTime.month,
      'd': currentDateTime.day,
      'h': currentDateTime.hour,
      'mn': currentDateTime.minute,
      's': currentDateTime.second,
    };
    return dateTimeMap;
  }

}
