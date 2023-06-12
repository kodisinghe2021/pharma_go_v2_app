import 'package:pharma_go_v2_app/app/model/pharmacy/phama_model.dart';

class ToUPharmacyMap {
  Map<String, dynamic> toJson(PharmaModel userModel) {
    Map<String, dynamic> map = {
      'pharmacyID': userModel.pharmaID,
      'name': userModel.name,
      'location': userModel.locationMap,
      'contact': userModel.contact,
      'registrationID': userModel.registrationID,
      'email': userModel.email,
    };
    return map;
  }
}
