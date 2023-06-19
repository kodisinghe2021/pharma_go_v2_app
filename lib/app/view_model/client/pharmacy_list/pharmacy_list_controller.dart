import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/model/client/medicine_cart_model.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view_model/client/tabbar_tabs/home/controller/backenda_data_retriever.dart';
import 'package:pharma_go_v2_app/supports/providers/client/characters_object/char_obj_list.dart';
import 'package:pharma_go_v2_app/supports/services/firebase/firebase_instance.dart';

class PharmacyListController extends GetxController {
  //get back end.
  final BackEndSupport _backEndSupport = BackEndSupport();
  // data Retriver
  final RetrieveHelper _retrieveHelper = RetrieveHelper();

//& 3---------------------------------
  Future<List<PharmacyCardModel>> getData() async {
    // Logger().i("inside00");
    // Logger().i("_charObjListProvider.getObjectList ${getObjectList[0].name}");
    // Logger().i("not passed");
    if (getObjectList.isEmpty) {
      showDialogBox('Text not identified', 'message');
      return [];
    }

    List<MedicineCartModel> medicineCartModelList = [];
    // Logger().i("inside00-1");
    // make medicine id list
    for (var charObject in getObjectList) {
      // if medicine name is null then return.
      // Logger().i("character object name- ${charObject.name}");
      if (charObject.name == null) {
        return [];
      }

      // get the medicine name and find it is available or not
      Map<String, dynamic> medicineIdWithDosage =
          await getMedicine(charObject.name ?? '');

      //  Logger().i("Medicine found -- ${medicineIdWithDosage['medId']}");

      if (medicineIdWithDosage['medId'].isNotEmpty) {
        // create and initilize medicine cart object
        MedicineCartModel medicineCartModel = MedicineCartModel.setData(
          charObject.name.toString(),
          charObject.frequency.toString(),
          charObject.days.toString(),
          charObject.dosageInNote.toString(),
          medicineIdWithDosage['medId'],
          medicineIdWithDosage['dosage_in_medicine'],
        );

        medicineCartModelList.add(medicineCartModel);
      }
    }
    //  Logger().i("medicineCartModelList created ${medicineCartModelList.length}");
    List<PharmacyCardModel> dataList =
        await _retrieveHelper.getPriceListWithMedicineID(
      listOfMedicineCarts: medicineCartModelList,
    );

    return dataList;
  }

//& 4---------------------------------
// make meidcine id list
  Future<Map<String, dynamic>> getMedicine(String medicineName) async {
    // Logger().i("inside01");
    //make empty list for store data.
    Map<String, dynamic> medicineDataMap = {};

    //make refference
    CollectionReference ref =
        _backEndSupport.noSQLStorage().collection('medicine-collection');

    try {
      // get snapshot
      QuerySnapshot snapshot =
          await ref.where('name', isEqualTo: medicineName).get();

      // maek as doc list.
      List<QueryDocumentSnapshot> docList = snapshot.docs;

      // get medicine dosage
      Map<String, dynamic> medicineData =
          docList.first.data() as Map<String, dynamic>;

      // put dosage
      String dosage = medicineData['dossage'];

      // doc list have only one value.
      String medicineID = docList.first.id;

      medicineDataMap.putIfAbsent('medId', () => medicineID);
      medicineDataMap.putIfAbsent('dosage_in_medicine', () => dosage);

      return medicineDataMap;
    } catch (e) {
      return medicineDataMap;
    }
  }
}
