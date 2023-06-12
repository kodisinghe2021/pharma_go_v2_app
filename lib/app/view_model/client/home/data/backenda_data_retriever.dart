import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/supports/services/firebase_instance.dart';

class RetrieveHelper {
//*----------------------instanse
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();

  // get local stoarage.
  final _localStorage = GetStorage();

  //retrieve phamacy strock prices using medicine id
  Future<List<Map<String, dynamic>>> getPriceListWithMedicineID({
    required List<Map<String, dynamic>> medicineAllData,
  }) async {
    List<Map<String, dynamic>> listOfdataMap = [];
    // create collection refference
    CollectionReference pharmacyRef =
        _backEndSupport.noSQLStorage().collection('pharmacy-collection');

    try {
      //get the snapshot of data
      QuerySnapshot snapshot = await pharmacyRef.get();

      // make documnet list
      List<QueryDocumentSnapshot<Object?>> pharmacyDocList = snapshot.docs;

      //get single documnet
      for (var pharmacyDoc in pharmacyDocList) {
        //get doc as map
        Map<String, dynamic> pharmacyData =
            pharmacyDoc.data() as Map<String, dynamic>;

        // add data to data map
        pharmacyData.putIfAbsent('pharmacyID', () => pharmacyDoc.id);
        pharmacyData.putIfAbsent(
            'phamacyName', () => pharmacyData['name'] ?? '');
        pharmacyData.putIfAbsent(
            'location', () => pharmacyData['location'] ?? '');
        pharmacyData.putIfAbsent(
            'contact', () => pharmacyData['contact'] ?? '');
        pharmacyData.putIfAbsent(
            'registrationID', () => pharmacyData['registrationID'] ?? '');

        // input pharmacy id and check strock data in the pharmacy. and match with medicine list
        // with the list of the phamacy strock

        //   Logger().i("Pharmacy ID == ${pharmacyDoc.id}");
        List<Map<String, dynamic>> strockList = await getstrockData(
          pharmacyDocID: pharmacyDoc.id,
          medicineIDListWiithAllDAta: medicineAllData,
        );

        if (strockList.isNotEmpty) {
          // if the strock is available then add it to pharmacy data
          pharmacyData.putIfAbsent('strockList', () => strockList);

          // if the strock is available only then add it to the list of the data map
          listOfdataMap.insert(0, pharmacyData);
        }
      }
      //   Logger().i("length of list of map ---> ${listOfdataMap.length}");
      return listOfdataMap;
    } on FirebaseException catch (e) {
      showDialogBox("error", e.code);
      return [];
    }
  }

  //retrieve all medicine data frim strock of selected pharmacy
  Future<List<Map<String, dynamic>>> getstrockData(
      {required String pharmacyDocID,
      required List<Map<String, dynamic>> medicineIDListWiithAllDAta}) async {
    // show parameters are correctly recieved

    List<Map<String, dynamic>> listOfMedicineMap = [];

    try {
      for (var medicineID in medicineIDListWiithAllDAta) {
        //make map to store single data doc
        Map<String, dynamic> stockDataMap = {};
        // get the ID of pharmacy collection. and find price
        //from strock collection
        QuerySnapshot<Map<String, dynamic>> queryMap = await _backEndSupport
            .noSQLStorage()
            .collection('pharmacy-collection')
            .doc(pharmacyDocID)
            .collection('pharmacy-strock')
            .where('medicineID', isEqualTo: medicineID['id']) //ativan
            .get();

        // check medicine id is available or not
        if (queryMap.docs.isEmpty) {
          return [];
        }
        //get the Document list
        List<QueryDocumentSnapshot> stockList = queryMap.docs;

        //get the first doc in the list. * list have only one value

        Map<String, dynamic> stockDoc =
            stockList.first.data() as Map<String, dynamic>;

        stockDataMap.putIfAbsent('price', () => stockDoc['price']);
        stockDataMap.putIfAbsent('quantity', () => stockDoc['quantity']);
        stockDataMap.putIfAbsent('name', () => medicineID['name']);
        stockDataMap.putIfAbsent('frequency', () => medicineID['frequency']);
        stockDataMap.putIfAbsent('days', () => medicineID['days']);
        stockDataMap.putIfAbsent(
            'dosage_in_note', () => medicineID['dosage_in_note']);
        stockDataMap.putIfAbsent(
            'dosage_in_medicine', () => medicineID['dosage_in_medicine']);

        listOfMedicineMap.insert(0, stockDataMap);
      }
      return listOfMedicineMap;
    } on FirebaseException catch (e) {
      showDialogBox('error', e.code);
      return listOfMedicineMap;
    }
  }
}
