import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/features/client/presentation/widgets/alert_boxes/get_alert.dart';

class OrderedMedicineListCard extends StatelessWidget {
  OrderedMedicineListCard({
    required this.dataMap,
    super.key,
  });

  final Map<String, dynamic> dataMap;
  final MedicineListCardControllder _controller =
      Get.put<MedicineListCardControllder>(MedicineListCardControllder());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          //*Shadow Container
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  spreadRadius: 20,
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.4),
                ),
              ],
            ),
            width: screenSize.width * .7,
            height: screenSize.height * .05,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFDF4F5),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: screenSize.width * .9,
            height: screenSize.height * .2,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      //^ row stage 1 -------------------------------------------
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              dataMap['name'],
                              style: GoogleFonts.acme(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              dataMap['brand'],
                            ),
                          ],
                        ),
                      ),
                      //^ row stage 2 -------------------------------------------
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "for ${extractInt(dataMap['days'])} day's",
                              style: GoogleFonts.acme(fontSize: 15),
                            ),
                            Text(
                              "${dataMap['dosage']}mg",
                              style: GoogleFonts.acme(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      //^ row stage 3 -------------------------------------------
                      Expanded(
                        flex: 1,
                        child: _controller.strock.value == ''
                            ? TextButton(
                                onPressed: () async {
                                  _controller.strock.value = await _controller
                                      .getStrock(dataMap['id']);
                                },
                                child: const Text(
                                  "Show Strock",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Text(_controller.strock.value),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 95, 14, 23),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: IconButton(
                      onPressed: () {
                        Logger().i("clicked cart");
                      },
                      icon: const Icon(
                        Bootstrap.cart4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class StrockButton extends StatelessWidget {
//   StrockButton({
//     // required this.id,
//     required this.text,
//     super.key,
//   });

//   String text;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [
//               BoxShadow(
//                 offset: Offset(0, 10),
//                 spreadRadius: 1,
//                 blurRadius: 10,
//                 color: Colors.black,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: Colors.amber,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Center(child: Text(text.isEmpty ? '0' : text)),
//         ),
//       ],
//     );
//   }
// }

String extractInt(String text) => text.replaceAll(RegExp(r'[^0-9]'), '');

//!----------------------- Controller
class MedicineListCardControllder extends GetxController {
  //getStorage
  final GetStorage _storage = GetStorage();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var strock = ''.obs;

// retrieve available medicine strock
  Future<String> getStrock(String id) async {
    Logger().d("inside orders Con");
    if (id.isEmpty) {
      showDialogBox('Empty', 'id is empty');
      return '';
    }
    try {
      //----- collection of pharmacy.
      CollectionReference ref = _firestore.collection('pharmacy-collection');

      //--- get pharmacy id
      String pharmacyID = await _storage.read('uID');

      //---- collection my-strock in side pharmacy-collection.
      CollectionReference strockRef =
          ref.doc(pharmacyID).collection('my-strock');

      Logger().d("Collection gotted  --- ${_storage.read('uID')}");

      //---- get the document using doc id of the medicine
      DocumentSnapshot snapshot = await strockRef.doc(id).get();

      //---- convert DocumentSnapshot to the Map
      Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;
      Logger().d("ref gotted  ---$dataMap");

      //---- return if id is not available
      if (dataMap['quantity'] == null) {
        showDialogBox("Error ", "No data");
        return '';
      }
      Logger().i(dataMap['quantity']);
      return dataMap['quantity'];
    } on FirebaseException catch (e) {
      Logger().e(e.code);
      return '';
    }
  }
}
