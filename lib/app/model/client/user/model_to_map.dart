
import 'package:pharma_go_v2_app/app/model/client/user/user_model.dart';

class ToUserMap {
  Map<String, dynamic> toJson(UserModel userModel) {
    Map<String, dynamic> map = {
      'userID': userModel.userID,
      'name': userModel.name,
      'location': userModel.locationMap,
      'contact': userModel.contact,
      'nic': userModel.nic,
      'email': userModel.email,
    };
    return map;
  }
}
