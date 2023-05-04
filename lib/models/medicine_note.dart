class MedicineModel {
  String id;
  String medicineName;
  String dosage;
  String usingDays;
  String imageURL;

  MedicineModel({
    required this.id,
    required this.medicineName,
    required this.dosage,
    required this.usingDays,
    required this.imageURL,
  });
  MedicineModel createModel(
    id,
    medicineName,
    dosage,
    usingDays,
    imageURL,
  ) =>
      MedicineModel(
        id: id,
        medicineName: medicineName,
        dosage: dosage,
        usingDays: usingDays,
        imageURL: imageURL,
      );

  Map<String, dynamic> toJSON(MedicineModel model) {
    Map<String, dynamic> jsonfile = {};
    jsonfile['id'] = model.id;
    jsonfile['medicineName'] = model.medicineName;
    jsonfile['dosage'] = model.dosage;
    jsonfile['usingDays'] = model.usingDays;
    jsonfile['imageURL'] = model.imageURL;
    return jsonfile;
  }
}

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
