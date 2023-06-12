import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/features/client/constant/fonts.dart';
import 'package:pharma_go_v2_app/features/client/controllers/home/home_controller.dart';
import 'package:pharma_go_v2_app/features/client/presentation/pages/home/widgets/medicin_card.dart';
import 'package:pharma_go_v2_app/features/client/presentation/widgets/alert_boxes/get_alert.dart';

class MedicinePharmacyCard extends StatelessWidget {
  MedicinePharmacyCard({
    super.key,
    this.snapshotData,
    required this.pharmacyCardIndex,
  });

  final HomeController _controller = Get.put<HomeController>(HomeController());

  final List<Map<String, dynamic>>? snapshotData;
  final int pharmacyCardIndex;
  @override
  Widget build(BuildContext context) {
    // variables
    final Size screenSize = MediaQuery.of(context).size;
    Map<String, dynamic> singleMap = snapshotData![pharmacyCardIndex];
    List<Map<String, dynamic>> strockMap = singleMap['strockList'];

    //---------------
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      width: screenSize.width,
      height: screenSize.height * .35,

//------------------------------------- back layer Container
      child: Stack(
        children: [
          //-- main data set
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    const Color(0xFFc0392b).withOpacity(.6),
                    const Color(0xff8e44ad).withOpacity(.6),
                  ])),
              width: screenSize.width,
              height: screenSize.height * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //-- top bar
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: thisPageFonts(
                                    snapshotData![pharmacyCardIndex]
                                        ['pharmacyID'],
                                    21,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: thisPageFonts(
                                    snapshotData![pharmacyCardIndex]
                                        ['registrationID'],
                                    14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: thisPageFonts(
                                    snapshotData![pharmacyCardIndex]['contact'],
                                    18,
                                  ),
                                ),
                              ),
                              const Spacer(flex: 1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: strockMap.length,
                          itemBuilder: (context, medicineCardIndex) {
                            return snapshotData == null
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MedicineCard(
                                    snapshotData: snapshotData ?? [],
                                    pharmacyCardIndex: pharmacyCardIndex,
                                    medicineCardIndex: medicineCardIndex,
                                  );
                          }),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Logger().i("Tapped all item");
                          },
                          icon: const Icon(
                            Bootstrap.cart4,
                            color: Color(0xFFFDE2F3),
                          ),
                        ),
                        // Obx(
                        //   () => thisPageFonts(
                        //       // _controller.itemCount.value.toString(), 15),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

//-----------------------------front layer Icon Circal
          Positioned(
            top: 0,
            right: 10,
            child: Container(
              width: screenSize.width * .15,
              height: screenSize.width * .15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  const Color(0xFFBA5370).withOpacity(.3),
                  const Color(0xFFF4E2D8).withOpacity(.3),
                ]),
              ),
              child: IconButton(
                  onPressed: () {
                    showDialogBox('Location',
                        "location- ${snapshotData![pharmacyCardIndex]['location']}");
                  },
                  icon: const Icon(
                    Bootstrap.pin_map_fill,
                    color: Color(0xFFF11712),
                    size: 30,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
