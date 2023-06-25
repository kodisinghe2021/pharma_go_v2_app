import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineController extends GetxController {
  TextEditingController searchingText = TextEditingController();
  var medNameObs = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> medicineStream() =>
      _firestore.collection('medicine-collection').snapshots();

  List<String> searchedList = [];

  Future<List<QueryDocumentSnapshot<Object?>>> searchData() async {
    CollectionReference ref = _firestore.collection('medicine-collection');

    QuerySnapshot<Object?> dataList = await ref.get();

    return dataList.docs;

  }
}
