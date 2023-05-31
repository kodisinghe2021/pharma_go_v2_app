import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/client/controllers/home/home_controller.dart';
import 'package:pharma_go_v2_app/app/client/presentation/pages/home/widgets/top_bar.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/alert_boxes/get_alert.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  final HomeController _controller = Get.put(HomeController());
  //* build method
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
//----------------------------------------------------------- bottom naviagation bar
      bottomNavigationBar: Container(
        width: screenSize.width,
        height: screenSize.height * .08,
        decoration: BoxDecoration(color: Colors.amber.withOpacity(.4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // capture image
            TextIconButton(
              iconData: Bootstrap.camera_fill,
              text: "Capture Note",
              onTap: () async {
                //clear readad data
                _controller.isTextExtracted.value = false;

                await _controller.setImageFilePath(ImageSource.camera);
              },
            ),

            // select image from galary
            TextIconButton(
              onTap: () async {
                _controller.isTextExtracted.value = false;

                await _controller.setImageFilePath(ImageSource.gallery);
              },
              iconData: Bootstrap.image_fill,
              text: "Select from \n Gallery",
            ),
            //----------- open readed text
            Obx(
              () => IconButton(
                onPressed: () async {
                  _controller.readingText.value = true;
                  await _controller.extractTextFromImage();
                  _controller.readingText.value = false;
                },
                icon: _controller.readingText.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Icon(Bootstrap.search),
              ),
            ),

            //------------ open pharmacy list for orders
            IconButton(
              onPressed: () async {
                _controller.isPharmacyOpen.value =
                    !_controller.isPharmacyOpen.value;
              },
              icon: _controller.isReading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(Bootstrap.menu_down),
            ),
          ],
        ),
      ),
//----------------------------------------------------------- bottom naviagation bar END
//----------------------------------------------------------- Body
      body: Obx(
        () => Column(
          children: [
//---------------------------------------------------------- visible area 01
            Visibility(
              visible: _controller.imageFilePath.value.isNotEmpty &&
                  !_controller.isPharmacyOpen.value,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                // decoration: const BoxDecoration(color: Colors.amber),
                width: screenSize.width,
                height: screenSize.height * .3,
                child: Center(
                  child: Image.file(
                    File(_controller.imageFilePath.value),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            // this data will be apear only if text is extracted
            Visibility(
              visible: _controller.isTextExtracted.value &&
                  !_controller.isPharmacyOpen.value,
              child: Container(
                decoration: const BoxDecoration(color: Colors.blue),
                width: screenSize.width,
                height: screenSize.height * .4,
                child: ListView.builder(
                  itemCount: _controller.textMapList.length,
                  itemBuilder: (context, index) => ListTile(
                    leading:
                        Text(_controller.textMapList[index]['days'].toString()),
                    title:
                        Text(_controller.textMapList[index]['name'].toString()),
                    subtitle: Text(
                        _controller.textMapList[index]['dosage'].toString()),
                  ),
                ),
              ),
            ),
//---------------------------------------------------------- visible area 01 END

//---------------------------------------------------------- visible area 02
            // this is the result list
            Visibility(
              visible: _controller.isTextExtracted.value &&
                  _controller.isPharmacyOpen.value,
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height * .7,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _controller.setData(),
                  builder: (context, snapshot) {
                    // if snapshot has error then this
                    if (snapshot.hasError) {
                      return showDialogBox('Somthing went wrong', 'try again');
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => MedicinePharmacyCard(
                          snapshotData: snapshot.data,
                          index: index,
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            //---------------------------------------------------------- visible area 02 END
          ],
        ),
      ),
    );
  }
}

class MedicinePharmacyCard extends StatelessWidget {
  const MedicinePharmacyCard({
    super.key,
    this.snapshotData,
    required this.index,
  });

  final List<Map<String, dynamic>>? snapshotData;
  final int index;
  @override
  Widget build(BuildContext context) {
    // vatiavles
    final Size screenSize = MediaQuery.of(context).size;
    Map<String, dynamic> singleMap = snapshotData![index];
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
                  border: Border.all(width: 1, color: Colors.black)),
              width: screenSize.width,
              height: screenSize.height * .32,
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
                                    snapshotData![index]['phamacyName'],
                                    21,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: thisPageFonts(
                                    snapshotData![index]['registrationID'],
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
                                    snapshotData![index]['contact'],
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
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: strockMap.length,
                          itemBuilder: (context, strockListIndex) {
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
                            double totalDos = totalDosage(
                              days: snapshotData![index]['strockList']
                                  [strockListIndex]['days'],
                              freq: snapshotData![index]['strockList']
                                  [strockListIndex]['frequency'],
                              RecomendedDosage: snapshotData![index]
                                      ['strockList'][strockListIndex]
                                  ['dosage_in_note'],
                            );

                            double priceOfSinlgeMedicine = medicinePrice(
                              totalDos: totalDos,
                              price: snapshotData![index]['strockList']
                                  [strockListIndex]['price'],
                              dosageOfMedicine: snapshotData![index]
                                      ['strockList'][strockListIndex]
                                  ['dosage_in_medicine'],
                            );
                            return Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                              height: screenSize.height * .1,
                              width: screenSize.width * .4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 3,
                                    color: Colors.black
                                        .withOpacity(.1) // Colors.transparent,
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
                                          snapshotData![index]['strockList']
                                              [strockListIndex]['name'],
                                          20),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: priceCardFont(
                                        "tablet dossage- ${snapshotData![index]['strockList'][strockListIndex]['dosage_in_medicine']}",
                                        10,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: priceCardFont(
                                        "recomended dosage-- ${snapshotData![index]['strockList'][strockListIndex]['dosage_in_note']}",
                                        10,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: priceCardFont(
                                        "Price for this -- $priceOfSinlgeMedicine",
                                        10,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: () {
                                          Logger().i("Tapped");
                                        },
                                        icon: const Icon(
                                          Bootstrap.plus,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.red,
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
                        "location- ${snapshotData![index]['location']}");
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

  Text thisPageFonts(String text, double fontSize) => Text(
        text,
        style: GoogleFonts.acme(
            color: const Color.fromARGB(255, 1, 1, 1), fontSize: fontSize),
      );
  Text priceCardFont(String text, double fontSize) => Text(
        text,
        style: GoogleFonts.acme(
            color: const Color.fromARGB(255, 252, 252, 252),
            fontSize: fontSize),
      );
}

//total dosage in mg
double totalDosage({
  required String days,
  required String freq,
  required String RecomendedDosage,
}) {
  final doubleDays = double.parse(days.replaceAll(RegExp(r'[^0-9]'), ''));
  final doubleFreq = double.parse(freq.replaceAll(RegExp(r'[^0-9]'), ''));
  final doubleDos =
      double.parse(RecomendedDosage.replaceAll(RegExp(r'[^0-9]'), ''));

  // formula
  return doubleDays * doubleFreq * doubleDos;
}

double medicinePrice({
  required double totalDos,
  required String price,
  required String dosageOfMedicine,
}) {
  return double.parse(price.replaceAll(RegExp(r'[^0-9]'), '')) *
      (totalDos /
          double.parse(dosageOfMedicine.replaceAll(RegExp(r'[^0-9]'), '')));
}
