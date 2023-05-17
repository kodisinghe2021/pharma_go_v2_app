import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/client/providers/ocr_provider/ocr_provider.dart';
import 'package:pharma_go_v2_app/app/client/providers/time_provider/time_provider.dart';

class HomeController extends GetxController {
//? propeties ----------------------------------------------------//
//* firebase instance
  final FirebaseStorage _firebaseCloudStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _getStorage = GetStorage();
  List<Map<String, String>> medicineNoteText = [];
//* observable values --------------------//
  var textScanning = false.obs;
  var searching = false.obs;
  var searchCompleted = false.obs;
  List<String> scannedText = [];
  // var text = 'text'.obs;
  // var isFinding = false.obs;
  List<String> medicineIDList = <String>[];
  Map<String, String> medicineListMap = {};
  Map<String, dynamic> medicineNote = {};

//* late objects -------------------------//

//* refference variables -----------------//
  File imageFile = File('');
  var imagePath = ''.obs;

  FlipCardController flipCardController = FlipCardController();
  //create text recognisor

//* others ------------------------------//
  CardSide currentCardSide = CardSide.FRONT;

//? functions ----------------------------------------------------//

//!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
// this section continue with updating history-list in the user-collection
/* 1-a. To update the user-history list, we need, PKs of all histories. 
all PKs are available in history-collection. First, we need to add new 
history to the history collection to get new history PK.
1-b. After catching new history data we need to retrieve an exciting 
list of history in the user collection. then we insert new history into 
the retrieved list. then update the list in the user collection.
2. To save medicine history we need, DocID, date, time, and medicine note PK.
3. To create a medicine note we need, DocID, imageURL, and MedicineList. 
4. for getting the image URL we need to upload the image to Cloud storage 
and retrieve the download Link. 
4-a. For uploading images we need to capture or find images from the gallery.
5. To create a medicine list we need, medicine PK and dosage. dosage can be 
extracted from the note and 
for medicine PK, we need to match and find all medicine PKs. some can be available 
and some cannot be available. 
5-a. if the medicine is available get the id and save it with the dosage inside 
of the map. 5-b. if the medicine is not available then create new medicine with a name, 
id,  and dosage.

*/
//! read note
  Future<void> readNote() async {
    scannedText = await OCRProvider().getRecognizedText(imageFile);
  }

//~~~~~~~~~~~~~~~~~~``` image will select first
  Future<void> setImageFilePath(ImageSource imageSource) async {
    Logger().i('setImageFilePath(ImageSource imageSource)');
    scannedText = [];
    // Logger().i("inside getImage");
    try {
      // Logger().i("inside try");
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: imageSource);
      if (pickedImage != null) {
        imageFile = File(pickedImage.path);
        imagePath.value = imageFile.path;

        Logger().i("image picked - ${pickedImage.path}");
        update();
      }
    } catch (e) {
      // Logger().e(e);
      textScanning.value = false;
      scannedText = ["error text"];
    }
  }

//~ 1
  Future<void> updateUserHistoryList() async {
    Logger().i('updateUserHistoryList()');
    // check whether the image is selected or not
    // scannedText.value = await OCRProvider().getRecognizedText(imageFile);
    if (imageFile.path.isEmpty) {
      showDialogBox('plaese select image first',
          'for find medicine you need to select medicine note first');
      return;
    }
    //! check whether the readed text from OCR is available or not
    medicineNoteText = await OCRProvider().getMeidcineList(scannedText);
    if (medicineNoteText.isEmpty) {
      return;
    }
    // create history for getting id
    String historyID = await createHistory();
    if (historyID.isEmpty) {
      return;
    }
    List<dynamic>? historyList = await retrieveHistoryList();
    CollectionReference collection = _firestore.collection('user-collection');
    String uID = await _getStorage.read('uID');
    DocumentReference userDoc = collection.doc(uID);

//! this const need newly created history id
    historyList!.insert(0, historyID);

    await userDoc.update({'medicine-history': historyList});
    try {
      // Logger().i("update success");
    } on FirebaseException catch (e) {
      Logger().e(e.code);
    }
  }

// this is for updateing list of history ids
//~ 2
  Future<List<dynamic>?> retrieveHistoryList() async {
    Logger().i('retrieveHistoryList()');
    List<dynamic>? historyList = [];
    String uID = await _getStorage.read('uID');
    CollectionReference collection = _firestore.collection('user-collection');
    try {
      DocumentSnapshot snapshot = await collection.doc(uID).get();

      Map<String, dynamic> userDataMap =
          snapshot.data() as Map<String, dynamic>;
      // Logger().i("message");
      historyList = userDataMap['medicine-history'] as List<dynamic>;
      //  Logger().i("retrieveHistoryList ${historyList != null}");
      //  Logger().i(historyList.length);
      Logger().i('historyList - $historyList');
      return historyList;
    } on FirebaseException {
      //   Logger().e(e.code);
      return historyList;
    }
  }

