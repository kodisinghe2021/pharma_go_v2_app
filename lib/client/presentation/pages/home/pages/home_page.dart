import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/client/controllers/home/home_controller.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/home/widgets/note_container.dart';
import 'package:pharma_go_v2_app/client/presentation/pages/home/widgets/top_bar.dart';
import 'package:pharma_go_v2_app/client/presentation/widgets/components/button/out_lined_buttons/text_outlined_button.dart';

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
        child: Obx(
          () => Column(
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
                        controller.searchCompleted.value = false;
                        Logger().i("clicked");
                        await controller.setImageFilePath(ImageSource.camera);
                        Logger().i("captured ${controller.imageFile.path}");
                      },
                    ),
                    TextIconButton(
                      onTap: () async {
                        controller.searchCompleted.value = false;
                        Logger().i("clicked");
                        await controller.setImageFilePath(ImageSource.gallery);
                        Logger().i("captured ${controller.imageFile.path}");
                      },
                      iconData: Bootstrap.image_fill,
                      text: "Select from \n Gallery",
                    )
                  ],
                ),
              ),
              controller.imagePath.value.isNotEmpty
                  ? FlipCard(
                      controller: controller.flipCardController,
                      flipOnTouch: true,
                      onFlip: () {},
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
                            controller.imageFile,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      back: NoteContainer(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Center(
                            child: controller.scannedText.isNotEmpty
                                ? Text(
                                    controller.scannedText[0],
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
                      "waiting for an image....${controller.imageFile.path}",
                    ),

              const SizedBox(height: 20),
              CustomOutLinedButton(
                isSearching: controller.textScanning.value,
                text: 'Read Note',
                onTap: () async {
                  controller.textScanning.value = true;
                  //!.........................................reading text here

                  await controller.readNote();

                  controller.textScanning.value = false;
                  controller.flipCardController.toggleCard();
                },
              ),
              const SizedBox(height: 20),
              if (!controller.searchCompleted.value)
                CustomOutLinedButton(
                  isSearching: controller.searching.value,
                  text: 'Search',
                  onTap: () async {
                    //!.........................................reading text here
                    Logger().i("tapped");
                    await controller.updateUserHistoryList();
                    Logger().i("after method");
                    controller.searchCompleted.value = true;
                    //controller.flip();
                  },
                ),
              const SizedBox(height: 20),
              CustomOutLinedButton(
                text: 'Text identifier',
                onTap: () async {
                  //!.........................................reading text here
                  List<dynamic> list = controller.scannedText;
                  String listitem01 = list[0];
                  Logger().i('scannedText[0] --> ${list[0]}');
                  //controller.flip();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
