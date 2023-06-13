import 'package:pharma_go_v2_app/app/model/pharmacy_strock_card.dart';

class PharmacyCard {
  String? pharmacyID;
  String? phamacyName;
  Map<String, dynamic>? location;
  String? contact;
  String? registrationID;
  List<PharmacyStrockCard>? pharmacyCardStrock;

  PharmacyCard.setData(
    String this.pharmacyID,
    String this.phamacyName,
    Map<String, dynamic> this.location,
    String this.contact,
    String this.registrationID,
    List<PharmacyStrockCard> this.pharmacyCardStrock,
  );
}
