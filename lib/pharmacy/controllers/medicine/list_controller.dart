import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/client/presentation/widgets/alert_boxes/get_alert.dart';

class ListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _getStorage = GetStorage();

// retrieve strock collection in pharmacy collection
// acording to the Pharmacy user ID
  Future<List<Map<String, dynamic>>> medicineList() async {
    List<Map<String, dynamic>> listOfMaps = [];
    QuerySnapshot snapshot = await _firestore
        .collection('pharmacy-collection')
        .doc(_getStorage.read('uID'))
        .collection('my-strock')
        .get();

// get IDs of each document and get the map of medicine using medicine same
// as id given from .collection('my-strock').
    for (var element in snapshot.docs) {
      Map<String, dynamic> docO = await retrieveMedicineList(element.id);
      docO.putIfAbsent('quantity', () => element['quantity']);
      listOfMaps.insert(0, docO);
    }
    Logger().i(listOfMaps.length);
    return listOfMaps;
  }

// retrieve medicine map in medicine-collection using his ID
// this function need a argument and it is ID of the medicine
// then it will retrieve the map of the doc
  Future<Map<String, dynamic>> retrieveMedicineList(String medID) async {
    Map<String, dynamic> docO = {};
    try {
      CollectionReference ref = _firestore.collection('medicine-collection');
      DocumentSnapshot<Object?> snapshot = await ref.doc(medID).get();
      return snapshot.data() as Map<String, dynamic>;
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went wrong', e.code);
      return docO;
    }
  }
}
