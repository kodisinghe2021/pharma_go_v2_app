class MedicineModel {
  String medicineID;
  String name;
  String dossage;

  MedicineModel({
    required this.medicineID,
    required this.name,
    required this.dossage,
  });


  factory MedicineModel.fromJson(Map<String, dynamic> map) {
    return MedicineModel(
      medicineID: map['medicineID'] ?? 'null',
      name: map['name'] ?? 'null',
      dossage: map['dossage'] ?? 'null',
    );
  }


  Map<String, dynamic> toJson(MedicineModel medicineModel) {
    Map<String, dynamic> map = {
      'medicineID': medicineModel.medicineID,
      'name': medicineModel.name,
      'dossage': medicineModel.dossage,
    };
    return map;
  }


}
