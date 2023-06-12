import 'package:pharma_go_v2_app/app/model/pharmacy/pharmacy-medicine/pharma_medicine_model.dart';

class PharmaMediListModelToMap {
  Map<String, dynamic> toJson(PharmaMediListModel model) {
    Map<String, dynamic> map = {
      'medicineID': model.strMedicineID,
      'dosage': model.strDosage,
      'price': model.strPrice,
      'quantity': model.strAvailableQuantity,
    };
    return map;
  }
}
