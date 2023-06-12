import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/features/pharmacy/controllers/orders/orders_controller.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class OrdersCard extends StatelessWidget {
  OrdersCard({
    super.key,
    required this.list,
    required this.index,
  });
  final OrdersController _controller = Get.put(OrdersController());
  final List<QueryDocumentSnapshot<Object?>> list;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    _controller.medicineIDMap = list[index]['medicine-map'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              decoration: roundIcon(Colors.blue),
              height: screenSize.height * .1,
              width: screenSize.width * .1,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Logger().i("clieck");
               // Get.toNamed(Routes.ORDERDATAILS);
              },
              child: Container(
                decoration: deco(),
                margin: const EdgeInsets.only(left: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                height: screenSize.height * .1,
                width: screenSize.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Date: ${list[index]['date']}',
                          style: GoogleFonts.adamina(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'time: ${list[index]['time']}',
                          style: GoogleFonts.adamina(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration deco() => BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, -2),
          blurRadius: 10,
          spreadRadius: 5,
          color: Colors.black.withOpacity(.2),
        ),
      ],
    );

BoxDecoration roundIcon(Color color) => BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, -2),
          blurRadius: 10,
          spreadRadius: 5,
          color: Colors.black.withOpacity(.2),
        ),
      ],
    );