//~ 3
  Future<String> createHistory() async {
    Logger().i("createHistory()");
    String date = TimeProvider().getCurrentDate()[0];
    String time = TimeProvider().getCurrentDate()[1];
    // Logger().i("Data Time fixed: $date - $time");
    try {
      String medicineNoteID = await createMedicineNote();
      if (medicineNoteID.isEmpty) {
        return '';
      }
      CollectionReference historyCollection =
          _firestore.collection('history-collection');

      // historyCollection.where({'name'}, isEqualTo: "domperidon").get();
      final String docID = historyCollection.doc().id;

      await historyCollection.doc(docID).set({
        'id': docID,
        'date': date,
        'time': time,
        'medicine-note-id': medicineNoteID,
      });
      Logger().i('history ID - $docID');
      return docID;
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return '';
    }
  }

//~ 5
  Future<String> createMedicineNote() async {
    Logger().i('createMedicineNote()');
    CollectionReference collection = _firestore.collection('note-collection');
    String uID = await _getStorage.read('uID');
    String docID = '';
    try {
      // Logger().i("inside try - createMedicineNote()");
      // this is for getting image url
      String imageDonloadURL = await getImageDownloadURL();
      // Logger().i("after uploading image --> createMedicineNote()");
      if (imageDonloadURL.isEmpty) {
        showDialogBox('image upload error', 'this file cannot upload');
        return '';
      }

      Map<String, dynamic> medMap = await createMedicineIDMap();
      // Logger().i('medicine list found. map length - ${medMap.length}');
      if (medMap.isEmpty) {
        showDialogBox('not available', 'All medicines are not available');
        return '';
      }
      List<String> currentTime = TimeProvider().getCurrentDate();
      if (imageDonloadURL.isNotEmpty && medMap.isNotEmpty) {
        // Logger().i(
        //     "inside condition --> ${imageDonloadURL.isNotEmpty} ${medMap.isNotEmpty}");
        docID = collection.doc().id;
        await collection.doc(docID).set({
          'id': docID,
          'userID': uID,
          'date': currentTime[0],
          'time': currentTime[1],
          'imageURL': imageDonloadURL,
          'medicine-map': medMap,
        });
        Logger().i("medicine note id - $docID");
        return docID;
      } else {
        return docID;
      }
    } catch (e) {
      showDialogBox("Error", e.toString());
      return docID;
    }
  }

//~ 6
  Future<String> getImageDownloadURL() async {
    Logger().i('getImageDownloadURL()');
    if (imageFile.path.isNotEmpty) {
      String imageDonloadURL = '';
      try {
        // Points to the root reference of the firebase cloud storage
        final Reference refference = _firebaseCloudStorage.ref();

        //extract the file name from the path
        String fileName = basename(imageFile.path);

        // Points to "images"
        Reference? imagesReference =
            refference.child("medicine-note/$fileName");

        UploadTask? task = imagesReference.putFile(imageFile);

        final snapshot = await task.whenComplete(
          () => Logger().i('Image uploaded'),
        );
        //get image download URL
        imageDonloadURL = await snapshot.ref.getDownloadURL();

        Logger().i("image download url - $imageDonloadURL");

        return imageDonloadURL;
      } catch (e) {
        Logger().e(e);
        return '';
      }
    } else {
      Logger().e("file empty");
      return '';
    }
  }

//~ 7
  Future<Map<String, dynamic>> createMedicineIDMap() async {
    Logger().i('createMedicineIDMap()');
    // medicineIDList = [];
    medicineListMap = {};
    // int index = 0;
    //! this medicine list is given by the OCR in the system

    List<Map<String, String>> listOfMaps = await OCRProvider().mapNoteData(
      await OCRProvider().getRecognizedText(imageFile),
    );
    try {
      // get the names of medicine from the given OCR extracting TextMap
      for (var map in listOfMaps) {
        String name = map['name'].toString().toLowerCase().trim();
        String dosage = map['dosage'].toString().trim();
        String days = map['days'].toString().trim();

        if (name.isEmpty || dosage.isEmpty) {
          continue;
        }
        String mID = await matchMedicine(
          name: name,
          dosage: dosage,
        );
        //& create map with days
        if (mID.isNotEmpty) {
          medicineListMap.putIfAbsent(mID, () => days);
        }
      }

      Logger().i("medicine list map - ${medicineListMap.length}");
      return medicineListMap;
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return {};
    }
  }

//~ 8
  Future<String> matchMedicine({
    required String name,
    required String dosage,
  }) async {
    Logger().i('matchMedicine()');
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('medicine-collection')
          .where('name', isEqualTo: name)
          .get();
      Logger().i(snapshot.docs.length);
      if (snapshot.size != 0) {
        Logger().i(snapshot.docs.asMap()[0]!['id']);
        Logger().i('medicine id - ${snapshot.docs.asMap()[0]!['id']}');
        return snapshot.docs.asMap()[0]!['id'];
      } else {
        showDialogBox(
            'Not available', '~$name~ is not available in our pharmecies');
        return '';
        // return createMedicine(name: name, dosage: dosage);
      }
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return '';
    }
  }
}
