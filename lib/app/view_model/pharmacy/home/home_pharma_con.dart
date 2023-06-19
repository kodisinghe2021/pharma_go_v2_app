import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy/medicine/medicine_model.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy/medicine/medicine_model_to_map.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

class PharmaHomeController extends GetxController {
//*----------------------instanse
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();

  // get local stoarage.
  final _localStorage = GetStorage();

//*-----------------------controllcers
  TextEditingController medicineName = TextEditingController();
  TextEditingController dosage = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();

//*----------------------observable values
  var isLoading = false.obs;

//&----------------------functions---------------------------------

  //----- this is for testing
  Future<void> testing() => add();

//------- head function
  Future<void> add() async {
    // get inputs
    String strMedicineName = medicineName.text;
    String strDosage = dosage.text;
    String strQuantity = quantity.text;
    String strPrice = price.text;
    String strMedicineID = '';

    String strPharmacyID = _localStorage.read('uID');

    //check validation
    if (!isValidate()) {
      showDialogBox('Empty fields', 'fields cannot be empty');
      return;
    }
    Logger().i("validated");

    // first find medicine id is available or not
    strMedicineID = await findMedicineUsingName(strMedicineName);

    Logger().i("findMedicineUsingName(strMedicineName) --> $strMedicineID");
    // if id is empty then add medicine data to medicine-collection
    // and retrieve medicine id
    if (strMedicineID.isEmpty) {
      Logger().i("medicine ID is empty");
      strMedicineID = await addMedicine(
        medicineName: strMedicineName,
        dosage: strDosage,
      );
      Logger().i("addMedicine() --> $strMedicineID");
    }

    // find medicine id is available in pharmacy-strock
    Map<String, dynamic> map = await findMdicinefromStrock(
      docID: strMedicineID,
      pharmaID: strPharmacyID,
    );
    Logger().i("findMdicinefromStrock() --> $map");
    //check document is available or not in strock
    //if available then update the document.
    if (map.isNotEmpty) {
      Logger().i("map is not empty");
      // update current strock
      updatePharmacyStrock(
        pmPharmaID: strPharmacyID,
        pmMedicineID: strMedicineID,
        pmMap: map,
        pmPrice: strPrice,
        pmQuantity: strQuantity,
      );
      Logger().i("updatePharmacyStrock()---> success");
    } else {
      // create new stock
      Logger().i("map is empty");
      addPharmacyStrock(
        pmPharmaID: strPharmacyID,
        pmMedicineID: strMedicineID,
        pmPrice: strPrice,
        pmQuantity: strQuantity,
      );
      Logger().i("addPharmacyStrock()---> success");
    }
    medicineName.clear();
    dosage.clear();
    quantity.clear();
    price.clear();
  }

/*--- first check whether the given medicine is available in 
      medicine-collection by using medicine name.
*/
  Future<String> findMedicineUsingName(String name) async {
    // make collection of the refference
    CollectionReference reference =
        _backEndSupport.noSQLStorage().collection('medicine-collection');

    // try to find medicine by using medicine name, if the medicine
    // name is not avaialble snapsjot will be empty
    QuerySnapshot snapshot =
        await reference.where('name', isEqualTo: name).get();
    Logger().i("snapshots gotted ---> ${snapshot.docs.length}");
    //check the lenth of the snapshot, if length is grater than 0
    // then return the medicine id from the medicine map
    if (snapshot.size > 0) {
      //Logger().i("snapshot type --> $snapshot");
      List<QueryDocumentSnapshot> querySnapshots = snapshot.docs;

      Logger().i("snapshot type --> ${querySnapshots.first.data()}");

      Map<String, dynamic> medicineMap =
          querySnapshots.first.data() as Map<String, dynamic>;

      Logger().i("medicine id is found -- ${medicineMap['medicineID']}");
      return medicineMap['medicineID'];
    }
    Logger().i('medicine id not find');
    // if snapshot is lower than or equal to 0 then return null;
    return '';
  }

  //---- add medicine to the medicine collection
  Future<String> addMedicine({
    required String medicineName,
    required String dosage,
  }) async {
    //--- create refference path to pharmacy collection
    CollectionReference reference =
        _backEndSupport.noSQLStorage().collection('medicine-collection');

    // genarate DocID for this medicine document
    String docID = reference.doc().id;

    // first create medicine object
    MedicineModel model = MedicineModel(
      medicineID: docID,
      name: medicineName.toLowerCase(),
      dossage: dosage,
    );

    // get map using model
    Map<String, dynamic> map = ToMedicineMap().toJson(model);

    // set map to the backend
    try {
      await reference.doc(docID).set(map);
      return docID;
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went wrong', e.code);
      return '';
    }
  }

  //---- find medicine id in pharmacy strock
  Future<Map<String, dynamic>> findMdicinefromStrock({
    required String docID,
    required String pharmaID,
  }) async {
    // make refference
    CollectionReference ref = _backEndSupport
        .noSQLStorage()
        .collection('pharmacy-collection')
        .doc(pharmaID)
        .collection('pharmacy-strock');

    try {
      await ref.doc(docID).get().then(
        (DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            Logger().i('Document data: ${documentSnapshot.data()}');
            return documentSnapshot.data() as Map<String, dynamic>;
          } else {
            Logger().i('Document not exit');
            return {};
          }
        },
      );
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went wrong', e.code);
      return {};
    }

    Logger().d("done");
    return {};
  }

//--- upload data to pharmacy-strock
  Future<void> updatePharmacyStrock({
    required String pmPharmaID,
    required String pmMedicineID,
    required Map<String, dynamic> pmMap,
    required String pmPrice,
    required String pmQuantity,
  }) async {
    // make refference
    CollectionReference ref = _backEndSupport
        .noSQLStorage()
        .collection('pharmacy-collection')
        .doc(pmPharmaID)
        .collection('pharmacy-strock');

    // update map values
    pmMap.update('price', (value) => pmPrice);
    pmMap.update('quantity', (value) => pmQuantity);

    //set data
    try {
      ref.doc(pmMedicineID).set(pmMap);
      showDialogBox('Successfully updated', 'oooohhaaa!!!');
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went wrong', e.code);
    }
  }

//--- add data to Pharmacy stock
  Future<void> addPharmacyStrock({
    required String pmPharmaID,
    required String pmMedicineID,
    required String pmPrice,
    required String pmQuantity,
  }) async {
    // make refference
    CollectionReference ref = _backEndSupport
        .noSQLStorage()
        .collection('pharmacy-collection')
        .doc(pmPharmaID)
        .collection('pharmacy-strock');

    //set data
    try {
      ref.doc(pmMedicineID).set({
        'medicineID': pmMedicineID,
        'price': pmPrice,
        'quantity': pmQuantity,
      });
      showDialogBox('Successfully updated', 'oooohhaaa!!!');
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went wrong', e.code);
    }
  }

  //----  check whether the fields is empty or not ?
  bool isValidate() {
    bool isValid = false;
    if (medicineName.text.isNotEmpty &&
        dosage.text.isNotEmpty &&
        quantity.text.isNotEmpty) {
      if (int.tryParse(dosage.text) != null &&
          int.tryParse(quantity.text) != null) {
        isValid = true;
      } else {
        showDialogBox(
            'invalid values', 'Dosage and Quantity must have only numbers');
      }
    } else {
      showDialogBox('flieds are empty', 'All fields must be fiiled');
    }
    return isValid;
  }
}//-- </PharmaHomeController>

