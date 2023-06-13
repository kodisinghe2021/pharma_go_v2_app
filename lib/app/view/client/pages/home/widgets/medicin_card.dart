import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_strock_card.dart';
import 'package:pharma_go_v2_app/supports/constant/fonts.dart';

class MedicineCard extends StatelessWidget {
  MedicineCard({
    super.key,
    required this.snapshotData,
    required this.pharmacyCardIndex,
    required this.medicineCardIndex,
  });

  // inizilize controller
  final MedicineCardController _controller =
      Get.put<MedicineCardController>(MedicineCardController());

  final List<PharmacyCard> snapshotData;
  final int pharmacyCardIndex;
  final int medicineCardIndex;

  //observable value only for this card.
  final _isSelected = false.obs;
  @override
  Widget build(BuildContext context) {
    // get Screen size.
    final Size screenSize = MediaQuery.of(context).size;

    // get Single map with medicine
    PharmacyStrockCard? medicineCard =
        snapshotData[pharmacyCardIndex].pharmacyCardStrock![medicineCardIndex];

    // PharmacyStrockCard strockCard = pharmacyStrockCardList[pharmacyCardIndex];
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      height: screenSize.height * .1,
      width: screenSize.width * .5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            width: 3, color: Colors.black.withOpacity(.1) // Colors.transparent,
            ),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1e3c72),
            Color(0xFF2a5298),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: priceCardFont(
                medicineCard.name ?? "Unknown",
                // strockCard.name ?? "",
                20,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: priceCardFont(
                "Take ${medicineCard.dosageInNote ?? ""} pill ${_controller.getIntValue(medicineCard.frequency ?? "")} times a day ",
                13,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: priceCardFont(
                "This tablet only for ${_controller.getIntValue(medicineCard.days ?? "")} days",
                13,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: priceCardFont(
                "Unit price- ${medicineCard.price ?? ""} /=",
                15,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: priceCardFont(
                "total price- ${_controller.getMedicinePrice(
                  days: medicineCard.days ?? "",
                  freq: medicineCard.frequency ?? "",
                  recomendedDosage: medicineCard.dosageInNote ?? "",
                  price: medicineCard.price ?? "",
                  dosageOfMedicine: medicineCard.dosageInMedicine ?? "",
                )} /=",
                15,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
              () => Container(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () async {
                    await onCartTap({});
                  },
                  icon: !_isSelected.value
                      ? const Icon(
                          Bootstrap.cart3,
                          color: Color(0xFFFDE2A0),
                        )
                      : IconButton(
                          onPressed: () async {
                            await onCartTap({});
                          }, //remove from cart
                          icon: const Icon(
                            Bootstrap.dash_circle,
                            color: Color(0xFFFDE2F3),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onCartTap(Map<String, dynamic> dataMap) async {
    //toggle button for value
    _isSelected.value = !_isSelected.value;

    // --- create medicine item object.
    // PharmacyCart pharmacyCart = PharmacyCart(
    //     pharmacyID: snapshotData[pharmacyCardIndex].pharmacyID ?? "");

    //set object to controller
    // _controller.setPharmacyCart(pharmacyCart);

    // double price = _controller.getMedicinePrice(
    //   days: dataMap['days'],
    //   freq: dataMap['frequency'],
    //   recomendedDosage: dataMap['dosage_in_note'],
    //   price: dataMap['price'],
    //   dosageOfMedicine: dataMap['dosage_in_medicine'],
    // );

    // MedicineCartItem medicineCartItem = MedicineCartItem(
    //   medicineName: dataMap['name'] ?? 'null value',
    //   totalPrice: price.toString(),
    //   days: dataMap['days'] ?? 'null value',
    //   requstedDosage: dataMap['dosage_in_note'] ?? 'null value',
    //   quantityOfMedicine: dataMap['quantity'] ?? 'null value',
    // );

    // Logger().i("MedicineCartItem ${medicineCartItem.medicineName}");

    // Logger().i("MedicineCartItem ${pharmacyCart.pharmacyID}");

    // pharmacyCart.setItem(medicineCartItem);
  }
}

class MedicineCardController extends GetxController {
  var isSelected = false.obs;

// get String value and parse only integers in the string as Integers
  int getIntValue(String value) =>
      int.parse(value.replaceAll(RegExp(r'[^0-9]'), ''));

// get String value and parse only integers in the string as floats
  double getDoubleValue(String value) =>
      double.parse(value.replaceAll(RegExp(r'[^0-9]'), ''));

// calculate the price of each medicine
  double getMedicinePrice({
    required String days,
    required String freq,
    required String recomendedDosage,
    required String price,
    required String dosageOfMedicine,
  }) {
    //calculate total dosage
    double totalDosage = getDoubleValue(days) *
        getDoubleValue(freq) *
        getDoubleValue(recomendedDosage);

    //return each medicine price
    return getDoubleValue(price) *
        (totalDosage / getDoubleValue(dosageOfMedicine));
  }

//-------------------- //!-- cart functions
  var itemCount = 0.obs;

  void counter() {
    itemCount += 1;
  }

  // late PharmacyCart _pharmacyCart;

  // void setPharmacyCart(PharmacyCart pharmacyCartfrom) {
  //   _pharmacyCart = pharmacyCartfrom;
  // }

  // PharmacyCart get getPharmacyCart => _pharmacyCart;
}

// //model
// //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// class MedicineCartItem {
//   String medicineName;
//   String totalPrice;
//   String days;
//   String requstedDosage;
//   String quantityOfMedicine;

//   MedicineCartItem({
//     required this.medicineName,
//     required this.totalPrice,
//     required this.days,
//     required this.requstedDosage,
//     required this.quantityOfMedicine,
//   });
// }

// class PharmacyCart {
//   String pharmacyID;
//   final List<MedicineCartItem> _itemList = [];

//   PharmacyCart({
//     required this.pharmacyID,
//   });

//   void setItem(MedicineCartItem item) {
//     _itemList.add(item);
//   }

//   List<MedicineCartItem> get getItemList => _itemList;
// }
