import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';
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

  var pageLoad = false.obs;
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getOrderData() async {
    pageLoad.value = true;
    Logger().i("user id -- $userID");
    QuerySnapshot<Map<String, dynamic>> qMap = await _backEndSupport
        .collection('user-collection')
        .doc(userID)
        .collection('order-collection')
        .get();

    return qMap.docs;
  }

  void moveToPay(CartModel model) {
    Get.toNamed(Routes.PAYPAGE, arguments: model);
  }
}
