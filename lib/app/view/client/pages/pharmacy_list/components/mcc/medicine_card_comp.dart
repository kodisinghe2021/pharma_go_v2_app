import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_strock_card.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view/pharmacy/fragments/orders/components/orderd_medicine_card.dart';
import 'package:pharma_go_v2_app/supports/constant/current_date_time.dart';
import 'package:pharma_go_v2_app/supports/constant/fonts.dart';

import 'mcc_controller.dart';

/*

this class is a child of the "PharmacyCardComp" class

 */

class MedicineCardComp extends StatelessWidget {
  MedicineCardComp({
    required this.medicineCardModel,
    required this.pharmacyCardModel,
    required this.medicineIndex,
    required this.pharmacyIndex,
    super.key,
  });

  final MedicineCardModel medicineCardModel;
  final PharmacyCardModel pharmacyCardModel;
  final int pharmacyIndex;
  final int medicineIndex;

  final MCCController _controller = Get.put<MCCController>(MCCController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(width: .5),
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFabbaab),
                Color(0xffffffff),
              ],
            ),
          ),
          margin: const EdgeInsets.all(8),
          // width: getscreenSize(context).width * .3,
          // height: getscreenSize(context).height * .05,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                " ${medicineCardModel.name}",
                style: cardFontDark(17),
              ),
              Text(
                  "This pill for only ${extractInt(medicineCardModel.days.toString())} days"),
              Text(
                  "Recomendad dosage - ${extractInt(medicineCardModel.dosageInNote.toString())} mg"),
              Text(
                  "Pill dosage - ${extractInt(medicineCardModel.dosageInMedicine.toString())} mg"),
              Text(
                  " ${extractInt(medicineCardModel.frequency.toString())} time per day"),
              Text(
                  "Price - Rs. ${_controller.getMedicinePrice(medicineCardModel).toStringAsFixed(0)}/="),
            ],
          ),
        ),

        // add medicine to cart
        Positioned(
          right: 25,
          top: 0,
          child: IconButton(
            onPressed: () {
              // create object
              CartModel cart = CartModel.setData(
                medicineCardModel.name,
                medicineCardModel.id,
                medicineCardModel.dosageInNote,
                medicineCardModel.dosageInMedicine,
                extractInt(medicineCardModel.days.toString()),
                extractInt(medicineCardModel.frequency.toString()),
                _controller
                    .getMedicinePrice(medicineCardModel)
                    .toStringAsFixed(0),
                pharmacyCardModel.pharmacyID,
                pharmacyCardModel.phamacyName,
                "${getCurrentDate()['date']}/${getCurrentDate()['month']}/${getCurrentDate()['year']}",
                "${getCurrentDate()['hour']}:${getCurrentDate()['minut']}:${getCurrentDate()['second']}",
              );
              Logger().i("medicine name -- ${medicineCardModel.name}");

              // add object to controller
              _controller.setModel(cart);

              showDialogBox('Item added',
                  '${medicineCardModel.name} is added to the cart');
            },
            icon: const Icon(
              Bootstrap.cart_fill,
              color: Color(0xFF606C5D),
            ),
          ),
        ),
      ],
    );
  }
}
