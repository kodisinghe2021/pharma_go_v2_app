import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_go_v2_app/app/client/controllers/home/home_controller.dart';
import 'package:pharma_go_v2_app/app/client/presentation/pages/home/widgets/top_bar.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  final HomeController _controller = Get.put(HomeController());
  //* build method
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //^ body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => Column(
//*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            children: [
              // -- image selecting buttons
              SizedBox(
                width: screenSize.width,
                height: screenSize.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextIconButton(
                      iconData: Bootstrap.camera_fill,
                      text: "Capture Note",
                      onTap: () async {
                        controller.searchCompleted.value = false;

                        await controller.setImageFilePath(ImageSource.camera);
                      },
                    ),
                    TextIconButton(
                      onTap: () async {
                        controller.searchCompleted.value = false;

                        await controller.setImageFilePath(ImageSource.gallery);
                      },
                      iconData: Bootstrap.image_fill,
                      text: "Select from \n Gallery",
                    ),
                    TextIconButton(
                      onTap: () async {
                        _controller.visibilityO.value = false;
                      },
                      iconData: Bootstrap.bag_x,
                      text: "Select from \n Gallery",
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenSize.width,
                height: screenSize.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextIconButton(
                      iconData: Bootstrap.cart3,
                      text: "Add to cart",
                      onTap: () async {
                        await _controller.setData();
                      },
                    ),
                  ],
                ),
              ),

              //this container visible only image is selected
              Visibility(
                visible: _controller.visibilityO.value,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.amber),
                  width: screenSize.width,
                  height: screenSize.height * .4,
                  child: Center(
                    child: Image.file(
                      File(_controller.imageFilePath.value),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: !_controller.isTextExtracted.value,
                child: SizedBox(
                  width: screenSize.width * .8,
                  height: screenSize.height * .07,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _controller.extractTextFromImage();
                    },
                    child: _controller.isReading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            "read text",
                            style: GoogleFonts.actor(fontSize: 20),
                          ),
                  ),
                ),
              ),
              Visibility(
                visible: _controller.isTextExtracted.value,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                  width: screenSize.width,
                  height: screenSize.height * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(_controller.textMapList[0]['name'].toString()),
                      // Text(_controller.textMapList[0]['dosage'].toString()),
                      // Text(_controller.textMapList[0]['days'].toString()),
                      // Text(_controller.textMapList[1]['name'].toString()),
                      // Text(_controller.textMapList[1]['dosage'].toString()),
                      // Text(_controller.textMapList[1]['days'].toString()),
                      // Text(_controller.textMapList[2]['name'].toString()),
                      // Text(_controller.textMapList[2]['dosage'].toString()),
                      // Text(_controller.textMapList[2]['days'].toString()),
                      // Text(_controller.textMapList[3]['name'].toString()),
                      // Text(_controller.textMapList[4]['name'].toString()),
                      // Text(_controller.textMapList[5]['name'].toString()),
                      // Text(_controller.textMapList[6]['name'].toString()),
                      // Text(_controller.textMapList[7]['name'].toString()),
                      // Text(_controller.textMapList[8]['name'].toString()),
                      Text(_controller.textMapList.length.toString()),
                    ],
                  ),
                ),
              ),
//^++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// this is the result list
              Container(
                width: screenSize.width,
                height: screenSize.height * .5,
                decoration: const BoxDecoration(color: Colors.brown),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _controller.setData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: screenSize.width,
                          height: screenSize.height * .3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  "pharmacy name- ${snapshot.data![index]['phamacyName']}"),
                              Text(
                                  "location- ${snapshot.data![index]['location']}"),
                              Text(
                                  "available quantity- ${snapshot.data![index]['quantity']}"),
                              Text("price- ${snapshot.data![index]['price']}"),
                              Text(
                                  "contact- ${snapshot.data![index]['contact']}"),
                              Text(
                                  "reg No- ${snapshot.data![index]['registrationID']}"),
                            ],
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
              // //^ header buttons
              // SizedBox(
              //   width: screenSize.width,
              //   height: screenSize.height * .07,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       TextIconButton(
              //         iconData: Bootstrap.camera_fill,
              //         text: "Capture Note",
              //         onTap: () async {
              //           controller.searchCompleted.value = false;

              //           await controller.setImageFilePath(ImageSource.camera);
              //         },
              //       ),
              //       TextIconButton(
              //         onTap: () async {
              //           controller.searchCompleted.value = false;

              //           await controller.setImageFilePath(ImageSource.gallery);
              //         },
              //         iconData: Bootstrap.image_fill,
              //         text: "Select from \n Gallery",
              //       )
              //     ],
              //   ),
              // ),
              // controller.imagePath.value.isNotEmpty
              //     ? FlipCard(
              //         controller: controller.flipCardController,
              //         flipOnTouch: true,
              //         onFlip: () {},
              //         speed: 1000,
              //         fill: Fill
              //             .fillBack, // Fill the back side of the card to make in the same size as the front.
              //         direction: FlipDirection.HORIZONTAL, // default
              //         side: controller
              //             .currentCardSide, // The side to initially display.
              //         front: NoteContainer(
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(30),
              //             child: Image.file(
              //               controller.imageFile,
              //               fit: BoxFit.fill,
              //             ),
              //           ),
              //         ),
              //         back: NoteContainer(
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(30),
              //             child: Center(
              //               child: controller.scannedText.isNotEmpty
              //                   ? Text(
              //                       controller.scannedText[0],
              //                       style: const TextStyle(fontSize: 10),
              //                     )
              //                   : const Center(
              //                       child: CircularProgressIndicator(),
              //                     ),
              //             ),
              //           ),
              //         ),
              //       )
              //     : Text(
              //         "waiting for an image....${controller.imageFile.path}",
              //       ),

              // const SizedBox(height: 20),
              // CustomOutLinedButton(
              //   isSearching: controller.textScanning.value,
              //   text: 'Read Note',
              //   onTap: () async {
              //     controller.textScanning.value = true;
              //     //!.........................................reading text here

              //  //   await controller.readNote();

              //     controller.textScanning.value = false;
              //     controller.flipCardController.toggleCard();
              //   },
              // ),
              // const SizedBox(height: 20),
              // if (!controller.searchCompleted.value)
              //   CustomOutLinedButton(
              //     isSearching: controller.searching.value,
              //     text: 'Search',
              //     onTap: () async {
              //       //!.........................................reading text here
              //       Logger().i("tapped");
              //       await controller.updateUserHistoryList();
              //       Logger().i("after method");
              //       controller.searchCompleted.value = true;
              //       //controller.flip();
              //     },
              //   ),
              // const SizedBox(height: 20),
              // CustomOutLinedButton(
              //   text: 'Text identifier',
              //   onTap: () async {
              //     //!.........................................reading text here
              //     List<dynamic> list = controller.scannedText;
              //     String listitem01 = list[0];
              //     Logger().i('scannedText[0] --> ${list[0]}');
              //     //controller.flip();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iteratingWidgets(List list) {
    for (var element in list) {
      return Text(element);
    }
    return Text('end -- ${list.length}');
  }
}
