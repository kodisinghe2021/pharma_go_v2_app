import 'package:pharma_go_v2_app/app/model/pharmacy_strock_card.dart';

class PharmacyCardModel {
  String? pharmacyID;
  String? phamacyName;
  Map<String, dynamic>? location;
  String? contact;
  String? registrationID;
  List<MedicineCardModel>? pharmacyCardStrock;

  PharmacyCardModel.setData(
    String this.pharmacyID,
    String this.phamacyName,
    Map<String, dynamic> this.location,
    String this.contact,
    String this.registrationID,
    List<MedicineCardModel> this.pharmacyCardStrock,
  );
}
