// create user model
import 'package:pharma_go_v2_app/models/pharmacy/phama_model.dart';
import 'package:pharma_go_v2_app/models/user/user_model.dart';

//~+++++ client side
late UserModel _userModel;

// set user object
void setCurrentUserModel(UserModel model) {
  _userModel = model;
}

// return user model
UserModel getCurrentUserModel() => _userModel;

//~++++ pharmacy side
late PharmaModel _pharmaModel;

// set user object
void setCurrentPharmaModel(PharmaModel model) {
  _pharmaModel = model;
}

// return user model
PharmaModel getCurrentPharmaModel() => _pharmaModel;


