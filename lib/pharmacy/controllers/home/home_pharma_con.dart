import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/client/presentation/widgets/alert_boxes/get_alert.dart';

class HomePharmaCon extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage getStorage = GetStorage();

  var isLoading = false.obs;

  //* textediting controllers
  TextEditingController medicineName = TextEditingController();
  TextEditingController dosage = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController quantity = TextEditingController();

  // //* add user to fire Store
  // Future<void> addMedicine() async {
  //   if (medicineName.text.isNotEmpty &&
  //       dosage.text.isNotEmpty &&
  //       brand.text.isNotEmpty) {
  //     try {
  //       String docID = _firestore.collection('medicine-collection').doc().id;
  //       await _firestore.collection('medicine-collection').doc(docID).set({
  //         'id': docID,
  //         'name': medicineName.text,
  //         'dosage': dosage.text,
  //         'brand': brand.text,
  //       });
  //       Logger().i("added successfully");
  //     } on FirebaseException catch (e) {
  //       showDialogBox("Somthing wrong", e.code);
  //       Logger().e(e.code);
  //     }
  //   } else {
  //     showDialogBox("Empty fields", 'Fields cannot be empty.');
  //   }
  // }

//^----------------------------------------------------------------

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Future<void> addMedicineData() async {
    if (!isValidate()) {
      Logger().e('errroorrrrr ${isValidate()}');
      return;
    }
    String medicineID = '';
    // CollectionReference refMC = _firestore.collection('medicine-collection');
    // QuerySnapshot snapshot = await refMC.get();
    List<QueryDocumentSnapshot<Object?>> medicineList =
        await retrieveMedicineList();

//find and match medicine name in the medicine collection
// with the given medicine name, if it is matched the ID will
//store the medicineID variable.
    for (int i = 0; i < medicineList.length; i++) {
      String nameFromMap = medicineList[i]['name'];
      // Logger().i(nameFromMap);
      if (nameFromMap == medicineName.text) {
        medicineID = medicineList[i]['id'];
        Logger().i('name matched ---> $nameFromMap = $medicineID');
        break;
      }
    }

// the medicine name is not available in medicine-collection
// then create new medicine, and get the ID of it.
    if (medicineID.isEmpty) {
      medicineID = await addMedicine();
    }

// update medicine collection in pharma docs
    await updateMedicineColInPharma(medicineID);
    Logger().i('updated');
    medicineName.clear();
    brand.clear();
    dosage.clear();
    medicineName.clear();
    quantity.clear();
  }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

//~ retreive medicine list as a List of QueryDocumentSnapshot<Object?>
  Future<List<QueryDocumentSnapshot<Object?>>> retrieveMedicineList() async {
    List<QueryDocumentSnapshot<Object?>> medicineList = [];
    try {
      CollectionReference refMC = _firestore.collection('medicine-collection');
      QuerySnapshot snapshot = await refMC.get();
      medicineList = snapshot.docs;
      return medicineList;
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went Wrong', e.code);
      return medicineList;
    }
  }

//~ add medicine to the medicine-collection
  Future<String> addMedicine() async {
    String newMedicineDocID = '';
    try {
      CollectionReference refMC = _firestore.collection('medicine-collection');

      // making doc id and store it
      newMedicineDocID = refMC.doc().id;

      await refMC.doc(newMedicineDocID).set({
        'id': newMedicineDocID,
        'brand': brand.text,
        'dosage': dosage.text,
        'name': medicineName.text
      });
      return newMedicineDocID;
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went Wrong', e.code);
      return newMedicineDocID;
    }
  }

//~ add new medicine to the medicine collection in the
//~ pharmacy doc
  Future<void> updateMedicineColInPharma(String medicineID) async {
    try {
      CollectionReference refPharma =
          _firestore.collection('pharmacy-collection');

      await refPharma
          .doc(getStorage.read('uID'))
          .collection('my-strock')
          .doc(medicineID)
          .set({
        'quantity': quantity.text,
      });
    } on FirebaseException catch (e) {
      showDialogBox('Somthing went Wrong', e.code);
    }
  }

// field validation checker
  bool isValidate() {
    bool isValid = false;
    if (medicineName.text.isNotEmpty &&
        dosage.text.isNotEmpty &&
        brand.text.isNotEmpty &&
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
}
