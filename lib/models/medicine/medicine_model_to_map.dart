import 'package:pharma_go_v2_app/models/medicine/medicine_model.dart';

class ToMedicineMap {
  Map<String, dynamic> toJson(MedicineModel model) {
    Map<String, dynamic> map = {
      'medicineID': model.medicineID,
      'name': model.name,
      'dossage': model.dossage,
    };
    return map;
  }
}
