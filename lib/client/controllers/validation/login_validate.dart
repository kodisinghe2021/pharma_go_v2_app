import 'package:pharma_go_v2_app/client/presentation/widgets/alert_boxes/get_alert.dart';

bool isLoginValid(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    return true;
  } else {
    showDialogBox("Empty field", "Fields Cannot be empty");
    return false;
  }
}
