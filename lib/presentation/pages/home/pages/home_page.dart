import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/controllers/home/home_controller.dart';
import 'package:pharma_go_v2_app/models/scanned_data_mockup.dart';
import 'package:pharma_go_v2_app/presentation/pages/home/widgets/note_container.dart';
import 'package:pharma_go_v2_app/presentation/pages/home/widgets/top_bar.dart';
import 'package:pharma_go_v2_app/presentation/widgets/components/button/out_lined_buttons/text_outlined_button.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  final HomeController controller = Get.put(HomeController());
  //* build method
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //^ body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //^ header buttons
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * .07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextIconButton(
                    iconData: Bootstrap.camera_fill,
                    text: "Capture Note",
                    onTap: () async {
                      Logger().i("clicked");
                      await controller.getImage(ImageSource.camera);
                      Logger().i("captured");
                    },
                  ),
                  TextIconButton(
                    onTap: () async {
                      Logger().i("clicked");
                      await controller.getImage(ImageSource.gallery);
                      Logger().i("captured");
                    },
                    iconData: Bootstrap.image_fill,
                    text: "Select from \n Gallery",
                  )
                ],
              ),
            ),

            Obx(
              () => controller.imageFile.path.isNotEmpty
                  ? FlipCard(
                      controller: controller.flipCardController,
                      flipOnTouch: true,
                      onFlip: () {
                        Logger().i("flipping");
                      },
                      speed: 1000,
                      fill: Fill
                          .fillBack, // Fill the back side of the card to make in the same size as the front.
                      direction: FlipDirection.HORIZONTAL, // default
                      side: controller
                          .currentCardSide, // The side to initially display.
                      front: NoteContainer(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.file(
                            File(controller.filePath.value),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      back: NoteContainer(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Center(
                            child: controller.scannedText.value.isNotEmpty
                                ? Text(
                                    controller.scannedText.value,
                                    style: const TextStyle(fontSize: 10),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      "waiting for an image....${controller.filePath.value}"),
            ),
            const SizedBox(height: 20),
            CustomOutLinedButton(
              text: 'Search',
              onTap: () async {
                //!.........................................reading text here
                Logger().i("tapped");
                await controller.getRecognizedText();
                await controller.uploadImage();
                Logger().i("after method");
                //controller.flip();
              },
            ),
            const SizedBox(height: 20),
            CustomOutLinedButton(
              text: 'add Medicine',
              onTap: () async {
                Logger().i("tapped");
                await controller.addMedicine(
                  name: medicineNote_01[0]['name'].toString(),
                  dosage: medicineNote_01[0]['dosage'].toString(),
                );
                Logger().i("after method");
                //controller.flip();
              },
            ),
            const SizedBox(height: 20),
            controller.isFinding.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomOutLinedButton(
                    text: 'find medicine',
                    onTap: () async {
                      controller.isFinding.value = true;
                      Logger().i("tapped");
                      await controller.createMedicineNote(medicineNote_01);
                      Logger().i("after method");
                      controller.isFinding.value = false;
                      //controller.flip();
                    },
                  ),
            const SizedBox(height: 20),
            if (controller.medicineIDList.isNotEmpty)
              Text(controller.medicineIDList[0]),
            Text(
                '${controller.medicineListMap.keys} : ${controller.medicineListMap.values}'),
            CustomOutLinedButton(
              text: 'show Date Time',
              onTap: () async {
                Logger().i("tapped");
                List<String> ll = controller.getCurrentDate();
                Logger().i("after method");

                Logger().i(ll.length);
                Logger().i('${ll[0]} -- ${ll[1]}');
                //controller.flip();
              },
            ),
            // Text(controller.medicineIDList[1]),
            // Text(controller.medicineIDList[2]),
            // Text(controller.medicineIDList[3]),
            //   primary: false,
            //   shrinkWrap: true,
            //   itemCount: 10,
            //   itemBuilder: (context, index) => SearchResultCard(
            //     index: index,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
