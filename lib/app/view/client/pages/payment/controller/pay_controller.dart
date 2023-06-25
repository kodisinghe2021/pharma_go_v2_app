import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

class PayController extends GetxController {
  late CartModel model;

  @override
  void onInit() {
    dynamic arguments = Get.arguments;
    model = arguments;
    super.onInit();
  }

 

  final FirebaseFirestore _firestore = BackEndSupport().noSQLStorage();

  Future<void> saveDataToPharmacy() async {
    CollectionReference ref = _firestore
        .collection('pharmacy-collection')
        .doc(model.pharmacyID.toString())
        .collection('order-collection');

    String id = ref.doc().id;
    await ref.doc(id).set(model.toJson(id));
    showDialogBox('Success', 'Order send to the pharmacy');
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~binding
class PayBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PayController>(PayController());
  }
}
