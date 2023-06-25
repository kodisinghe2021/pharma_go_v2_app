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
  String? status;

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
    this.status,
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
    status = json['status'];
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
    data['pharmacyName'] = pharmacyName;
    data['date'] = date;
    data['time'] = time;
    data['status'] = status;
    
    return data;
  }
}
