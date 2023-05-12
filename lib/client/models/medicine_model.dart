class MedicineModel {
  String id;
  String medicineName;
  String dosage;
  String brand;

  MedicineModel({
    required this.id,
    required this.medicineName,
    required this.dosage,
    required this.brand,
  });
  MedicineModel createModel(
    id,
    medicineName,
    dosage,
    brand,
  ) =>
      MedicineModel(
        id: id,
        medicineName: medicineName,
        dosage: dosage,
        brand: brand,
      );

  Map<String, dynamic> toJSON(MedicineModel model) {
    Map<String, dynamic> jsonfile = {};
    jsonfile['id'] = model.id;
    jsonfile['medicineName'] = model.medicineName;
    jsonfile['dosage'] = model.dosage;

    return jsonfile;
  }
}