class MedicineModel {
  String id;
  String medicineName;
  String dosage;

  MedicineModel({
    required this.id,
    required this.medicineName,
    required this.dosage,
  });
  MedicineModel createModel(
    id,
    medicineName,
    dosage,
    usingDays,
  ) =>
      MedicineModel(
        id: id,
        medicineName: medicineName,
        dosage: dosage,
      );

  Map<String, dynamic> toJSON(MedicineModel model) {
    Map<String, dynamic> jsonfile = {};
    jsonfile['id'] = model.id;
    jsonfile['medicineName'] = model.medicineName;
    jsonfile['dosage'] = model.dosage;

    return jsonfile;
  }
}