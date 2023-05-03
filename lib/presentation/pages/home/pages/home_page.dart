import 'dart:io';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/controllers/home/home_controller.dart';
import 'package:pharma_go_v2_app/presentation/pages/home/widgets/card/search_result_card.dart';
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
                            fit: BoxFit.cover,
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
                                : const Text(
                                    "Contrary to popular belief, \nLorem Ipsum is not simply random text. \nIt has roots in a piece of classical \nLatin literature from 45 BC, making it\nover 2000 years old. Richard McClintock,.",
                                    textAlign: TextAlign.center,
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
              onTap: () async {
                //!.........................................reading text here
                Logger().i("tapped");
                await controller.getRecognisedText();
                Logger().i("after method");
                //controller.flip();
              },
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => SearchResultCard(
                index: index,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
