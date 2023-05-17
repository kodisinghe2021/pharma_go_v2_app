import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

SnackbarController showSnackBar(
  String title,
  String message,
) =>
    Get.snackbar(
      title,
      message,
    );

dynamic showDialogBox(
  String title,
  String message,
) =>
    Get.defaultDialog(
      title: title,
      middleText: message,
    );

dynamic waitingDialogBox() =>
    showDialogBox('Please wait', 'your request is being processing');

// dynamic customDialogBox()=> AwesomeDialog(
//             context: context,
//             dialogType: DialogType.info,
//             animType: AnimType.rightSlide,
//             title: 'Dialog Title',
//             desc: 'Dialog description here.............',
//             btnCancelOnPress: () {},
//             btnOkOnPress: () {},
//             )..show();