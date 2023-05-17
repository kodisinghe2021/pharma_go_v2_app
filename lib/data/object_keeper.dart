// create user model
import 'package:pharma_go_v2_app/models/user/user_model.dart';

late UserModel _userModel;

// set user object
void setCurrentUserModel(UserModel model) {
  _userModel = model;
}

// return user model
UserModel getCurrentUserModel() => _userModel;
