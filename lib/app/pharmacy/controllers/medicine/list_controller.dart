import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/dependencies/firebase_instance.dart';

class PharmaMedListController extends GetxController {
  //*----------------------instanse
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();

  // get local stoarage.
  final _localStorage = GetStorage();

//*-----------------------controllcers

//*----------------------observable values

//& 1----------------------functions---------------------------------
  Future<List<Map<String, dynamic>>> getList() async {
    //create list of models
    List<Map<String, dynamic>> listOfMap = [];

    String strPharmaID = _localStorage.read('uID');

    // retrieve pharmacy strock
    List<Map<String, dynamic>> strockDataList =
        await retrivePhamaStrock(strPharmaID);

    // get the medicine id one by one and retrieve medicine list
    // according to the id's
    int i = 0;

    for (var i = 0; i < strockDataList.length; i++) {
      Logger().e(i);

      //get medicine list
      Map<String, dynamic> medicinedata =
          await retrieveMedicineData(strockDataList[i]['medicineID']);

      //create map
      Map<String, dynamic> map = {
        'medicineID': strockDataList[i]['medicineID'],
        'medicineName': medicinedata['name'],
        'dosage': medicinedata['dossage'],
        'price': strockDataList[i]['price'],
        'availableQuantity': strockDataList[i]['quantity'],
      };

      listOfMap.insert(0, map);
    }

    Logger().i('length of models list ${listOfMap.length}');
    // return model list
    return listOfMap;
  }

//& 2----------------------functions---------------------------------
  Future<List<Map<String, dynamic>>> retrivePhamaStrock(
      String pharmacyID) async {
    Logger().i("retrivePhamaStrock");

    // make refference to the pharmacy-strock
    CollectionReference ref = _backEndSupport
        .noSQLStorage()
        .collection('pharmacy-collection')
        .doc(pharmacyID)
        .collection('pharmacy-strock');
    //create mepty list for store maps
    List<Map<String, dynamic>> strocklist = [];
    // retrieve all stock list
    try {
      // get list of queries
      QuerySnapshot snapshot = await ref.get();

      // insert one by one doc into the strocklist
      for (var element in snapshot.docs) {
        strocklist.insert(0, element.data() as Map<String, dynamic>);
      }
      return strocklist;
    } on FirebaseException catch (e) {
      Logger().i("Error---${e.code}");
      return [];
    }
  }

//& 3----------------------functions---------------------------------
  // retrieve medicine data
  Future<Map<String, dynamic>> retrieveMedicineData(String pmMedicineID) async {
    Logger().i("inside retrieveMedicineData");
    // make refference to the pharmacy-strock
    CollectionReference ref =
        _backEndSupport.noSQLStorage().collection('medicine-collection');

    try {
      //retrieve single doc using id
      DocumentSnapshot snapshot = await ref.doc(pmMedicineID).get();
      Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
      Logger().i("Medicine Map send -- ${map['medicineID']}");
      // cast to the map
      return map;
    } on FirebaseException catch (e) {
      Logger().i("Error---${e.code}");
      return {};
    }
  }
}
