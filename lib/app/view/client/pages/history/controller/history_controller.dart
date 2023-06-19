import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

class HistoryController extends GetxController {
  late GetStorage _getStorage;

  @override
  void onInit() async {
    _getStorage = GetStorage();
    userID = await _getStorage.read('uID');
    Logger().i(userID);
    super.onInit();
  }

  //--- backend support
  final FirebaseFirestore _backEndSupport = BackEndSupport().noSQLStorage();

  String userID = '';

  // Future<void> saveData(String title, String description) async {
  //   // validation
  //   if (title.isEmpty || description.isEmpty) {
  //     Logger().i("empty values");
  //     return;
  //   }

  //   //call to helper
  //   await SqlHelper.createCartItem({});

  //   Logger().i("Success");
  //   itemAdding.value = true;
  // }

  Stream<QuerySnapshot> getOrderData() {
    return _backEndSupport
        .collection('user-collection')
        .doc(userID)
        .collection('order-collection')
        .snapshots();
  }

  // Future<int> delete() async {
  //   int deletedID = -1;
  //   for (var i = 0; i < 1; i++) {
  //     deletedID = await SqlHelper.deleteData(42);
  //   }
  //   itemAdding.value = false;
  //   return deletedID;
  // }

}
