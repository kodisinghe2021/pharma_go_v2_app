import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicineListCard extends StatelessWidget {
  const MedicineListCard({
    required this.index,
    required this.dataMapList,
    super.key,
  });

  final int index;
  final List<Map<String, dynamic>> dataMapList;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> dataMap = dataMapList[index];
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
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
          height: screenSize.height * .1,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              dataMap['name'],
                              style: GoogleFonts.acme(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              dataMap['dosage'] + 'mg',
                              style: GoogleFonts.acme(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            dataMap['brand'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Strock',
                        style: GoogleFonts.acme(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () async {
                          Get.defaultDialog();
                        },
                        child: Container(
                          // margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFDF4F5),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.4),
                                    offset: const Offset(0, 1),
                                    blurRadius: 10,
                                    spreadRadius: 1),
                              ]),
                          child: Center(
                            child: Text(
                              dataMap['quantity'],
                              style: GoogleFonts.acme(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
