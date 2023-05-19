import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/alert_boxes/get_alert.dart';

class OrdersController extends GetxController {
  Map<String, dynamic> medicineIDMap = {};
  //getStorage
  final GetStorage _storage = GetStorage();
  // fireStore medicine collection
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('medicine-collection');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // note collection refference
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('note-collection');

// return stream of note-collection, all notes will visible.
  Stream<QuerySnapshot> getNewOrders() => _collection.snapshots();

// get medicine ID list from medicineMap
  Future<List<Map<String, dynamic>>> retrieveMedicineData() async {
    List<Map<String, dynamic>> medicineDataMapList = [];
    if (medicineIDMap.isEmpty) {
      return medicineDataMapList;
    }
    // List<String> medicineIDList = [];
    try {
      // for (var element in medicineIDMap.keys) {
      //   medicineIDList.insert(0, element);
      // }
      // Logger().i('inside');
      for (var element in medicineIDMap.keys) {
        DocumentSnapshot snapshot = await _reference.doc(element).get();
        //~-------------------------------------------------------
        // Logger().i(medicineIDMap.keys.length);
        // Logger().i(
        //     "medicine doc retrieve -- ${snapshot.data() as Map<String, dynamic>}");
        //~-------------------------------------------------------
        // here add days to the retrieved map
        Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
        map.putIfAbsent('days', () => medicineIDMap[element]);
        medicineDataMapList.insert(0, map);
      }
      //~-------------------------------------------------------
      // Logger().i("medicineMapList length -${medicineDataMapList.length}");
      // //~-------------------------------------------------------
      return medicineDataMapList;
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return medicineDataMapList;
    }
  }

}
