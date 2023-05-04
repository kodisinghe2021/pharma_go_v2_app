import 'package:pharma_go_v2_app/models/medicine_model.dart';

class MedicineNote {
  final String id;
  final String imageURL;
  final List<MedicineModel> medicineList;

  MedicineNote({
    required this.medicineList,
    required this.id,
    required this.imageURL,
  });
}
