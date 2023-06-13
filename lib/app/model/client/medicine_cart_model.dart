class MedicineCartModel {
  String? name;
  String? frequency;
  String? days;
  String? dosageInNote;
  String? id;
  String? dosageInMedicine;

  MedicineCartModel.fromJson(Map<String, dynamic> dataMap) {
    name = dataMap['name'];
    frequency = dataMap['frequency'];
    days = dataMap['days'];
    dosageInMedicine = dataMap['dosage_in_note'];
    id = dataMap['id'];
    dosageInMedicine = dataMap['dosage_in_medicine'];
  }

  MedicineCartModel.setData(
    String this.name,
    String this.frequency,
    String this.days,
    String this.dosageInNote,
    String this.id,
    String this.dosageInMedicine,
  );
  
}
