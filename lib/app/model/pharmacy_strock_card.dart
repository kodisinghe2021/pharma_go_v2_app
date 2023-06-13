
class PharmacyStrockCard {
  String? name;
  String? frequency;
  String? days;
  String? dosageInNote;
  String? id;
  String? dosageInMedicine;
  String? price;
  String? quantity;

  // PharmacyStrockCard.fromJson(Map<String, dynamic> dataMap) {
  //   name = dataMap['name'];
  //   frequency = dataMap['frequency'];
  //   days = dataMap['days'];
  //   dosageInMedicine = dataMap['dosage_in_note'];
  //   id = dataMap['id'];
  //   dosageInMedicine = dataMap['dosage_in_medicine'];
  // }

  PharmacyStrockCard.setData(
    String this.name,
    String this.frequency,
    String this.days,
    String this.dosageInNote,
    String this.id,
    String this.dosageInMedicine,
    String this.price,
    String this.quantity,
  );
}
