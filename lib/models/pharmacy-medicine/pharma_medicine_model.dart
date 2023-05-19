class PharmaMediListModel {
  String strMedicineID;
  String strMedicineName;
  String strDosage;
  String strPrice;
  String strAvailableQuantity;

  PharmaMediListModel({
    required this.strMedicineID,
    required this.strMedicineName,
    required this.strDosage,
    required this.strPrice,
    required this.strAvailableQuantity,
  });

  factory PharmaMediListModel.fromJson(Map<String, dynamic> map) {
    return PharmaMediListModel(
      strMedicineID: map['medicineID'] ?? 'null',
      strMedicineName: map['name'] ?? 'null',
      strDosage: map['dosage'] ?? 'null',
      strPrice: map['price'] ?? 'null',
      strAvailableQuantity: map['quantity'] ?? 'null',
    );
  }
}
