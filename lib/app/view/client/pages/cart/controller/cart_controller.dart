import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/pharmacy_list/components/mcc/mcc_controller.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

class CartController extends GetxController {
  var itemCount = getCartItemLsit.length.obs;

  List<CartModel> getCartList() => getCartItemLsit;

  //--------- get back end support
  final BackEndSupport _support = BackEndSupport();
  final GetStorage _localStore = GetStorage();

  //---- add order to the custormer doc
  Future<void> addOrder(int index) async {
    //-- get model list and with index get current model
    CartModel model = getCartList()[index];

    //-- get current user id
    String userID = await _localStore.read('uID');

    //--
    Logger().i('User ID -- $userID');

    //-- make collection refference
    CollectionReference ref = _support
        .noSQLStorage()
        .collection('user-collection')
        .doc(userID)
        .collection('order-collection');

    //-- create doc id from the firebase
    String docID = ref.doc().id;

    //-- make json from the model
    Map<String, dynamic> dataMap = model.toJson(docID);

    //-- adding data
    await ref.doc(docID).set(dataMap);

    showDialogBox('Success', 'order Added');
  }

  //-- add order to pharmacy
}
