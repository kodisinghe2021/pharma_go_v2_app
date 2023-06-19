import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/pharmacy_list/components/mcc/medicine_card_comp.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';
import 'package:pharma_go_v2_app/supports/constant/fonts.dart';

/*

this class is a child of the "PharmacyListPage" class

 */

class PharmacyCardComp extends StatelessWidget {
  const PharmacyCardComp({
    super.key,
    required this.pharmacyCardIndex,
    required this.pharmacyCardModel,
  });

  final int pharmacyCardIndex;
  final PharmacyCardModel pharmacyCardModel;

  @override
  Widget build(BuildContext context) {
    //---------------
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: getscreenSize(context).width,
      height: getscreenSize(context).height * .35,

      //------------------------------------- back layer Container
      child: Stack(
        children: [
          //-- main data set
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: .5),
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFabbaab),
                        Color(0xffffffff),
                        // const Color(0xFFc0392b).withOpacity(.6),
                        // const Color(0xff8e44ad).withOpacity(.6),
                      ])),
              width: getscreenSize(context).width,
              height: getscreenSize(context).height * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //------------------ Pharmacy details
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        //--- logo in the pharmacy card
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/images/9.png',
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),

                        //-- pharmacu details area
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pharmacyCardModel.phamacyName ?? "Unknown",
                                  style: cardFontDark(17),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        pharmacyCardModel.registrationID ??
                                            "------",
                                        style: cardFontDark(14)),
                                    Text(pharmacyCardModel.contact ?? "------",
                                        style: cardFontDark(14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // -------------------------Location icon button
                        Expanded(
                          flex: 1,
                          child: LocationIconButton(
                              pharmacyCardModel: pharmacyCardModel),
                        ),
                      ],
                    ),
                  ),

                  //----------------- medicine detail card
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemExtent: 250,
                      itemCount: pharmacyCardModel.pharmacyCardStrock!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, medicineCardIndex) =>
                          MedicineCardComp(
                        pharmacyIndex: pharmacyCardIndex,
                        medicineIndex: medicineCardIndex,
                        pharmacyCardModel: pharmacyCardModel,
                        medicineCardModel: pharmacyCardModel
                            .pharmacyCardStrock![medicineCardIndex],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //---- favourit pharmacy selecting button
          Positioned(
            left: 10,
            top: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Bootstrap.heart,
                color: Color(0xFFFF78C4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationIconButton extends StatelessWidget {
  const LocationIconButton({
    super.key,
    required this.pharmacyCardModel,
  });

  final PharmacyCardModel pharmacyCardModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getscreenSize(context).width * .15,
      height: getscreenSize(context).width * .15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [
          const Color(0xFFBA5370).withOpacity(.3),
          const Color(0xFFF4E2D8).withOpacity(.3),
        ]),
      ),
      child: IconButton(
          onPressed: () {
            showDialogBox(
                'Location', "location- ${pharmacyCardModel.location}");
          },
          icon: const Icon(
            Bootstrap.pin_map_fill,
            color: Colors.white,
            size: 30,
          )),
    );
  }
}
