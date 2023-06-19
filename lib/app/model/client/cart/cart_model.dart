class CartModel {
  String? medicineName;
  String? medicineID;
  String? dosageInNote;
  String? dosageInMedicine;
  String? days;
  String? frequncy;
  String? price;
  String? pharmacyID;
  String? pharmacyName;
  String? date;
  String? time;

  CartModel.setData(
    this.medicineName,
    this.medicineID,
    this.dosageInNote,
    this.dosageInMedicine,
    this.days,
    this.frequncy,
    this.price,
    this.pharmacyID,
    this.pharmacyName,
    this.date,
    this.time,
  );


  CartModel.fromJson({required Map<String, dynamic> json}) {
    medicineID = json['medicineID'];
    medicineName = json['medicineName'];
    dosageInNote = json['dosageInNote'];
    dosageInMedicine = json['dosageInMedicine'];
    days = json['days'];
    frequncy = json['frequncy'];
    price = json['price'];
    pharmacyID = json['pharmacyID'];
    pharmacyName = json['pharmacyName'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docID'] = docID;
    data['medicineID'] = medicineID;
    data['medicineName'] = medicineName;
    data['dosageInNote'] = dosageInNote;
    data['dosageInMedicine'] = dosageInMedicine;
    data['days'] = days;
    data['frequncy'] = frequncy;
    data['price'] = price;
    data['pharmacyID'] = pharmacyID;
    data['pharmacyName'] = medicineName;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}
