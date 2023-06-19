import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharma_go_v2_app/app/model/client/medicine_cart_model.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_strock_card.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

class RetrieveHelper {
//*----------------------instanse
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();

  // get local stoarage.
  final _localStorage = GetStorage();

  //retrieve phamacy strock prices using medicine id
  Future<List<PharmacyCardModel>> getPriceListWithMedicineID({
    required List<MedicineCartModel> listOfMedicineCarts,
  }) async {
    List<PharmacyCardModel> pharmacyCardList = [];
    // create collection refference
    CollectionReference pharmacyRef =
        _backEndSupport.noSQLStorage().collection('pharmacy-collection');

    // Logger().i("inside getPriceListWithMedicineID");
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

        List<MedicineCardModel> strockList = await getstrockData(
          pharmacyDocID: pharmacyDoc.id,
          medicineCartModels: listOfMedicineCarts,
        );

        if (strockList.isNotEmpty) {
          //create object
          PharmacyCardModel pharmacyCard = PharmacyCardModel.setData(
            pharmacyDoc.id.toString(),
            pharmacyData['name'] ?? '',
            pharmacyData['location'] ?? '',
            pharmacyData['contact'] ?? '',
            pharmacyData['registrationID'] ?? '',
            strockList,
          );

          // Logger().i(
          //     "Strok is created -->  pha name --+ ${pharmacyCard.phamacyName}");
          // // if the strock is available only then add it to the list of the data map
          pharmacyCardList.add(pharmacyCard);
        }
      }
      // Logger().i("list of pharmacy card object ${pharmacyCardList.length}");
      return pharmacyCardList;
    } on FirebaseException catch (e) {
      showDialogBox("error", e.code);
      return [];
    }
  }

  //retrieve all medicine data frim strock of selected pharmacy
  Future<List<MedicineCardModel>> getstrockData({
    required String pharmacyDocID,
    required List<MedicineCartModel> medicineCartModels,
  }) async {
    // show parameters are correctly recieved

    List<MedicineCardModel> listOfPharmacyStrockCard = [];

    try {
      for (var medicineCart in medicineCartModels) {
        //from strock collection
        QuerySnapshot<Map<String, dynamic>> queryMap = await _backEndSupport
            .noSQLStorage()
            .collection('pharmacy-collection')
            .doc(pharmacyDocID)
            .collection('pharmacy-strock')
            .where('medicineID', isEqualTo: medicineCart.id)
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

        // Logger().i(
        //     "Strock is catched --> price --${stockDoc['price']} Q -- ${stockDoc['quantity']}");
        MedicineCardModel pharmacyStrockCard = MedicineCardModel.setData(
          medicineCart.name.toString(),
          medicineCart.frequency.toString(),
          medicineCart.days.toString(),
          medicineCart.dosageInNote.toString(),
          medicineCart.id.toString(),
          medicineCart.dosageInMedicine.toString(),
          stockDoc['price'],
          stockDoc['quantity'],
        );

        listOfPharmacyStrockCard.add(pharmacyStrockCard);
      }
      //   Logger().i("object is created --${listOfPharmacyStrockCard.length}");
      return listOfPharmacyStrockCard;
    } on FirebaseException catch (e) {
      showDialogBox('error', e.code);
      return listOfPharmacyStrockCard;
    }
  }
}
