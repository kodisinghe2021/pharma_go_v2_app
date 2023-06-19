import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';

class HistoryCard extends StatelessWidget {
  HistoryCard({
    required this.cartModel,
    required this.statusCode,
    super.key,
  });
  final CartModel cartModel;
  final int statusCode;

  final List<String> statusList = [
    'Pending',
    'Accepted',
    'Wrapping',
    'Delevered',
  ];
  final List<Color> statusColor = [
    const Color(0xFFB70404),
    const Color(0xFFF79327),
    const Color(0xFF11009E),
    const Color(0xFF00ff00),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      height: getscreenSize(context).height * .15,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${cartModel.medicineName}",
                    style: historyCardFont(),
                  ),
                  Text(
                    "pharmacy - ${cartModel.pharmacyName}",
                    style: historyCardFont(size: 15),
                  ),
                  Text(
                    "${cartModel.date}   ${cartModel.time}",
                    style: historyCardFont(size: 15),
                  ),
                  Text(
                    "price - Rs.${cartModel.price}.00",
                    style: historyCardFont(size: 14, weight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    color: statusColor[statusCode], //Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    statusList[statusCode],
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.toNamed(Routes.PAYPAGE),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C134F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Pay",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 25,
                              color: const Color(0xFFE8F6EF),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Icon(
                            Bootstrap.credit_card_2_front,
                            color: Color(0xFFE8F6EF),
                          ),
                        ),
                      ],
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
//------------------------------------------------------   compononts
}

TextStyle historyCardFont(
        {double size = 20, FontWeight weight = FontWeight.bold}) =>
    GoogleFonts.roboto(
      fontSize: size,
      fontWeight: weight,
    );
