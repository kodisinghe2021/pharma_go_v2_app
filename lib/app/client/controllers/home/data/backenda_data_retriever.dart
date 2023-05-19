import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/dependencies/firebase_instance.dart';

class RetrieveHelper {
//*----------------------instanse
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();

  // get local stoarage.
  final _localStorage = GetStorage();

  //retrieve phamacy strock prices using medicine id
  Future<List<Map<String, dynamic>>> getPriceListWithPharmacyID(
      String medicineID) async {
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
        Map<String, dynamic> stockDataMap =
            pharmacyDoc.data() as Map<String, dynamic>;

        // add data to data map
        stockDataMap.putIfAbsent('pharmacyID', () => pharmacyDoc.id);
        stockDataMap.putIfAbsent(
            'phamacyName', () => stockDataMap['name'] ?? '');
        stockDataMap.putIfAbsent(
            'location', () => stockDataMap['location'] ?? '');
        stockDataMap.putIfAbsent(
            'contact', () => stockDataMap['contact'] ?? '');
        stockDataMap.putIfAbsent(
            'registrationID', () => stockDataMap['registrationID'] ?? '');

        //doc converting to the map
        // Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

        // get the ID of pharmacy collection. and find price
        //from strock collection
        QuerySnapshot<Map<String, dynamic>> queryMap = await _backEndSupport
            .noSQLStorage()
            .collection('pharmacy-collection')
            .doc(pharmacyDoc.id)
            .collection('pharmacy-strock')
            .where('medicineID', isEqualTo: medicineID)
            .get();

        //get the Document list
        List<QueryDocumentSnapshot> stockList = queryMap.docs;

        //get the first doc in the list. * list have only one value
        Map<String, dynamic> stockDoc =
            stockList.first.data() as Map<String, dynamic>;

        stockDataMap.putIfAbsent('price', () => stockDoc['price']);
        stockDataMap.putIfAbsent('quantity', () => stockDoc['quantity']);

        // Logger().i("pharmacy Strock map range-- ${stockDataMap.length}");
        // Logger()
        //     .i("pharmacy Strock map range-- ${stockDataMap['phamacyName']}");
        // Logger().i("pharmacy Strock map range-- ${stockDataMap['location']}");
        // Logger().i("pharmacy Strock map range-- ${stockDataMap['price']}");
        // Logger().i("pharmacy Strock map range-- ${stockDataMap['quantity']}");
        listOfdataMap.insert(0, stockDataMap);

        // _backEndSupport.noSQLStorage().collection('pharmacy-collection');
      }
      Logger().i("length of list of map ---> ${listOfdataMap.length}");
      return listOfdataMap;
    } on FirebaseException catch (e) {
      showDialogBox("error", e.code);
      return [];
    }
  }
}
